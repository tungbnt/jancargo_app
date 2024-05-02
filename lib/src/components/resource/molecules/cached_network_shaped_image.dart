
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jancargo_app/src/helper/media_query_extension.dart';

import 'shimmer_wrapper.dart';

class ResponsiveCachedNetworkRectangleImage extends StatelessWidget {
  const ResponsiveCachedNetworkRectangleImage({
    Key? key,
    required this.width,
    required this.height,
    this.designScreenWidth = 375,
    this.alignment = Alignment.center,
    required this.imageUrl,
    this.imageDecoration = const BoxDecoration(),
    this.errorWidget,
    this.fit,
  }) : super(key: key);

  final double width;
  final double height;
  final double designScreenWidth;

  final String imageUrl;
  final BoxDecoration imageDecoration;
  final Widget? errorWidget;
  final BoxFit? fit;
  final Alignment alignment;

  Size getResponsiveSizeBaseOnWidth(
      BuildContext context, {
        required double imageWidth,
        required double imageHeight,
        required double designScreenWidth,
      }) {
    final double screenWidth = MediaQuery.of(context).size.width;

    final double widthDelta = imageWidth / designScreenWidth;
    final double heightDelta = imageHeight / imageWidth;

    final width = screenWidth * widthDelta;

    return Size(width, width * heightDelta);
  }

  @override
  Widget build(BuildContext context) {
    final effectiveHeight = getResponsiveSizeBaseOnWidth(
          context,
          imageWidth: width,
          imageHeight: height,
          designScreenWidth: designScreenWidth,
        ) *
        context.textScaleFactor;

    return CachedNetworkRectangleImage(
      key: const Key('<CachedNetworkRectangleImageWrapper>'),
      width: effectiveHeight.width,
      height: effectiveHeight.height,
      alignment: alignment,
      imageUrl: imageUrl,
      imageDecoration: imageDecoration,
      errorWidget: errorWidget,
      fit: fit,
    );
  }
}

class CachedNetworkRectangleImage extends StatelessWidget {
  const CachedNetworkRectangleImage({
    Key? key,
    this.width = double.infinity,
    this.height,
    this.minHeight,
    this.alignment = Alignment.center,
    required this.imageUrl,
    this.imageDecoration = const BoxDecoration(),
    this.errorWidget,
    this.fit,
  }) : super(key: key);

  final double width;
  final double? height;
  final double? minHeight;

  final String imageUrl;
  final BoxDecoration imageDecoration;
  final Widget? errorWidget;
  final BoxFit? fit;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key: Key(imageUrl),
      imageUrl: imageUrl,
      height: height,
      width: width,
      alignment: alignment,
      fit: fit,
      progressIndicatorBuilder: (_, __, ___) => ShimmerWrapper(
        child: SizedBox(
          height: height ?? minHeight,
          width: width,
          child: const ColoredBox(
            color: Colors.white,
          ),
        ),
      ),
      fadeInDuration: minHeight == null ? const Duration(milliseconds: 500) : const Duration(milliseconds: 800),
      fadeOutDuration: minHeight == null ? const Duration(milliseconds: 1000) : const Duration(milliseconds: 100),
      imageBuilder: (_, imageProvider) {
        if ((width == double.infinity || width == context.screenWidth) && height == null) {
          return Image(
            image: imageProvider,
            alignment: alignment,
            fit: fit,
          );
        }

        return SizedBox(
          height: height ?? minHeight,
          width: width,
          child: DecoratedBox(
            decoration: imageDecoration.copyWith(
              image: DecorationImage(
                image: imageProvider,
                alignment: alignment,
                fit: fit,
              ),
            ),
          ),
        );
      },
      errorWidget: errorWidget == null ? null : (_, __, ___) => errorWidget!,
    );
  }
}

class CachedNetworkCircleImage extends StatelessWidget {
  const CachedNetworkCircleImage({
    Key? key,
    required this.size,
    required this.imageUrl,
    this.imageDecoration = const BoxDecoration(),
    this.errorWidget,
  }) : super(key: key);

  final double size;
  final String imageUrl;
  final BoxDecoration imageDecoration;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key: Key(imageUrl),
      imageUrl: imageUrl,
      height: size,
      width: size,
      progressIndicatorBuilder: (_, __, ___) => ShimmerWrapper(
        child: Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
        ),
      ),
      imageBuilder: (_, imageProvider) => SizedBox(
        width: size,
        height: size,
        child: DecoratedBox(
          decoration: imageDecoration.copyWith(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      errorWidget: errorWidget == null ? null : (_, __, ___) => errorWidget!,
    );
  }
}
