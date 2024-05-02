import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/app_strings/app_strings.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/modules/auth/sign_up/screens/signup_screen.dart';

import '../../sign_up/screens/capcha.dart';
import '../../sign_up/screens/test.dart';

class NotAccount extends StatelessWidget {
  const NotAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
            text: AppStrings.of(context).notAccount,
            style: AppStyles.text4017(color: AppColors.neutral700Color)),
        TextSpan(
          text: AppStrings.of(context).signup,
          style: AppStyles.text4017(color: AppColors.yellow800Color),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              RouteService.routeGoOnePage(SignupScreen());
            },
        ),
      ]),
    );
  }
}
