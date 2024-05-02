import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jancargo_app/src/general/constants/app_storage.dart';

import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../domain/dtos/cart/item_cart/item_cart_dto.dart';
import '../../../general/app_strings/app_strings.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_convert.dart';
import '../../../util/app_gap.dart';

class StoreProd extends StatefulWidget {
  const StoreProd({super.key, required this.dto, });
  final ItemCartDto dto;


  @override
  State<StoreProd> createState() => _StoreProdState();
}

class _StoreProdState extends State<StoreProd> {
  ValueNotifier<String> name = ValueNotifier('Đang cập nhật...');

  @override
  void initState() {
    super.initState();
    nameStore();
  }

  void nameStore() async {
    name.value = await AppStorage.nameStore(widget.dto.siteCode!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        children: [
           ValueListenableBuilder(
             valueListenable: name,
             builder: (context,value,_) {
               return Padding(
                 padding:  EdgeInsets.symmetric(horizontal: AppGap.w10,vertical: AppGap.h14),
                 child: Row(
                  children: [
                    _icSite(widget.dto.siteCode!),
                    Text(value,style: AppStyles.text6016(),),
                  ],
                           ),
               );
             }
           ),
          _item(widget.dto),
        ],
      ),
    );
  }

  Widget _item(ItemCartDto item) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: AppGap.w106,
                height: AppGap.h90,
                margin: EdgeInsets.symmetric(horizontal: AppGap.w10),
                decoration: BoxDecoration(
                  color: AppColors.neutral200Color,
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppGap.r8),
                  ),
                ),
                child: AppCarouselImages(
                  fit: BoxFit.cover,
                  height: AppGap.h90,
                  // ignore: invalid_use_of_protected_member
                  imagesUrl: item.images!,
                  alignment: Alignment.topCenter,
                  borderRadius: BorderRadius.circular(AppGap.r8),
                  autoPlay: false,
                  showIndicatorBottom: false,
                  imageDecoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.circular(AppGap.r8))),
                ),
              ),
            ],
          ),
          SizedBox(
            height: AppGap.h104,
            width: AppGap.w232,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: AppGap.w208,
                  child: Text(
                    item.name!,
                    style: AppStyles.text5014(color: AppColors.neutral800Color),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: false,
                  ),
                ),
                Row(

                  children: [
                    Text('${AppStrings.of(context).nation}: Nhật Bản',
                        style:
                            AppStyles.text4012(color: AppColors.neutral600Color),),
                    const Spacer(),
                    Text('x${item.selectedAmount.value}',
                        style:
                        AppStyles.text4012(color: AppColors.neutral600Color)),
                    AppGap.sbW8,
                  ],
                ),
                AppGap.sbH10,
                Row(
                  children: [
                    const Spacer(),
                    Text(
                      AppConvert.convertAmountVn(item.price!),
                      style:
                          AppStyles.text4014(color: AppColors.neutral700Color),
                    ),
                    AppGap.sbW8,
                  ],
                ),
                AppGap.sbH10,
              ],
            ),
          ),
        ],
      );

  Widget _icSite(String site){
    return _buildImage(AppStorage.icStore(site));
  }

  Widget _buildImage(String path)=> Image.asset(path,height: 24.h,width: 24.w,);
}
