import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../util/app_gap.dart';

class CustomSmartRefresher extends StatelessWidget {
  const CustomSmartRefresher({
    super.key,
    this.child,
    this.onLoading,
    this.onRefresh,
    required this.controller,
    this.enablePullUp = true,
    this.enablePullDown = true,
    this.scrollController,
    this.showLoadDone = true,
    this.scrollDirection,
    this.showTextRefresh = true,
  });

  final Widget? child;
  final Function()? onLoading;
  final Function()? onRefresh;
  final RefreshController controller;
  final bool enablePullUp;
  final bool enablePullDown;
  final ScrollController? scrollController;
  final bool showLoadDone;
  final bool showTextRefresh;
  final Axis? scrollDirection;
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      scrollDirection: scrollDirection,
      scrollController: scrollController,
      controller: controller,
      header: CustomHeader(
        builder: (context, mode) {
          Widget body = Container();
          if (mode == RefreshStatus.canRefresh) {
            body = buildReleaseToReLoad();
          }
          if (mode == RefreshStatus.refreshing) {
            body = buildLoading();
          }
          if (mode == RefreshStatus.completed) {
            body = loadDone();
          }
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: body,
          );
        },
      ),
      footer: CustomFooter(
        builder: (context, mode) {
          Widget body = Container();
          if (mode == LoadStatus.idle || mode == LoadStatus.noMore) {
            body = const SizedBox.shrink();
          }
          if (mode == LoadStatus.loading) {
            body = buildLoading();
          }
          if (mode == LoadStatus.canLoading) {
            body = buildReleaseToLoadMore();
          }
          if (showLoadDone && mode == RefreshStatus.completed) {
            body = loadDone();
          }
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: body,
          );
        },
      ),
      enablePullUp: enablePullUp,
      onLoading: onLoading,
      enablePullDown: enablePullDown,
      onRefresh: onRefresh,
      child: child,
    );
  }

  Widget buildReleaseToReLoad() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.refresh),
          AppGap.sbW12,
          if (showTextRefresh) Text('reload'),
        ],
      ),
    );
  }

  Widget buildReleaseToLoadMore() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.refresh),
          AppGap.sbW12,
          if (showTextRefresh) Text('reload canmore'),
        ],
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CupertinoActivityIndicator(),
          AppGap.sbW12,
          if (showTextRefresh) Text('loading'),
        ],
      ),
    );
  }

  Widget loadDone() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check),
          AppGap.sbW12,
          if (showTextRefresh) Text('thành công'),
        ],
      ),
    );
  }
}
