import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/app_strings/app_strings.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/modules/auth/login/screens/login_screen.dart';
import 'package:jancargo_app/src/modules/onboarding/widget/onboarding_widget.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../general/constants/app_constants.dart';
import '../../dashboard/screens/dashboard_screen.dart';
import '../../web_view/screen/web_view.dart';


class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      height: 4.h,
      width: isActive ? 24.w : 16.w,
      decoration: BoxDecoration(
        color: isActive ? AppColors.neutral900Color : AppColors.neutral200Color,
        borderRadius:  BorderRadius.all(Radius.circular(AppGap.d12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child:
            PageView(
              physics: const ClampingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                OnboardOne(
                  pageId: '1',
                  indicator: _buildPageIndicator(),
                  image: AppImages.onboardOne,
                  title: AppStrings.of(context).titleOnBoardOne,
                  description: AppStrings.of(context).descriptionOnBoardOne,
                  textBtn: AppStrings.of(context).next,
                  onPressed: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                ),
                OnboardOne(
                  pageId: '2',
                  indicator: _buildPageIndicator(),
                  image: AppImages.onboardTwo,
                  title: AppStrings.of(context).titleOnBoardTwo,
                  description: AppStrings.of(context).descriptionOnBoardTwo,
                  textBtn: AppStrings.of(context).next,
                  onPressed: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                  onPressedBack: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                ),
                OnboardOne(
                  pageId: '3',
                  indicator: _buildPageIndicator(),
                  image: AppImages.onboardThree,
                  title: AppStrings.of(context).titleOnBoardThree,
                  description: AppStrings.of(context).descriptionOnBoardThree,
                  textBtn: AppStrings.of(context).start,
                  onPressed: () {
                     RouteService.routePushReplacementPage(const LoginScreen());

                    // RouteService.routeGoOnePage(const DashboardView());
                  },
                  onPressedBack: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                ),
              ],
            ),
      ),
    );
  }
}
