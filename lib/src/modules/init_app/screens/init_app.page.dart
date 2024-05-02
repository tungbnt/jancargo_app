import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jancargo_app/src/app_manager.dart';
import 'package:jancargo_app/src/general/app_strings/app_strings.dart';
import 'package:jancargo_app/src/general/constants/app_locale.dart';
import 'package:jancargo_app/src/modules/auction/bloc/auction_cubit.dart';
import 'package:jancargo_app/src/modules/splash/screens/splash_page.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../components/bloc/favorite/favorite_cubit.dart';
import '../../../domain/services/navigator/route_service.dart';
import '../../auth/login/bloc/login_cubit.dart';
import '../../dashboard/screens/dashboard_screen.dart';
import '../../details_product_auction/bloc/detail_product_cubit.dart';
import '../../home/bloc/home_cubit.dart';
import '../../onboarding/screens/onboarding_screen.dart';
import '../bloc/init_app_cubit.dart';


class JancargoApp extends StatelessWidget {
  const JancargoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => InitAppCubit()),
          BlocProvider(create: (context) => LoginCubit()),
          BlocProvider(create: (context) => HomeCubit()),
          BlocProvider(create: (context) => DetailProductCubit()),
          BlocProvider(create: (context) => AuctionListCubit()),
          BlocProvider(create: (context) => FavoriteCubit()),
        ],
        child: const InitPage());
  }
}

class InitPage extends StatefulWidget {
  const InitPage({Key? key}) : super(key: key);

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_InitPageState>()?.restartApp();
  }

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> with WidgetsBindingObserver {
  Key key = UniqueKey();
  InitAppCubit? cubit;



  @override
  void initState() {
    super.initState();
    // AppBadgerService().removeBadger();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      cubit = context.read<InitAppCubit>();
      cubit?.initEvent();
      requestPermission();
    });
  }

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
    // cubit?.initEvent();
  }

  void requestPermission() async {
    await Permission.notification.request();
    await Permission.camera.request();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('state: $state');
    switch (state) {
      case AppLifecycleState.resumed:
        // cubit?.refreshToken();
        break;
      case AppLifecycleState.paused:
        AppManager.appSession.saveTimePause(DateTime.now());
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var initAppCubit = context.read<InitAppCubit>();
    return KeyedSubtree(
      key: key,
      child:BlocBuilder<InitAppCubit, InitAppState>(
        bloc: initAppCubit,
        buildWhen: (prev, current) {
          return true;
        },
        builder: (context, state) {
          return MaterialApp(
            navigatorKey: AppManager.globalKeyRootMaterial,
            title: 'Jancargo',
            theme: ThemeData(fontFamily: 'K2D'),
            locale: AppLocaleEnum.VN.getLocale(),
            supportedLocales: AppLocaleEnum.values.map((e) => e.getLocale()),
            localizationsDelegates: [
              AppLocalizationDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,

            ],
            home: BlocListener<InitAppCubit, InitAppState>(
              bloc: initAppCubit,
              listenWhen: (prv,state)=> state is InitOnBoarding || state is InitDataSuccess,
              listener: (context, state) {
                if (state is InitOnBoarding) {
                   RouteService.routeOnboarding();
                } else if (state is InitDataSuccess) {
                  RouteService.routePushReplacementPage(const DashboardView());
                }
              },
              child: const SplashPage(),
            ),
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
