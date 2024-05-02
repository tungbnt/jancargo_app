import 'package:flutter/material.dart';

import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_storage.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_gap.dart';

class ItemStoreName extends StatefulWidget {
  const ItemStoreName({super.key, required this.current, required this.getIndex});
  final ValueNotifier<int> current;
  final ValueSetter<int> getIndex;

  @override
  State<ItemStoreName> createState() => _ItemStoreNameState();
}

class _ItemStoreNameState extends State<ItemStoreName> {
  final ScrollController _scrollController = ScrollController();

 @override
  void initState() {
    super.initState();
    // scrollToIndex(widget.current.value);
  }
  void scrollToIndex(int index) {
      print('_scrollController.hasClients ${_scrollController.hasClients}');
      _scrollController.animateTo(
        index * AppGap.h48, // Chiều cao ước lượng của mỗi item (56.0 là giả định)
        duration: Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
      );

  }
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToIndex(widget.current.value);
    });
    return Container(
      height: AppGap.h48,
      padding: EdgeInsets.symmetric(
          horizontal: AppGap.w10, vertical: AppGap.h10),
      color: AppColors.white,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          // physics: const ClampingScrollPhysics(),
          itemBuilder: (context, int i) {
            return _itemStore(AppStorage.items[i]['text'], i);
          },
          separatorBuilder: (context, int i) {
            return AppGap.sbW8;
          },
          itemCount: AppStorage.items.length),
    );
  }

  Widget _itemStore(String text, int i) => ValueListenableBuilder(
    valueListenable: widget.current,
    builder: (BuildContext context, value, Widget? child) {
      return InkWell(
        onTap: () {
          widget.current.value = i;
          widget.getIndex.call(i);
        },
        child: Container(
          height: AppGap.h32,
          padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.current.value == i
                ? AppColors.yellow800Color
                : AppColors.white,
            border: Border.all(
                width: 1,
                color:  widget.current.value == i
                    ? AppColors.yellow800Color
                    : AppColors.neutral300Color),
            borderRadius: BorderRadius.all(Radius.circular(AppGap.r4)),
          ),
          child: Text(
            text,
            style: AppStyles.text4014(color: AppColors.neutral900Color),
          ),
        ),
      );
    },
  );
}
