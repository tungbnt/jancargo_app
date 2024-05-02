import 'package:animated_search_bar/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../general/constants/app_styles.dart';

/// A customizable animated search bar widget for Flutter applications.
class AnimatedSearchBarCustom extends StatefulWidget {
  /// Creates an `AnimatedSearchBar` widget.
  ///
  /// [label] is the text to display when the search bar is not active.
  /// [labelAlignment] specifies the alignment of the label text.
  /// [labelTextAlign] specifies the text alignment of the label.
  /// [onChanged] is a callback function that is called,
  ///    when the text in the search bar changes.
  /// [labelStyle] is the style for the label text.
  /// [searchDecoration] is the decoration for the search input field.
  /// [animationDuration] is the duration for the animation,
  ///   when switching between label and search input.
  /// [searchStyle] is the style for the search input text.
  /// [cursorColor] is the color of the cursor in the search input field.
  /// [duration] is the debounce duration for input changes.
  /// [height] is the height of the search bar.
  /// [closeIcon] is the icon to display when the search bar is active.
  /// [searchIcon] is the icon to display when the search bar is not active.
  /// [controller] is a TextEditingController to control the text input.
  /// [onFieldSubmitted] is a callback function that is called
  ///  when the user submits the search field.
  /// [textInputAction] is the action to take when the user presses
  ///   the keyboard's done button.

  const AnimatedSearchBarCustom(
      {Key? key,
      required this.label,
      this.labelAlignment = Alignment.centerLeft,
      this.labelTextAlign = TextAlign.start,
      this.onChanged,
      this.labelStyle = const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      this.searchDecoration = const InputDecoration(
        labelText: 'Search',
        alignLabelWithHint: true,
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      this.animationDuration = const Duration(milliseconds: 350),
      this.searchStyle = const TextStyle(color: Colors.black),
      this.cursorColor,
      this.duration = const Duration(milliseconds: 300),
      this.height = 60,
      this.closeIcon = const Icon(Icons.close, key: ValueKey('close')),
      this.searchIcon = const Icon(Icons.search, key: ValueKey('search')),
      this.controller,
      this.onFieldSubmitted,
      this.textInputAction = TextInputAction.search,
      this.onClose, this.focusNode, this.textStyle, this.contentPadding, this.prefixWidget, this.suffixWidget, this.textColor, this.focusedColor, this.underFocusedColor, this.underEnableColor, this.enableColor, this.hintText})
      : super(key: key);

  final Widget label;
  final Alignment labelAlignment;
  final TextAlign labelTextAlign;
  final Function(String)? onChanged;
  final TextStyle labelStyle;
  final InputDecoration searchDecoration;
  final Duration animationDuration;
  final TextStyle searchStyle;
  final Color? cursorColor;
  final Duration duration;
  final double height;
  final Widget closeIcon;
  final Widget searchIcon;
  final TextEditingController? controller;
  final Function(String)? onFieldSubmitted;
  final TextInputAction textInputAction;
  final VoidCallback? onClose;
  final FocusNode? focusNode;
  final TextStyle? textStyle;
  final EdgeInsets? contentPadding;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final Color? textColor;
  final Color? focusedColor;
  final Color? underFocusedColor;
  final Color? underEnableColor;
  final Color? enableColor;
  final String? hintText;

  @override
  _AnimatedSearchBarCustomState createState() =>
      _AnimatedSearchBarCustomState();
}

class _AnimatedSearchBarCustomState extends State<AnimatedSearchBarCustom> {
  final ValueNotifier<bool> _isSearch = ValueNotifier(false);
  final _fnSearch = FocusNode();
  final _debouncer = Debouncer();

  late TextEditingController _conSearch;

  @override
  void initState() {
    super.initState();
    _conSearch = widget.controller ?? TextEditingController();
    _isSearch.value = _conSearch.text.isNotEmpty;
    _debouncer.delay = widget.duration;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!_isSearch.value) {
          _isSearch.value = true;
          _fnSearch.requestFocus();
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: _isSearch,
              builder: (_, bool value, __) {
                return value
                    ? SizedBox(
                        key: const ValueKey('textF'),
                        height: widget.height,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                           decoration: BoxDecoration(
                             color: AppColors.white,
                             borderRadius: BorderRadius.all(Radius.circular(AppGap.r4),),
                           ),
                            child: TextFormField(
                              focusNode: _fnSearch,
                              controller: _conSearch,
                              keyboardType: TextInputType.text,
                              textInputAction: widget.textInputAction,
                              textAlign: widget.labelTextAlign,
                              style: widget.searchStyle,
                              minLines: 1,
                              cursorColor: widget.cursorColor ??
                                  ThemeData().primaryColor,
                              textAlignVertical: TextAlignVertical.center,
                              decoration:InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: widget.hintText,
                                hintStyle: AppStyles.text4010(),
                                label: widget.label,
                                labelStyle: AppStyles.text5014(),
                                border: InputBorder.none,
                                contentPadding: widget.contentPadding ?? const EdgeInsets.symmetric(horizontal: 8),
                                focusedBorder: widget.underFocusedColor == null
                                    ? OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: widget.focusedColor ?? AppColors.neutral200Color,
                                  ),
                                  borderRadius: BorderRadius.circular(0),
                                )
                                    : UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: widget.underFocusedColor ?? AppColors.neutral200Color,
                                  ),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                enabledBorder: widget.underEnableColor == null
                                    ? OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: widget.enableColor ??AppColors.neutral200Color,
                                  ),
                                  borderRadius: BorderRadius.circular(0),
                                )
                                    : UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: widget.underEnableColor ?? AppColors.neutral200Color,
                                  ),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                prefixIcon: widget.prefixWidget == null
                                    ? null
                                    : Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  alignment: Alignment.center,
                                  width: 16,
                                  child: widget.prefixWidget,
                                ),
                                suffixIcon: widget.suffixWidget == null
                                    ? null
                                    : Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  alignment: Alignment.center,
                                  width: 16,
                                  child: widget.suffixWidget,
                                ),
                              ),
                              onChanged: (value) {
                                _debouncer.run(() {
                                  widget.onChanged!(value);
                                });
                              },
                              onFieldSubmitted: widget.onFieldSubmitted,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        key: const ValueKey('align'),
                        height: 60,
                        child: Align(
                          alignment: widget.labelAlignment,
                          child: widget.label,
                        ),
                      );
              },
            ),
          ),
          IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              transitionBuilder: (Widget child, Animation<double> animation) {
                final inAnimation = Tween<Offset>(
                  begin: const Offset(0.0, 1.0),
                  end: const Offset(0.0, 0.0),
                ).animate(animation);
                final outAnimation = Tween<Offset>(
                  begin: const Offset(0.0, -1.0),
                  end: const Offset(0.0, 0.0),
                ).animate(animation);

                return ClipRect(
                  child: SlideTransition(
                    position: child.key == const ValueKey('close')
                        ? inAnimation
                        : outAnimation,
                    child: child,
                  ),
                );
              },
              child: ValueListenableBuilder(
                valueListenable: _isSearch,
                builder: (_, bool value, __) {
                  return value ? widget.closeIcon : widget.searchIcon;
                },
              ),
            ),
            onPressed: () {
              if (_isSearch.value && _conSearch.text.isNotEmpty) {
                _conSearch.clear();
                widget.onChanged!(_conSearch.text);
              } else {
                _isSearch.value = !_isSearch.value;
                if (!_isSearch.value) widget.onClose?.call();
                if (_isSearch.value) _fnSearch.requestFocus();
              }
            },
          ),
        ],
      ),
    );
  }
}
