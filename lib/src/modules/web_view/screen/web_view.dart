import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_styles.dart';
import '../../../general/inject_dependencies/inject_dependencies.dart';
import '../bloc/web_view_cubit.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key, required this.url,  this.title,  this.callback});
  final String url;
  final String? title;
  final VoidCallback? callback;


  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
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
            if (request.url.startsWith('https://m.jancargo.com/redirect',1)) {
              debugPrint('blocking navigation to ${request.url}');
              widget.callback;
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
      appBar: AppBar(
          bottomOpacity: 0.0,
          leading:  InkWell(
            highlightColor: Colors.transparent,
            onTap: () => RouteService.pop(),
            child: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.black03,
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.white,
          centerTitle: true,
          title: Text(
           widget.title ??  "Bản dịch",
            style: AppStyles.text7018(),
            overflow: TextOverflow.clip,
          ),
         ),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
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
