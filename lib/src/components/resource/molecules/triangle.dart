import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';

class CustomTriangle extends StatelessWidget {
  const CustomTriangle({Key? key,  this.color = AppColors.yellow800Color}) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 45,
      width: 45,
      decoration:  BoxDecoration(
        gradient: LinearGradient(
          stops: const [.5, .5],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            color,
            Colors.transparent, // top Right part
          ],
        ),
      ),
    );
  }
}

