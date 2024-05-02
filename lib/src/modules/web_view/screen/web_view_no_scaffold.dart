import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/util/app_gap.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_styles.dart';
import '../../../general/inject_dependencies/inject_dependencies.dart';
import '../bloc/web_view_cubit.dart';

class WebViewNoScaffoldScreen extends StatefulWidget {
  const WebViewNoScaffoldScreen({super.key, required this.url});
  final String url;


  @override
  State<WebViewNoScaffoldScreen> createState() => _WebViewNoScaffoldScreenState();
}

class _WebViewNoScaffoldScreenState extends State<WebViewNoScaffoldScreen> {
  late final WebViewController _controller;
  WebViewCubit get _cubit => getIt<WebViewCubit>();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _cubit.initEvent(isLoading: true);
    });
// #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
    WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            _cubit.stopLoading();
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(widget.url));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: AppGap.h24),
            child: Theme(
              data: ThemeData(
                  textSelectionTheme: const TextSelectionThemeData(
                      cursorColor: AppColors.primaryColor)),
              child: WebViewWidget(controller: _controller),
            ),
          ),
          BlocBuilder<WebViewCubit,WebViewState>(
              bloc: _cubit,
              builder: (context, state) {

                if (state.isLoading == true || state is WebViewLoading) {
                  return  const Positioned.fill(child: LoadingSpinkit());
                }
                return Container();
              }),
        ],
      ),
    );
  }
}
class LoadingSpinkit extends StatelessWidget {
  const LoadingSpinkit({Key? key, this.color}) : super(key: key);
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? AppColors.greyColor.withOpacity(0.45),
      child: const SpinKitCircle(color: AppColors.yellow700Color),
    );
  }
}
