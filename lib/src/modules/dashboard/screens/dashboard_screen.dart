import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/app_strings/app_strings.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/modules/auth/login/screens/login_screen.dart';
import 'package:jancargo_app/src/modules/dashboard/bloc/dashboard_cubit.dart';
import 'package:jancargo_app/src/modules/favorite/screen/favorite_screens.dart';
import 'package:jancargo_app/src/modules/home/screen/home_screens.dart';
import 'package:jancargo_app/src/modules/manager_auction/screen/auction_manager_screen.dart';
import 'package:jancargo_app/src/modules/oder_management/screens/oder_management_screen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:remixicon/remixicon.dart';

import '../../../general/constants/app_constants.dart';
import '../../cart/screens/cart_screens.dart';
import '../../personal/screens/personal_screen.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key, this.indexTabView}) : super(key: key);
  final int? indexTabView;

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final DashboardCubit _cubit = DashboardCubit();
  final GlobalKey _dashboardScopeKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _cubit.initEvent();
  }

  @override
  Widget build(BuildContext context) {
    return DashboardScope(
      key: _dashboardScopeKey,
      child: CupertinoScaffold(
        topRadius: const Radius.circular(10),
        body: Theme(
          data: Theme.of(context),
          child: Builder(
            builder: (context) {
              return BlocBuilder<DashboardCubit, DashboardState>(
                bloc: _cubit,
                builder: (_, state) {
                  return PersistentTabView(
                    context,
                    onItemSelected: (index) {
                      if (index == 0) {
      
                        DashboardScope.of(context)?.getScrollControllerOf('Home')?.animateTo(
      
                          0,
      
                          duration: const Duration(milliseconds: 350),
      
                          curve: Curves.easeInOut,
      
                        );
      
                        return;
      
                      }
                      _cubit.onItemsSelected(widget.indexTabView ?? index);
                    },
                    screens: _buildScreens(context),
                    items: _navBarsItems(),
                    confineInSafeArea: true,
                    handleAndroidBackButtonPress: true,
                    resizeToAvoidBottomInset: true,
                    hideNavigationBarWhenKeyboardShows: true,
                    controller: _cubit.persistentTabController,
                    navBarStyle: NavBarStyle.style14,
                    // screenTransitionAnimation: const ScreenTransitionAnimation(
                    //   animateTabTransition: true,
                    //   curve: Curves.fastLinearToSlowEaseIn,
                    //   duration: Duration(milliseconds: 200),
                    // ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  List<Widget> _buildScreens(
    BuildContext context,
  ) {
    return [
      DashboardContext(
        context: context,
        child: const HomeScreen(),
      ),
      DashboardContext(
        context: context,
        child: const AuctionManagerScreen(),
      ),
      DashboardContext(
        context: context,
        child: const CartScreen(),
      ),
      DashboardContext(
        context: context,
        child: const FavoriteScreen(),
      ),
      DashboardContext(
        context: context,
        child: const PersonalScreen(),
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    Box hiveBox = Hive.box(AppConstants.APP_NAME_ID);
    final token = hiveBox.get(AppConstants.ACCESS_TOKEN);
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Remix.home_2_line),
        activeColorPrimary: AppColors.yellow700Color,
        inactiveColorPrimary: AppColors.neutral500Color,
        title: AppStrings.of(context).home,
        textStyle: AppStyles.text5012(),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Remix.copyleft_line),
        activeColorPrimary: AppColors.yellow700Color,
        inactiveColorPrimary: AppColors.neutral500Color,
        title: 'Đấu giá',
        textStyle: AppStyles.text5012(),
          onPressed: token != null
              ? null
              : (context) {
            RouteService.routeGoOnePage(const LoginScreen());
          }
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Remix.shopping_basket_2_line),
        activeColorPrimary: AppColors.yellow700Color,
        inactiveColorPrimary: AppColors.neutral500Color,
        title: AppStrings.of(context).cart,
        textStyle: AppStyles.text5012(),
          onPressed: token != null
              ? null
              : (context) {
            RouteService.routeGoOnePage(const LoginScreen());
          }
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Remix.heart_3_line),
        activeColorPrimary: AppColors.yellow700Color,
        inactiveColorPrimary: AppColors.neutral500Color,
        title: AppStrings.of(context).favorite,
        textStyle: AppStyles.text5012(),
          onPressed: token != null
              ? null
              : (context) {
            RouteService.routeGoOnePage(const LoginScreen());
          }
      ),
      PersistentBottomNavBarItem(
          icon: const Icon(Remix.user_3_line),
          activeColorPrimary: AppColors.yellow700Color,
          inactiveColorPrimary: AppColors.neutral500Color,
          title: 'Tài khoản',
          textStyle: AppStyles.text5012(),
          onPressed: token != null
              ? null
              : (context) {
                  RouteService.routeGoOnePage(const LoginScreen());
                }
                ),
    ];
  }
}

class DashboardContext extends InheritedWidget {
  DashboardContext({
    super.key,
    required super.child,
    required this.context,
  }) {
    _globalContext = context;
  }

  final BuildContext context;

  static BuildContext? _globalContext;

  /// Dùng để show popup banner ở home
  static BuildContext? get globalContext => _globalContext;

  static BuildContext? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<DashboardContext>()
        ?.context;
  }

  @override
  bool updateShouldNotify(covariant DashboardContext oldWidget) {
    return oldWidget.context != context;
  }
}

/// Used to register [ScrollController]

/// or declare variables that won't make DashboardScreen initializing constant

class DashboardScope extends InheritedWidget {

  DashboardScope({

    super.key,

    required super.child,

  });



  final Map<String, ScrollController> _registered = {};



  ScrollController? getScrollControllerOf(String page) => _registered[page];



  void registerScrollController(String page, ScrollController controller) {

    _registered[page] = controller;

  }



  static DashboardScope? of(BuildContext context) {

    final dashboardScope = context.getInheritedWidgetOfExactType<DashboardScope>();

    return dashboardScope;

  }



  @override

  bool updateShouldNotify(DashboardScope oldWidget) {

    _registered.addAll(oldWidget._registered);

    return false;

  }

}



class ScreenBodyContextProvider extends InheritedNotifier {

  ScreenBodyContextProvider({

    super.key,

    required BuildContext context,

    required String page,

    this.scrollController,

    required super.child,

  }) : super(notifier: scrollController) {

    if (scrollController != null) {

      DashboardScope.of(context)?.registerScrollController(page, scrollController!);

    }

  }



  final ScrollController? scrollController;

}
