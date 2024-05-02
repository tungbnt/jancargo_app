import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../components/resource/molecules/cached_network_shaped_image.dart';
import '../../../general/constants/app_images.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({
    super.key,
    required this.currentIndex,
    required this.imgs,
    this.borderColor = Colors.white,
    this.getCurrentIndex, required this.carouselController, required this.index,
  });

  final List<String> imgs;
  final int currentIndex;
  final int index;
  final Color borderColor;
  final ValueSetter<int>? getCurrentIndex;
  final CarouselController carouselController;

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: AppGap.w10,vertical: AppGap.h14),
      child: _item(widget.index),
    );
  }

  Widget _item(int i)=>  InkWell(
    onTap: () {
      setState(() {
        widget.getCurrentIndex?.call(i);
      });
    },
    child: CachedNetworkRectangleImage(
      height: AppGap.h60,
      width: AppGap.w64,
      imageUrl: widget.imgs[i],
      fit:BoxFit.cover,

      imageDecoration:  BoxDecoration(
      shape: BoxShape.rectangle,
      border: Border.all(
        color: widget.currentIndex == i
            ? widget.borderColor
            : Colors.transparent,
      ),
    ),
    errorWidget: Image.asset(
        AppImages.capcha,
      ),
    ),
  );
}
