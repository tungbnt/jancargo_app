import 'package:flutter/material.dart';
import 'package:jancargo_app/src/helper/media_query_extension.dart';

class WillScrollPositionChange extends StatefulWidget {
  const WillScrollPositionChange({
    super.key,
    this.scrollController,
    required this.designItemExtent,
    required this.onNextExtent,
    this.onEnd,
    required this.child,
  });

  final ScrollController? scrollController;
  final double designItemExtent;
  final VoidCallback onNextExtent;
  final VoidCallback? onEnd;
  final Widget child;

  @override
  State<WillScrollPositionChange> createState() => _WillScrollPositionChangeState();
}

class _WillScrollPositionChangeState extends State<WillScrollPositionChange> {
  ScrollPosition? _scrollPosition;

  late double _designItemExtent = widget.designItemExtent;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollPosition?.removeListener(_handleLoadMore);
    _scrollPosition = Scrollable.maybeOf(context)?.position ??
        widget.scrollController?.position ??
        PrimaryScrollController.maybeOf(context)?.position;
    _scrollPosition?.addListener(_handleLoadMore);

    _designItemExtent = widget.designItemExtent * context.textScaleFactor;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Trường hợp điện thoại dài, app chỉ call api lấy vài item thì
      // cái widget loading vẫn còn đang hiện ở dưới
      // -> cần phải gọi load more thêm lần nữa
      _handleLoadMore();
    });
  }

  @override
  void dispose() {
    _scrollPosition?.removeListener(_handleLoadMore);
    super.dispose();
  }

  double get _minScrollExtent => _scrollPosition!.minScrollExtent;
  double get _maxScrollExtent => _scrollPosition!.maxScrollExtent;

  void _handleLoadMore() {
    if (_minScrollExtent == _maxScrollExtent) return;

    final currentPosition = _scrollPosition!.pixels;

    if (currentPosition == _maxScrollExtent) {
      widget.onEnd?.call();
      return;
    }

    if (currentPosition + _designItemExtent >= _maxScrollExtent) {
      widget.onNextExtent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
