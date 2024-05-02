import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/modules/onboarding/screens/onboarding_screen.dart';

import '../../../general/constants/app_constants.dart';
import '../../auth/login/screens/login_screen.dart';
import '../../dashboard/screens/dashboard_screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // @override
  // void initState() {
  //   super.initState();
  //   Timer(const Duration(seconds: 4), () {
  //     Box hiveBox = Hive.box(AppConstants.APP_NAME_ID);
  //     final accessToken =
  //         hiveBox.get(AppConstants.ACCESS_TOKEN, defaultValue: null);
  //     hiveBox.put(AppConstants.ACCESS_TOKEN,"eyJhbGciOiJSUzI1NiIsImtpZCI6IjFFNjc3M0ExOThGMzAxRTZGRUFENjg4MzZGNkM4OUEzMEUwNkY0MTFSUzI1NiIsInR5cCI6ImF0K2p3dCIsIng1dCI6IkhtZHpvWmp6QWViLXJXaURiMnlKb3c0RzlCRSJ9.eyJuYmYiOjE3MDU1NjkxOTYsImV4cCI6MTcwNjE3Mzk5NiwiaXNzIjoiaHR0cHM6Ly9pZC5qYW5jYXJnby5jb20iLCJhdWQiOiJKQU5DQVJHTy1BUEkiLCJjbGllbnRfaWQiOiJqYW5jYXJnby1jbGllbnQtbW9iaWxlLXdlYiIsInN1YiI6IjYzM2E2N2JiNjI1NWIyYzA2MWE2YTQ4ZiIsImF1dGhfdGltZSI6MTcwNTU2OTE5NiwiaWRwIjoibG9jYWwiLCJyb2xlIjoiVVNFUiIsImp0aSI6IjI0QkVDMjU0MzFCQTMzQTMxNzg5QjMyRTg3OEZFOURDIiwiaWF0IjoxNzA1NTY5MTk2LCJzY29wZSI6WyJmdWxsX2FjY2VzcyIsIm9wZW5pZCIsInByb2ZpbGUiLCJvZmZsaW5lX2FjY2VzcyJdLCJhbXIiOlsicHdkIl19.fhxafD4u4qmVojbcYSiVO45M5jkW42NOT6TVK7drKWMP7KwdclOTNUmDDzh-kCYqbMXM614yTmCqa1mbPsrjQ_CTbtsfuQTM3xBTs3L1ZUKAfLSrK-d9r5DvqjHtvlamq-HI2wp5-LqF3JGV88us5FPA8CsxJXGBYk288Bnnf9f-TsExTlUWnoKIrxgNUSkfgkLy3vRs2SbDXf_GI-taGuoEDr8bxnWcz0NbLSvne1ZSNAvvWwR67FxLTyN0Cb9NgXofUNfBeTLCH7X7xEmGYdfTUVmQBVY7C29LNoQbn_x-S1wFTT0YPSqsQIEOH0yY3VtnS9o8JhhfGjZq2abaJw");
  //     if (accessToken == null) {
  //       RouteService.routePushReplacementPage(const OnboardScreen());
  //     }else if(accessToken != null && accessToken != ''){
  //            RouteService.routePushReplacementPage(const DashboardView());
  //          }
  //          else {
  //       RouteService.routeGoOnePage(const LoginScreen());
  //       // RouteService.routeGoOnePage(const WebViewScreen());
  //       // RouteService.routePushReplacementPage(const DashboardView());
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(AppImages.splash, fit: BoxFit.cover)));
  }
}
