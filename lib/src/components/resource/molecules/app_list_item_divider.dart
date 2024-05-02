import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';

class AppListItemDivider extends StatelessWidget {
  const AppListItemDivider({
    super.key,
    this.indent,
    this.endIndent,
  });

  /// The amount of empty space to the leading edge of the divider.
  ///
  /// If this is null, then the [DividerThemeData.indent] is used. If that is
  /// also null, then this defaults to 0.0.
  final double? indent;

  /// The amount of empty space to the trailing edge of the divider.
  ///
  /// If this is null, then the [DividerThemeData.endIndent] is used. If that is
  /// also null, then this defaults to 0.0.
  final double? endIndent;

  @override
  Widget build(BuildContext context) {
    // late final colorTheme = ThemeService.getAppColorTheme(context);

    return Divider(
      color: AppColors.neutral400Color,
      thickness: 1,
      height: 1,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
