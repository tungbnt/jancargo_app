import 'dart:ui';

import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../domain/dtos/detail_product/detail/detail_dto.dart';
import '../../../modules/web_view/screen/web_view.dart';
import 'package:html/parser.dart' as html;

class CustomExpandText extends StatefulWidget {
  const CustomExpandText({super.key, this.code, required this.site, required this.descriptions});
  final String? code;
  final String site;
  final String? descriptions;

  @override
  State<CustomExpandText> createState() => _CustomExpandTextState();
}

class _CustomExpandTextState extends State<CustomExpandText> {
  final ValueNotifier<bool> isExpanded = ValueNotifier(false);
  ValueNotifier<bool> isHtml = ValueNotifier(false);
 @override
 Widget build(BuildContext context) {
   return ValueListenableBuilder<bool>(
     valueListenable: isExpanded,
     builder: (context,_,__) {
       // Sử dụng thư viện html để parse chuỗi và kiểm tra xem có phải là HTML không
       var document = html.parse(widget.descriptions);
       if(document.body != null && document.body!.nodes.isNotEmpty){
         isHtml.value = true;
       }
       return Padding(
         padding:  EdgeInsets.only(top: AppGap.h10,right: AppGap.h10,left: AppGap.h10,),
         child: Stack(
           children: [
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Mô tả',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: (){
                                 RouteService.routeGoOnePage(WebViewScreen(url: "https://jancargo.com/${widget.site}/trans/${widget.code!}?gt=1#googtrans(vi)",),);
                            },
                            child: Container(
                              width: 66,
                              padding: EdgeInsets.all(AppGap.h3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(AppGap.r8)),
                                  border: Border.all(color: AppColors.neutral300Color,width: 1),
                                  color: AppColors.neutral100Color
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.g_translate,color: AppColors.primary900Color),
                                  Text('dịch',style: AppStyles.text6014(color: AppColors.primary900Color),),
                                ],

                              ),
                            ),
                          )
                        ],
                      ),
                      const Divider(),
                    ],
                  ),
                 CustomExpandableText(

                   maxLines: 100, // Điều chỉnh số dòng tối đa trước khi "Read More"
                   isExpanded: isExpanded, text:  widget.descriptions!,isHtml: isHtml,
                 ),
                 isExpanded.value ? const Divider() : const SizedBox.shrink(),
                 if(isHtml.value == false)
                 InkWell(
                   onTap: () {
                     setState(() {
                       isExpanded.value = !isExpanded.value;
                     });
                   },
                   child: Ink(
                     height: !isExpanded.value ? 60 : 40,
                     padding: !isExpanded.value ? EdgeInsets.only(top: AppGap.h5) : EdgeInsets.only(bottom: AppGap.h5),
                     width: double.infinity,
                     color: Colors.white,

                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [

                         Text(
                           !isExpanded.value ?  'Xem thêm' :  'Thu gọn',
                           style: const TextStyle(
                             color: Colors.red,
                           ),
                         ),
                         isExpanded.value ? const Icon(Icons.keyboard_arrow_up_sharp) : const Icon(Icons.keyboard_arrow_down_outlined),
                       ],
                     ),
                   ),
                 ),
               ],
             ),
             if(!isExpanded.value && isHtml.value == false)
             Positioned(
               top: 68.h,
               left: 0,
               right: 0,
               child: GestureDetector(
                 onTap: () {
                   setState(() {
                     isExpanded.value = !isExpanded.value;
                   });
                 },
                 child: Container(
                   decoration: BoxDecoration(
                     gradient: LinearGradient(
                       begin: Alignment.topCenter,
                       end: Alignment.bottomCenter,
                       colors: [
                         Colors.white.withOpacity(0.3),
                         Colors.white.withOpacity(0.425),
                         Colors.white.withOpacity(0.6),
                         Colors.white.withOpacity(0.725),
                       ],
                     ),
                   ),
                   height: 68.h,
                   width: double.infinity,
                 ),
               ),
             ),
           ],
         ),
       );
     }
   );
 }
}

class CustomExpandableText extends StatelessWidget {
  final String text;
  final int maxLines;
  final ValueNotifier<bool> isExpanded;
  final ValueNotifier<bool> isHtml;

  CustomExpandableText({super.key,
    required this.text,
    required this.maxLines,
    required this.isExpanded, required this.isHtml,
  });

  double textHeightRatio = 0.5; // Tỉ lệ của đoạn văn bản trên màn hình (2/3 trong trường hợp này)

  ValueNotifier<String> firstTwoLines = ValueNotifier('');


  List<String> getTwoLinesProportionally(String text, double heightRatio,BuildContext context) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(fontSize: 16.0),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: MediaQuery.of(context).size.width);

    final textHeight = textPainter.size.height;
    final maxTextHeight = MediaQuery.of(context).size.height * heightRatio;
    final maxLinesToShow = (maxTextHeight / textHeight).floor();

    final textLines = text.split('\n');
    final visibleLines = textLines.take(maxLinesToShow).toList();
    return visibleLines;
  }


  @override
  Widget build(BuildContext context) {

    final ellipsisTextSpan = TextSpan(
      text: ' ',
      style: TextStyle(
        fontSize: 16,
        color: Colors.black.withOpacity(0.2), // Adjust the opacity here
      ),
    );
    double blurHeight = 44.0; // Chiều cao của dòng cần làm mờ (có thể điều chỉnh)
    double blurStrength = 5.0;
    return ValueListenableBuilder(
      valueListenable: isExpanded,
      builder: (context,_,__) {
            // Chia đoạn văn bản thành danh sách các dòng
            List<String> lines = text.split('\n');
            // Lấy hai dòng đầu tiên
            firstTwoLines = ValueNotifier(lines.length >= 2 ? lines.sublist(0, 2).join('\n') : text);

        return ValueListenableBuilder(
          valueListenable: firstTwoLines,
          builder: (context,_,__) {
            return Stack(
              fit: StackFit.loose,
              children: [
                isHtml.value ? Html(data: text) : RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: isExpanded.value
                            ? text
                            : firstTwoLines.value,
                        style: const TextStyle(
                          fontSize: 16,color: Colors.black
                        ),
                      ),
                      if (!isExpanded.value ) ellipsisTextSpan,
                    ],
                  ),
                  maxLines: !isExpanded.value ? 4 : maxLines,
                  overflow: TextOverflow.ellipsis,
                ),

              ],
            );
          }
        );
      }
    );
  }
}
class ReadMoreExample extends StatefulWidget {
  const ReadMoreExample({super.key});

  @override
  _ReadMoreExampleState createState() => _ReadMoreExampleState();
}

class _ReadMoreExampleState extends State<ReadMoreExample> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    String text =
        'This is a long text. This is the last line that will be blurred.';
    double blurHeight = 24.0; // Chiều cao của dòng cần làm mờ
    double blurStrength = 5.0; // Sức mạnh của làm mờ
    int? maxLines = isExpanded ? null : 2; // Số dòng tối đa khi chưa "read more"

    List<Widget> textWidgets = text.split('\n').map((line) {
      return Text(
        line,
        style: const TextStyle(fontSize: 16.0),
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
      );
    }).toList();

    List<Widget> blurredWidgets = List.from(textWidgets);
    if (isExpanded) {
      blurredWidgets.last = Container(
        height: blurHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.transparent,
              Colors.white.withOpacity(0.0),
              Colors.white.withOpacity(0.7),
            ],
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurStrength, sigmaY: blurStrength),
          child: blurredWidgets.last,
        ),
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: blurredWidgets,
          ),
          if (!isExpanded)
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = true;
                });
              },
              child: Container(
                alignment: Alignment.center,
                color: Colors.white.withOpacity(0.7),
                height: blurHeight,
                child: const Text(
                  'Read More',
                  style: TextStyle(fontSize: 16.0, color: Colors.blue),
                ),
              ),
            ),
        ],
      ),
    );
  }
}