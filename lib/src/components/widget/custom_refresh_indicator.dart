import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:slivers/widgets.dart';

/// The over-scroll distance that moves the indicator to its maximum
/// displacement, as a percentage of the scrollable's container extent.
const double _kDragContainerExtentPercentage = 0.25;

/// How much the scroll's drag gesture can overshoot the RefreshIndicator's
/// displacement; max displacement = _kDragSizeFactorLimit * displacement.
const double _kDragSizeFactorLimit = 1.5;

/// When the scroll ends, the duration of the refresh indicator's animation
/// to the RefreshIndicator's displacement.
const Duration _kIndicatorSnapDuration = Duration(milliseconds: 150);

/// The duration of the ScaleTransition that starts when the refresh action
/// has completed.
const Duration _kIndicatorScaleDuration = Duration(milliseconds: 200);

/// The duration of the ScaleTransition that starts after refreshing.
const Duration _kIndicatorReverseScaleDuration = Duration(milliseconds: 270);

/// The delayed duration of the ScaleTransition that starts after refreshing.
const Duration _kDelayedIndicatorReverseScaleDuration = Duration(milliseconds: 320);

/// The state machine moves through these modes only when the scrollable
/// identified by scrollableKey has been scrolled to its min or max limit.
enum _RefreshIndicatorMode {
  /// Pointer is down.
  drag,

  /// Dragged far enough that an up event will run the onRefresh callback.
  armed,

  /// Animating to the indicator's final "displacement".
  snap,

  /// Running the refresh callback.
  refresh,

  /// Animating the indicator's fade-out after refreshing.
  done,

  /// Animating the indicator's fade-out after not arming.
  canceled,
}

class CustomRefreshIndicator extends StatefulWidget {
  /// Creates a refresh indicator.
  ///
  /// The [indicator], [onRefresh], [builder], and [notificationPredicate]
  /// arguments must be non-null. The default
  /// [displacement] is 8.0 logical pixels.
  const CustomRefreshIndicator({
    super.key,
    required this.indicator,
    this.inProgessWidget,
    this.doneWidget,
    required this.builder,
    this.displacement = 8.0,
    required this.onRefresh,
    this.notificationPredicate = defaultScrollNotificationPredicate,
    this.triggerMode = RefreshIndicatorTriggerMode.onEdge,
  }) : _useSliver = false;

  const CustomRefreshIndicator.wrapWithSliver({
    super.key,
    required this.indicator,
    this.inProgessWidget,
    this.doneWidget,
    required this.builder,
    this.displacement = 8.0,
    required this.onRefresh,
    this.notificationPredicate = defaultScrollNotificationPredicate,
    this.triggerMode = RefreshIndicatorTriggerMode.onEdge,
  }) : _useSliver = true;

  final Widget indicator;

  final Widget? inProgessWidget;

  final Widget? doneWidget;

  final bool _useSliver;

  final Widget Function(Widget animatedIndicator, bool isIndicatorAtTop) builder;

  /// The distance from the child's top or bottom edge where
  /// the refresh indicator will settle. During the drag that exposes the refresh
  /// indicator, its actual displacement may significantly exceed this value.
  ///
  /// In most cases, [displacement] distance starts counting from the parent's
  /// edges.
  final double displacement;

  /// A function that's called when the user has dragged the refresh indicator
  /// far enough to demonstrate that they want the app to refresh. The returned
  /// [Future] must complete when the refresh operation is finished.
  final RefreshCallback onRefresh;

  /// A check that specifies whether a [ScrollNotification] should be
  /// handled by this widget.
  ///
  /// By default, checks whether `notification.depth == 0`. Set it to something
  /// else for more complicated layouts.
  final ScrollNotificationPredicate notificationPredicate;

  /// Defines how this [CustomRefreshIndicator] can be triggered when users overscroll.
  ///
  /// The [CustomRefreshIndicator] can be pulled out in two cases,
  /// 1, Keep dragging if the scrollable widget at the edge with zero scroll position
  ///    when the drag starts.
  /// 2, Keep dragging after overscroll occurs if the scrollable widget has
  ///    a non-zero scroll position when the drag starts.
  ///
  /// If this is [RefreshIndicatorTriggerMode.anywhere], both of the cases above can be triggered.
  ///
  /// If this is [RefreshIndicatorTriggerMode.onEdge], only case 1 can be triggered.
  ///
  /// Defaults to [RefreshIndicatorTriggerMode.onEdge].
  final RefreshIndicatorTriggerMode triggerMode;

  @override
  CustomRefreshIndicatorState createState() => CustomRefreshIndicatorState();
}

/// Contains the state for a [CustomRefreshIndicator]. This class can be used to
/// programmatically show the refresh indicator, see the [show] method.
class CustomRefreshIndicatorState extends State<CustomRefreshIndicator>
    with TickerProviderStateMixin<CustomRefreshIndicator> {
  late AnimationController _positionController;
  late AnimationController _scaleController;
  late Animation<double> _positionFactor;
  late Animation<double> _scaleFactor;

  _RefreshIndicatorMode? _mode;
  late Future<void> _pendingRefreshFuture;
  bool? _isIndicatorAtTop;
  double? _dragOffset;

  static final Animatable<double> _kDragSizeFactorLimitTween = Tween<double>(begin: 0.0, end: _kDragSizeFactorLimit);
  static final Animatable<double> _oneToZeroTween = Tween<double>(begin: 1.0, end: 0.0);

  @override
  void initState() {
    super.initState();
    _positionController = AnimationController(vsync: this);
    _positionFactor = _positionController.drive(_kDragSizeFactorLimitTween);

    _scaleController = AnimationController(vsync: this);
    _scaleFactor = _scaleController.drive(_oneToZeroTween);
  }

  @override
  void dispose() {
    _positionController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  bool _shouldStart(ScrollNotification notification) {
    // If the notification.dragDetails is null, this scroll is not triggered by
    // user dragging. It may be a result of ScrollController.jumpTo or ballistic scroll.
    // In this case, we don't want to trigger the refresh indicator.
    return ((notification is ScrollStartNotification && notification.dragDetails != null) ||
        (notification is ScrollUpdateNotification &&
            notification.dragDetails != null &&
            widget.triggerMode == RefreshIndicatorTriggerMode.anywhere)) &&
        ((notification.metrics.axisDirection == AxisDirection.up && notification.metrics.extentAfter == 0.0) ||
            (notification.metrics.axisDirection == AxisDirection.down && notification.metrics.extentBefore == 0.0)) &&
        _mode == null &&
        _start(notification.metrics.axisDirection);
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (!widget.notificationPredicate(notification)) {
      return false;
    }
    if (_shouldStart(notification)) {
      setState(() {
        _mode = _RefreshIndicatorMode.drag;
      });
      return false;
    }
    bool? indicatorAtTopNow;
    switch (notification.metrics.axisDirection) {
      case AxisDirection.down:
      case AxisDirection.up:
        indicatorAtTopNow = true;
      case AxisDirection.left:
      case AxisDirection.right:
        indicatorAtTopNow = null;
    }
    if (indicatorAtTopNow != _isIndicatorAtTop) {
      if (_mode == _RefreshIndicatorMode.drag || _mode == _RefreshIndicatorMode.armed) {
        _dismiss(_RefreshIndicatorMode.canceled);
      }
    } else if (notification is ScrollUpdateNotification) {
      if (_mode == _RefreshIndicatorMode.drag || _mode == _RefreshIndicatorMode.armed) {
        if ((notification.metrics.axisDirection == AxisDirection.down && notification.metrics.extentBefore > 0.0) ||
            (notification.metrics.axisDirection == AxisDirection.up && notification.metrics.extentAfter > 0.0)) {
          _dismiss(_RefreshIndicatorMode.canceled);
        } else {
          if (notification.metrics.axisDirection == AxisDirection.down) {
            _dragOffset = _dragOffset! - notification.scrollDelta!;
          } else if (notification.metrics.axisDirection == AxisDirection.up) {
            _dragOffset = _dragOffset! + notification.scrollDelta!;
          }
          _checkDragOffset(notification.metrics.viewportDimension);
        }
      }
      if (_mode == _RefreshIndicatorMode.armed && notification.dragDetails == null) {
        // On iOS start the refresh when the Scrollable bounces back from the
        // overscroll (ScrollNotification indicating this don't have dragDetails
        // because the scroll activity is not directly triggered by a drag).
        _show();
      }
    } else if (notification is OverscrollNotification) {
      if (_mode == _RefreshIndicatorMode.drag || _mode == _RefreshIndicatorMode.armed) {
        if (notification.metrics.axisDirection == AxisDirection.down) {
          _dragOffset = _dragOffset! - notification.overscroll;
        } else if (notification.metrics.axisDirection == AxisDirection.up) {
          _dragOffset = _dragOffset! + notification.overscroll;
        }
        _checkDragOffset(notification.metrics.viewportDimension);
      }
    } else if (notification is ScrollEndNotification) {
      switch (_mode) {
        case _RefreshIndicatorMode.armed:
          _show();
        case _RefreshIndicatorMode.drag:
          _dismiss(_RefreshIndicatorMode.canceled);
        case _RefreshIndicatorMode.canceled:
        case _RefreshIndicatorMode.done:
        case _RefreshIndicatorMode.refresh:
        case _RefreshIndicatorMode.snap:
        case null:
        // do nothing
          break;
      }
    }
    return false;
  }

  bool _handleIndicatorNotification(OverscrollIndicatorNotification notification) {
    if (notification.depth != 0 || !notification.leading) {
      return false;
    }
    if (_mode == _RefreshIndicatorMode.drag) {
      notification.disallowIndicator();
      return true;
    }
    return false;
  }

  bool _start(AxisDirection direction) {
    assert(_mode == null);
    assert(_isIndicatorAtTop == null);
    assert(_dragOffset == null);
    switch (direction) {
      case AxisDirection.down:
      case AxisDirection.up:
        _isIndicatorAtTop = true;
      case AxisDirection.left:
      case AxisDirection.right:
        _isIndicatorAtTop = null;
        // we do not support horizontal scroll views.
        return false;
    }
    _dragOffset = 0.0;
    _scaleController.value = 0.0;
    _positionController.value = 0.0;
    return true;
  }

  void _checkDragOffset(double containerExtent) {
    assert(_mode == _RefreshIndicatorMode.drag || _mode == _RefreshIndicatorMode.armed);
    double newValue = _dragOffset! / (containerExtent * _kDragContainerExtentPercentage);
    if (_mode == _RefreshIndicatorMode.armed) {
      newValue = math.max(newValue, 1.0 / _kDragSizeFactorLimit);
    }
    _positionController.value = clampDouble(newValue, 0.0, 1.0); // this triggers various rebuilds
    if (_mode == _RefreshIndicatorMode.drag && _positionController.value == 1.0) {
      _mode = _RefreshIndicatorMode.armed;
    }
  }

  // Stop showing the refresh indicator.
  Future<void> _dismiss(_RefreshIndicatorMode newMode) async {
    await Future<void>.value();
    // This can only be called from _show() when refreshing and
    // _handleScrollNotification in response to a ScrollEndNotification or
    // direction change.
    assert(newMode == _RefreshIndicatorMode.canceled || newMode == _RefreshIndicatorMode.done);
    setState(() {
      _mode = newMode;
    });
    switch (_mode!) {
      case _RefreshIndicatorMode.done:
        if (widget.doneWidget != null) {
          await Future.delayed(
            _kDelayedIndicatorReverseScaleDuration,
                () => _positionController.animateTo(
              0.0,
              duration: _kIndicatorReverseScaleDuration,
              curve: Curves.easeOutSine,
            ),
          );
        }
        await _scaleController.animateTo(1.0, duration: _kIndicatorScaleDuration);
      case _RefreshIndicatorMode.canceled:
        await _positionController.animateTo(0.0, duration: _kIndicatorScaleDuration);
      case _RefreshIndicatorMode.armed:
      case _RefreshIndicatorMode.drag:
      case _RefreshIndicatorMode.refresh:
      case _RefreshIndicatorMode.snap:
        assert(false);
    }
    if (mounted && _mode == newMode) {
      _dragOffset = null;
      _isIndicatorAtTop = null;
      setState(() {
        _mode = null;
      });
    }
  }

  void _show() {
    assert(_mode != _RefreshIndicatorMode.refresh);
    assert(_mode != _RefreshIndicatorMode.snap);
    final Completer<void> completer = Completer<void>();
    _pendingRefreshFuture = completer.future;
    _mode = _RefreshIndicatorMode.snap;
    _positionController
        .animateTo(1.0 / _kDragSizeFactorLimit, duration: _kIndicatorSnapDuration)
        .then<void>((void value) {
      if (mounted && _mode == _RefreshIndicatorMode.snap) {
        setState(() {
          // Show the indeterminate progress indicator.
          _mode = _RefreshIndicatorMode.refresh;
        });

        final Future<void> refreshResult = widget.onRefresh();
        refreshResult.whenComplete(() {
          if (mounted && _mode == _RefreshIndicatorMode.refresh) {
            completer.complete();
            _dismiss(_RefreshIndicatorMode.done);
          }
        });
      }
    });
  }

  /// Show the refresh indicator and run the refresh callback as if it had
  /// been started interactively. If this method is called while the refresh
  /// callback is running, it quietly does nothing.
  ///
  /// Creating the [CustomRefreshIndicator] with a [GlobalKey<RefreshIndicatorState>]
  /// makes it possible to refer to the [CustomRefreshIndicatorState].
  ///
  /// The future returned from this method completes when the
  /// [CustomRefreshIndicator.onRefresh] callback's future completes.
  ///
  /// If you await the future returned by this function from a [State], you
  /// should check that the state is still [mounted] before calling [setState].
  ///
  /// When initiated in this manner, the refresh indicator is independent of any
  /// actual scroll view. It defaults to showing the indicator at the top. To
  /// show it at the bottom, set `atTop` to false.
  Future<void> show({bool atTop = true}) {
    if (_mode != _RefreshIndicatorMode.refresh && _mode != _RefreshIndicatorMode.snap) {
      if (_mode == null) {
        _start(atTop ? AxisDirection.down : AxisDirection.up);
      }
      _show();
    }
    return _pendingRefreshFuture;
  }

  @override
  Widget build(BuildContext context) {
    assert(() {
      if (_mode == null) {
        assert(_dragOffset == null);
        assert(_isIndicatorAtTop == null);
      } else {
        assert(_dragOffset != null);
        assert(_isIndicatorAtTop != null);
      }
      return true;
    }());

    Widget child;

    final bool hasManyIndicators = widget.inProgessWidget != null || widget.doneWidget != null;

    if (_mode == _RefreshIndicatorMode.refresh && widget.inProgessWidget != null) {
      child = widget.inProgessWidget!;
    } else if (_mode == _RefreshIndicatorMode.done && widget.doneWidget != null) {
      child = widget.doneWidget!;
    } else {
      child = widget.indicator;
    }

    if (hasManyIndicators) {
      child = AnimatedSwitcher(
        duration: const Duration(milliseconds: 90),
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: animation,
            child: AnimatedSwitcher.defaultTransitionBuilder(child, animation),
          );
        },
        child: child,
      );
    }

    Widget animatedIndicator = ScaleTransition(
      scale: _scaleFactor,
      child: child,
    );

    final padding = _isIndicatorAtTop == null
        ? EdgeInsets.zero
        : _isIndicatorAtTop!
        ? EdgeInsets.only(top: widget.displacement)
        : EdgeInsets.only(bottom: widget.displacement);

    final alignment = _isIndicatorAtTop == null
        ? Alignment.center
        : _isIndicatorAtTop!
        ? Alignment.topCenter
        : Alignment.bottomCenter;

    animatedIndicator = Padding(
      padding: padding,
      child: Align(
        alignment: alignment,
        child: animatedIndicator,
      ),
    );

    final double axisAlignment = _isIndicatorAtTop == null
        ? 0.0
        : _isIndicatorAtTop!
        ? 1.0
        : -1.0;

    if (widget._useSliver) {
      animatedIndicator = _SliverSizeTransition(
        axisAlignment: axisAlignment,
        sizeFactor: _positionFactor, // this is what brings it down
        child: animatedIndicator,
      );
    } else {
      animatedIndicator = SizeTransition(
        axisAlignment: axisAlignment,
        sizeFactor: _positionFactor, // this is what brings it down
        child: animatedIndicator,
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: _handleIndicatorNotification,
        child: widget.builder(animatedIndicator, _isIndicatorAtTop ?? false),
      ),
    );
  }
}

class CustomHorizontalRefreshIndicator extends StatefulWidget {
  /// Creates a refresh indicator.
  ///
  /// The [indicator], [onRefresh], [builder], and [notificationPredicate]
  /// arguments must be non-null. The default
  /// [displacement] is 8.0 logical pixels.
  const CustomHorizontalRefreshIndicator({
    super.key,
    required this.indicator,
    this.inProgessWidget,
    this.doneWidget,
    required this.builder,
    this.displacement = 10.0,
    required this.onRefresh,
    this.notificationPredicate = defaultScrollNotificationPredicate,
    this.triggerMode = RefreshIndicatorTriggerMode.onEdge,
  }) : _useSliver = false;

  const CustomHorizontalRefreshIndicator.wrapWithSliver({
    super.key,
    required this.indicator,
    this.inProgessWidget,
    this.doneWidget,
    required this.builder,
    this.displacement = 10.0,
    required this.onRefresh,
    this.notificationPredicate = defaultScrollNotificationPredicate,
    this.triggerMode = RefreshIndicatorTriggerMode.onEdge,
  }) : _useSliver = true;

  final Widget indicator;

  final Widget? inProgessWidget;

  final Widget? doneWidget;

  final bool _useSliver;

  final Widget Function(Widget animatedIndicator, bool isIndicatorAtTop) builder;

  /// The distance from the child's top or bottom edge where
  /// the refresh indicator will settle. During the drag that exposes the refresh
  /// indicator, its actual displacement may significantly exceed this value.
  ///
  /// In most cases, [displacement] distance starts counting from the parent's
  /// edges.
  final double displacement;

  /// A function that's called when the user has dragged the refresh indicator
  /// far enough to demonstrate that they want the app to refresh. The returned
  /// [Future] must complete when the refresh operation is finished.
  final RefreshCallback onRefresh;

  /// A check that specifies whether a [ScrollNotification] should be
  /// handled by this widget.
  ///
  /// By default, checks whether `notification.depth == 0`. Set it to something
  /// else for more complicated layouts.
  final ScrollNotificationPredicate notificationPredicate;

  /// Defines how this [CustomHorizontalRefreshIndicator] can be triggered when users overscroll.
  ///
  /// The [CustomHorizontalRefreshIndicator] can be pulled out in two cases,
  /// 1, Keep dragging if the scrollable widget at the edge with zero scroll position
  ///    when the drag starts.
  /// 2, Keep dragging after overscroll occurs if the scrollable widget has
  ///    a non-zero scroll position when the drag starts.
  ///
  /// If this is [RefreshIndicatorTriggerMode.anywhere], both of the cases above can be triggered.
  ///
  /// If this is [RefreshIndicatorTriggerMode.onEdge], only case 1 can be triggered.
  ///
  /// Defaults to [RefreshIndicatorTriggerMode.onEdge].
  final RefreshIndicatorTriggerMode triggerMode;

  @override
  CustomHorizontalRefreshIndicatorState createState() => CustomHorizontalRefreshIndicatorState();
}

/// Contains the state for a [CustomHorizontalRefreshIndicator]. This class can be used to
/// programmatically show the refresh indicator, see the [show] method.
class CustomHorizontalRefreshIndicatorState extends State<CustomHorizontalRefreshIndicator>
    with TickerProviderStateMixin<CustomHorizontalRefreshIndicator> {
  late AnimationController _positionController;
  late AnimationController _scaleController;
  late Animation<double> _positionFactor;
  late Animation<double> _scaleFactor;

  _RefreshIndicatorMode? _mode;
  late Future<void> _pendingRefreshFuture;
  bool? _isIndicatorAtTop;
  double? _dragOffset;

  static final Animatable<double> _kDragSizeFactorLimitTween = Tween<double>(begin: 0.0, end: _kDragSizeFactorLimit);
  static final Animatable<double> _oneToZeroTween = Tween<double>(begin: 1.0, end: 0.0);

  @override
  void initState() {
    super.initState();
    _positionController = AnimationController(vsync: this);
    _positionFactor = _positionController.drive(_kDragSizeFactorLimitTween);

    _scaleController = AnimationController(vsync: this);
    _scaleFactor = _scaleController.drive(_oneToZeroTween);
  }

  @override
  void dispose() {
    _positionController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  bool _shouldStart(ScrollNotification notification) {
    // If the notification.dragDetails is null, this scroll is not triggered by
    // user dragging. It may be a result of ScrollController.jumpTo or ballistic scroll.
    // In this case, we don't want to trigger the refresh indicator.
    return ((notification is ScrollStartNotification && notification.dragDetails != null) ||
        (notification is ScrollUpdateNotification &&
            notification.dragDetails != null &&
            widget.triggerMode == RefreshIndicatorTriggerMode.anywhere)) &&
        ((notification.metrics.axisDirection == AxisDirection.left && notification.metrics.extentAfter == 0.0) ||
            (notification.metrics.axisDirection == AxisDirection.right && notification.metrics.extentBefore == 0.0)) &&
        _mode == null &&
        _start(notification.metrics.axisDirection);
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (!widget.notificationPredicate(notification)) {
      return false;
    }
    if (_shouldStart(notification)) {
      setState(() {
        _mode = _RefreshIndicatorMode.drag;
      });
      return false;
    }
    bool? indicatorAtTopNow;
    switch (notification.metrics.axisDirection) {
      case AxisDirection.down:
      case AxisDirection.up:
        indicatorAtTopNow = null;
      case AxisDirection.left:
      case AxisDirection.right:
        indicatorAtTopNow = true;
    }
    if (indicatorAtTopNow != _isIndicatorAtTop) {
      if (_mode == _RefreshIndicatorMode.drag || _mode == _RefreshIndicatorMode.armed) {
        _dismiss(_RefreshIndicatorMode.canceled);
      }
    } else if (notification is ScrollUpdateNotification) {
      if (_mode == _RefreshIndicatorMode.drag || _mode == _RefreshIndicatorMode.armed) {
        if ((notification.metrics.axisDirection == AxisDirection.right && notification.metrics.extentBefore > 0.0) ||
            (notification.metrics.axisDirection == AxisDirection.left && notification.metrics.extentAfter > 0.0)) {
          _dismiss(_RefreshIndicatorMode.canceled);
        } else {
          if (notification.metrics.axisDirection == AxisDirection.right) {
            _dragOffset = _dragOffset! - notification.scrollDelta!;
          } else if (notification.metrics.axisDirection == AxisDirection.left) {
            _dragOffset = _dragOffset! + notification.scrollDelta!;
          }
          _checkDragOffset(notification.metrics.viewportDimension);
        }
      }
      if (_mode == _RefreshIndicatorMode.armed && notification.dragDetails == null) {
        // On iOS start the refresh when the Scrollable bounces back from the
        // overscroll (ScrollNotification indicating this don't have dragDetails
        // because the scroll activity is not directly triggered by a drag).
        _show();
      }
    } else if (notification is OverscrollNotification) {
      if (_mode == _RefreshIndicatorMode.drag || _mode == _RefreshIndicatorMode.armed) {
        if (notification.metrics.axisDirection == AxisDirection.right) {
          _dragOffset = _dragOffset! - notification.overscroll;
        } else if (notification.metrics.axisDirection == AxisDirection.left) {
          _dragOffset = _dragOffset! + notification.overscroll;
        }
        _checkDragOffset(notification.metrics.viewportDimension);
      }
    } else if (notification is ScrollEndNotification) {
      switch (_mode) {
        case _RefreshIndicatorMode.armed:
          _show();
        case _RefreshIndicatorMode.drag:
          _dismiss(_RefreshIndicatorMode.canceled);
        case _RefreshIndicatorMode.canceled:
        case _RefreshIndicatorMode.done:
        case _RefreshIndicatorMode.refresh:
        case _RefreshIndicatorMode.snap:
        case null:
        // do nothing
          break;
      }
    }
    return false;
  }

  bool _handleIndicatorNotification(OverscrollIndicatorNotification notification) {
    if (notification.depth != 0 || !notification.leading) {
      return false;
    }
    if (_mode == _RefreshIndicatorMode.drag) {
      notification.disallowIndicator();
      return true;
    }
    return false;
  }

  bool _start(AxisDirection direction) {
    assert(_mode == null);
    assert(_isIndicatorAtTop == null);
    assert(_dragOffset == null);
    switch (direction) {
      case AxisDirection.down:
      case AxisDirection.up:
        _isIndicatorAtTop = null;
        // we do not support vertical scroll views.
        return false;
      case AxisDirection.left:
      case AxisDirection.right:
        _isIndicatorAtTop = true;
    }
    _dragOffset = 0.0;
    _scaleController.value = 0.0;
    _positionController.value = 0.0;
    return true;
  }

  void _checkDragOffset(double containerExtent) {
    assert(_mode == _RefreshIndicatorMode.drag || _mode == _RefreshIndicatorMode.armed);
    double newValue = _dragOffset! / (containerExtent * _kDragContainerExtentPercentage);
    if (_mode == _RefreshIndicatorMode.armed) {
      newValue = math.max(newValue, 1.0 / _kDragSizeFactorLimit);
    }
    _positionController.value = clampDouble(newValue, 0.0, 1.0); // this triggers various rebuilds
    if (_mode == _RefreshIndicatorMode.drag && _positionController.value == 1.0) {
      _mode = _RefreshIndicatorMode.armed;
    }
  }

  // Stop showing the refresh indicator.
  Future<void> _dismiss(_RefreshIndicatorMode newMode) async {
    await Future<void>.value();
    // This can only be called from _show() when refreshing and
    // _handleScrollNotification in response to a ScrollEndNotification or
    // direction change.
    assert(newMode == _RefreshIndicatorMode.canceled || newMode == _RefreshIndicatorMode.done);
    setState(() {
      _mode = newMode;
    });
    switch (_mode!) {
      case _RefreshIndicatorMode.done:
        if (widget.doneWidget != null) {
          await Future.delayed(
            _kDelayedIndicatorReverseScaleDuration,
                () => _positionController.animateTo(
              0.0,
              duration: _kIndicatorReverseScaleDuration,
              curve: Curves.easeOutSine,
            ),
          );
        }
        await _scaleController.animateTo(1.0, duration: _kIndicatorScaleDuration);
      case _RefreshIndicatorMode.canceled:
        await _positionController.animateTo(0.0, duration: _kIndicatorScaleDuration);
      case _RefreshIndicatorMode.armed:
      case _RefreshIndicatorMode.drag:
      case _RefreshIndicatorMode.refresh:
      case _RefreshIndicatorMode.snap:
        assert(false);
    }
    if (mounted && _mode == newMode) {
      _dragOffset = null;
      _isIndicatorAtTop = null;
      setState(() {
        _mode = null;
      });
    }
  }

  void _show() {
    assert(_mode != _RefreshIndicatorMode.refresh);
    assert(_mode != _RefreshIndicatorMode.snap);
    final Completer<void> completer = Completer<void>();
    _pendingRefreshFuture = completer.future;
    _mode = _RefreshIndicatorMode.snap;
    _positionController
        .animateTo(1.0 / _kDragSizeFactorLimit, duration: _kIndicatorSnapDuration)
        .then<void>((void value) {
      if (mounted && _mode == _RefreshIndicatorMode.snap) {
        setState(() {
          // Show the indeterminate progress indicator.
          _mode = _RefreshIndicatorMode.refresh;
        });

        final Future<void> refreshResult = widget.onRefresh();
        refreshResult.whenComplete(() {
          if (mounted && _mode == _RefreshIndicatorMode.refresh) {
            completer.complete();
            _dismiss(_RefreshIndicatorMode.done);
          }
        });
      }
    });
  }

  /// Show the refresh indicator and run the refresh callback as if it had
  /// been started interactively. If this method is called while the refresh
  /// callback is running, it quietly does nothing.
  ///
  /// Creating the [CustomRefreshIndicator] with a [GlobalKey<RefreshIndicatorState>]
  /// makes it possible to refer to the [CustomRefreshIndicatorState].
  ///
  /// The future returned from this method completes when the
  /// [CustomRefreshIndicator.onRefresh] callback's future completes.
  ///
  /// If you await the future returned by this function from a [State], you
  /// should check that the state is still [mounted] before calling [setState].
  ///
  /// When initiated in this manner, the refresh indicator is independent of any
  /// actual scroll view. It defaults to showing the indicator at the top. To
  /// show it at the bottom, set `atTop` to false.
  Future<void> show({bool atTop = true}) {
    if (_mode != _RefreshIndicatorMode.refresh && _mode != _RefreshIndicatorMode.snap) {
      if (_mode == null) {
        _start(atTop ? AxisDirection.right : AxisDirection.left);
      }
      _show();
    }
    return _pendingRefreshFuture;
  }

  @override
  Widget build(BuildContext context) {
    assert(() {
      if (_mode == null) {
        assert(_dragOffset == null);
        assert(_isIndicatorAtTop == null);
      } else {
        assert(_dragOffset != null);
        assert(_isIndicatorAtTop != null);
      }
      return true;
    }());

    Widget child;

    final bool hasManyIndicators = widget.inProgessWidget != null || widget.doneWidget != null;

    if (_mode == _RefreshIndicatorMode.refresh && widget.inProgessWidget != null) {
      child = widget.inProgessWidget!;
    } else if (_mode == _RefreshIndicatorMode.done && widget.doneWidget != null) {
      child = widget.doneWidget!;
    } else {
      child = widget.indicator;
    }

    if (hasManyIndicators) {
      child = AnimatedSwitcher(
        duration: const Duration(milliseconds: 90),
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: animation,
            child: AnimatedSwitcher.defaultTransitionBuilder(child, animation),
          );
        },
        child: child,
      );
    }

    Widget animatedIndicator = ScaleTransition(
      scale: _scaleFactor,
      child: child,
    );

    final padding = _isIndicatorAtTop == null
        ? EdgeInsets.zero
        : _isIndicatorAtTop!
        ? EdgeInsets.only(left: widget.displacement)
        : EdgeInsets.only(right: widget.displacement);

    final alignment = _isIndicatorAtTop == null
        ? Alignment.center
        : _isIndicatorAtTop!
        ? Alignment.centerLeft
        : Alignment.centerRight;

    animatedIndicator = Padding(
      padding: padding,
      child: Align(
        alignment: alignment,
        child: animatedIndicator,
      ),
    );

    final double axisAlignment = _isIndicatorAtTop == null
        ? 0.0
        : _isIndicatorAtTop!
        ? 1.0
        : -1.0;

    if (widget._useSliver) {
      animatedIndicator = _SliverSizeTransition(
        axis: Axis.horizontal,
        axisAlignment: axisAlignment,
        sizeFactor: _positionFactor, // this is what brings it down
        child: animatedIndicator,
      );
    } else {
      animatedIndicator = SizeTransition(
        axis: Axis.horizontal,
        axisAlignment: axisAlignment,
        sizeFactor: _positionFactor, // this is what brings it down
        child: animatedIndicator,
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: _handleIndicatorNotification,
        child: widget.builder(animatedIndicator, _isIndicatorAtTop ?? false),
      ),
    );
  }
}

class _SliverSizeTransition extends AnimatedWidget {
  /// Creates a size transition.
  ///
  /// The [axis], [sizeFactor], and [axisAlignment] arguments must not be null.
  /// The [axis] argument defaults to [Axis.vertical]. The [axisAlignment]
  /// defaults to 0.0, which centers the child along the main axis during the
  /// transition.
  const _SliverSizeTransition({
    super.key,
    this.axis = Axis.vertical,
    required Animation<double> sizeFactor,
    this.axisAlignment = 0.0,
    this.child,
  }) : super(listenable: sizeFactor);

  /// [Axis.horizontal] if [sizeFactor] modifies the width, otherwise
  /// [Axis.vertical].
  final Axis axis;

  /// The animation that controls the (clipped) size of the child.
  ///
  /// The width or height (depending on the [axis] value) of this widget will be
  /// its intrinsic width or height multiplied by [sizeFactor]'s value at the
  /// current point in the animation.
  ///
  /// If the value of [sizeFactor] is less than one, the child will be clipped
  /// in the appropriate axis.
  Animation<double> get sizeFactor => listenable as Animation<double>;

  /// Describes how to align the child along the axis that [sizeFactor] is
  /// modifying.
  ///
  /// A value of -1.0 indicates the top when [axis] is [Axis.vertical], and the
  /// start when [axis] is [Axis.horizontal]. The start is on the left when the
  /// text direction in effect is [TextDirection.ltr] and on the right when it
  /// is [TextDirection.rtl].
  ///
  /// A value of 1.0 indicates the bottom or end, depending upon the [axis].
  ///
  /// A value of 0.0 (the default) indicates the center for either [axis] value.
  final double axisAlignment;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final AlignmentDirectional alignment;
    if (axis == Axis.vertical) {
      alignment = AlignmentDirectional(-1.0, axisAlignment);
    } else {
      alignment = AlignmentDirectional(axisAlignment, -1.0);
    }
    return SliverClipRect(
      child: SliverToBoxAdapter(
        child: Align(
          alignment: alignment,
          heightFactor: axis == Axis.vertical ? math.max(sizeFactor.value, 0.0) : null,
          widthFactor: axis == Axis.horizontal ? math.max(sizeFactor.value, 0.0) : null,
          child: child,
        ),
      ),
    );
  }
}
