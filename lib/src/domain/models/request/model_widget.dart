import 'package:flutter/material.dart';

class ModelWidget {
  final String icon;
  final String text;
  final Color? color;
  final void Function()? onTap;

  ModelWidget({this.onTap,
    required this.icon,
    required this.text,
     this.color,
  });
}