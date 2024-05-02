import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';

class ShapeTimeWidget extends StatelessWidget {
  const ShapeTimeWidget({super.key, this.width = 140,  this.height = 20, required this.widget});
  final double width;
  final double height;
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return  CustomPaint(
      painter: const BodyPainter(color:  AppColors.primary700Color),
      size: Size.infinite,
      child: SizedBox(
        height: height,
          width: width,
          child: widget),
      // child:  SizedBox(
      //   width: 124,
      //   height: 18,
      //   child: widget,
      // ),
    );
  }
}
class TimeWidget extends StatelessWidget {
  const TimeWidget({super.key, required this.width ,  required this.height , required this.widget});
  final double width;
  final double height;
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return  CustomPaint(
      painter: const BodyPainter(color:  AppColors.primary700Color),
      size: Size.infinite,
      child: SizedBox(
          height: height,
          width: width,
          child: widget),
      // child:  SizedBox(
      //   width: 124,
      //   height: 18,
      //   child: widget,
      // ),
    );
  }
}

class BodyPainter extends CustomPainter {
  const BodyPainter( {this.color = AppColors.primary700Color,});
  final Color color;
  final bottomPadding = 10;
  @override
  void paint(Canvas canvas,size) {
    Path path = Path()
      ..lineTo(0,0)
      ..lineTo(0,size.height)
      ..lineTo(size.width, size.height)
       //65& on left
      ..lineTo(size.width - bottomPadding, 0)
      ;
    double w = size.width;
    double h = size.height;
    double r = 15;

    Paint paint = Paint()..color = color;
    // RRect fullRect = RRect.fromRectAndRadius(
    //   Rect.fromCenter(center: Offset(0, 0), width: w, height: h),
    //   Radius.circular(r),
    // );
    // canvas.drawRRect(fullRect, paint);
    canvas.drawPath(path, paint);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}