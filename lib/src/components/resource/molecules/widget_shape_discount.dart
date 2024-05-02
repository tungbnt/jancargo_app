import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

class ShapeDiscountWidget extends StatelessWidget {
  const ShapeDiscountWidget({super.key, required this.cent});
  final String cent;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: Chevron(),
        child: SizedBox(
          width: AppGap.w40,
          height: AppGap.h40,
          child: Padding(
            padding: EdgeInsets.only(top: AppGap.h5),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text("$cent%", style: AppStyles.text5014()),
            ),
          ),
        ),
      ),
    );
  }
}

class Chevron extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Gradient gradient = new LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.orangeAccent, Colors.yellow],
      tileMode: TileMode.clamp,
    );

    final Rect colorBounds = Rect.fromLTRB(0, 0, size.width, size.height);
    final Paint paint = new Paint()
      ..color = AppColors.yellow700Color;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width / 2, size.height - size.height / 3);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}