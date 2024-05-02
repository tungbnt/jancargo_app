import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

class CustomContainerPersonal extends StatefulWidget {
  const CustomContainerPersonal({super.key});

  @override
  State<CustomContainerPersonal> createState() =>
      _CustomContainerPersonalState();
}

class _CustomContainerPersonalState extends State<CustomContainerPersonal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppGap.h78,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.yellow800Color,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
    );
  }
}
