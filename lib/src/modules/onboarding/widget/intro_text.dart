import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

class TextIntro extends StatelessWidget {
  const TextIntro({super.key, required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppStyles.text7024(),
        ),
        AppGap.sbH20,
        Text(
          description,
          textAlign: TextAlign.center,
          style: AppStyles.text7016(),
        ),
      ],
    );
  }
}
