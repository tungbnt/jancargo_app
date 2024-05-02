import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';

import '../../../general/constants/app_colors.dart';
import '../../../util/app_gap.dart';
import 'cached_network_shaped_image.dart';

class AppCarouselImages extends StatefulWidget {
  AppCarouselImages({
    super.key,
    required this.imagesUrl,
    this.autoPlay,
    this.height,
    this.aspectRatio,
    this.carouselController,
    this.alignment = Alignment.center,
    this.getCurrentIndex,
    this.fit = BoxFit.cover,
    this.showIndicatorBottom = false,
    this.imageDecoration = const BoxDecoration(),
    required this.borderRadius,
  });

  final List<String> imagesUrl;
  final bool? autoPlay;
  final double? height;
  final double? aspectRatio;
  final CarouselController? carouselController;
  final Alignment alignment;
  final ValueSetter<int>? getCurrentIndex;
  final bool showIndicatorBottom;
  final BorderRadius borderRadius;
  final BoxDecoration imageDecoration;
  final BoxFit? fit;

  @override
  State<AppCarouselImages> createState() => _AppCarouselImagesState();
}

class _AppCarouselImagesState extends State<AppCarouselImages> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CarouselSlider(
              carouselController: widget.carouselController,
              options: CarouselOptions(
                height: widget.height,
                autoPlay: widget.autoPlay ?? false,
                aspectRatio: widget.aspectRatio ?? 9 / 16,
                enableInfiniteScroll: widget.imagesUrl.length > 1,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                    widget.getCurrentIndex?.call(index);
                  });
                },
              ),
              items: widget.imagesUrl.map(
                (url) {
                  return ClipRRect(
                    borderRadius: widget.borderRadius,
                    child: CachedNetworkRectangleImage(
                      imageDecoration: widget.imageDecoration,
                      imageUrl: url,
                      fit: widget.fit,
                      alignment: widget.alignment,
                      errorWidget: Image.asset(
                        AppImages.capcha,
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
            if (widget.showIndicatorBottom)
              Positioned(
                bottom: 46.h,
                right: 20.w,
                child: Carousle(
                  currentIndex: currentIndex,
                  length: widget.imagesUrl.length,
                  key: Key(currentIndex.toString()),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class Carousle extends StatelessWidget {
  Carousle({
    super.key,
    required this.length,
    required this.currentIndex,
  });

  int length;
  int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppGap.h20,
      width: AppGap.w40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.neutral300Color,
        borderRadius: BorderRadius.all(
          Radius.circular(AppGap.r15),
        ),
      ),
      child: Text(
        '${currentIndex + 1}/$length',
        style: AppStyles.text4014(color: AppColors.neutral500Color),
      ),
    );
  }
}
