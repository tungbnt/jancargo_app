// dropdown_plus_plus: ^0.1.1+1

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/foundation.dart';

/*
class DropdownEditingController<T> extends ChangeNotifier {
  T? _value;

  DropdownEditingController({T? value}) : _value = value;

  T? get value => _value;

  set value(T? newValue) {
    if (_value == newValue) return;
    _value = newValue;
    notifyListeners();
  }

  @override
  String toString() => '${describeIdentity(this)}($value)';
}
*/

/// Create a dropdown form field
class DropdownFormField<T> extends StatefulWidget {
  final bool autoFocus;

  final T? selectedItem;

  final bool enableSearch;

  /// It will trigger on user search
  final bool Function(T item, String str)? filterItems;

  /// Check item is selectd
  final bool Function(T? item1, T? item2)? selectionTester;

  /// Return list of items what need to list for dropdown.
  /// The list may be offline, or remote data from server.
  final Future<List<T>?> Function(String keywords) findFn;

  /// Build dropdown Items, it get called for all dropdown items
  ///  [item] = [dynamic value] List item to build dropdown Listtile
  /// [lasSelectedItem] = [null | dynamic value] last selected item, it gives user chance to highlight selected item
  /// [position] = [0,1,2...] Index of the list item
  /// [focused] = [true | false] is the item if focused, it gives user chance to highlight focused item
  /// [onTap] = [Function] *important! just assign this function to Listtile.onTap  = onTap, incase you missed this,
  /// the click event if the dropdown item will not work.
  ///
  final Widget Function(
    T item,
    int position,
    bool focused,
    bool selected,
    Function() onTap,
  ) dropdownItemFn;

  /// Build widget to display selected item inside Form Field
  final Widget Function(T? item) selectedItemBuilder;

  final String Function(T? selectedItem)? hintTextBuilder;

  final double? width;

  final InputDecoration? decoration;
  final Decoration dropdownDecoration;
  final EdgeInsetsGeometry dropdownPadding;

  // final DropdownEditingController<T>? controller;
  final void Function(T? item)? onChanged;
  final void Function(T?)? onSaved;
  final String? Function(T?)? validator;

  final double? dropdownWidth;

  /// height of the dropdown overlay, Default: 240
  final double? dropdownHeight;

  /// Style the search box text
  final TextStyle? searchTextStyle;

  /// Cursor color of the search box
  final Color? cursorColor;

  /// Message to disloay if the search dows not match with any item, Default : "No matching found!"
  final String emptyText;

  /// Give action text if you want handle the empty search.
  final String emptyActionText;

  /// this functon triggers on click of emptyAction button
  final Future<void> Function(String value)? onEmptyActionPressed;

  /// Separator between the dropdown items
  final Widget? dropdownItemSeparator;

  const DropdownFormField({
    Key? key,
    this.selectedItem,
    this.width,
    required this.dropdownItemFn,
    this.enableSearch = true,
    required this.selectedItemBuilder,
    this.hintTextBuilder,
    required this.findFn,
    this.filterItems,
    this.autoFocus = false,
    // this.controller,
    this.validator,
    this.decoration,
    this.dropdownDecoration = const BoxDecoration(),
    this.dropdownPadding = const EdgeInsets.symmetric(vertical: 4),
    this.onChanged,
    this.onSaved,
    this.dropdownWidth,
    this.dropdownHeight,
    this.searchTextStyle,
    this.cursorColor,
    this.emptyText = "No matching found!",
    this.emptyActionText = 'Create new',
    this.onEmptyActionPressed,
    this.dropdownItemSeparator,
    this.selectionTester,
  }) : super(key: key);

  @override
  DropdownFormFieldState createState() => DropdownFormFieldState<T>();
}

class DropdownFormFieldState<T> extends State<DropdownFormField<T>>
    with SingleTickerProviderStateMixin {
  final FocusNode _widgetFocusNode = FocusNode();
  final FocusNode _searchFocusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  final ValueNotifier<List<T>> _listItemsValueNotifier =
      ValueNotifier<List<T>>([]);
  final TextEditingController _searchTextController = TextEditingController();

  bool defaultSelectionTester(dynamic item1, dynamic item2) => item1 == item2;

  bool get _isEmpty => _selectedItem == null;
  bool _isFocused = false;

  OverlayEntry? _overlayEntry;
  OverlayEntry? _overlayBackdropEntry;
  List<T>? _options;
  int _listItemFocusedPosition = 0;
  T? _selectedItem;
  Widget? _displayItem;
  Timer? _debounce;
  String? _lastSearchString;

  @override
  void initState() {
    super.initState();

    if (widget.autoFocus) _widgetFocusNode.requestFocus();

    _searchFocusNode.addListener(() {
      if (!_searchFocusNode.hasFocus && _overlayEntry != null) {
        _removeOverlay();
      }
    });

    _selectedItem = widget.selectedItem;
  }

  @override
  void didUpdateWidget(DropdownFormField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // if(oldWidget.selectedItem == null && widget.selectedItem == null){
    //   return;
    // }

    // widget.findFn(_searchTextController.value.text).then((value) {
    //   if(value == null){
    //     _selectedItem = widget.selectedItem;
    //
    //     setState(() {});
    //   }
    //   return null;
    // });

    _selectedItem = widget.selectedItem;

    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _debounce?.cancel();
    _searchTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print("_overlayEntry : $_overlayEntry");

    _displayItem = widget.selectedItemBuilder(_selectedItem);

    final Widget child;

    if (widget.enableSearch) {
      child = CompositedTransformTarget(
        link: this._layerLink,
        child: GestureDetector(
          onTap: () {
            _widgetFocusNode.requestFocus();
            _toggleOverlay();
          },
          child: Focus(
            autofocus: widget.autoFocus,
            focusNode: _widgetFocusNode,
            onFocusChange: (focused) {
              setState(() {
                _isFocused = focused;
              });
            },
            onKey: (focusNode, event) {
              return _onKeyPressed(event);
            },
            child: FormField(
              validator: (str) {
                if (widget.validator != null) {
                  return widget.validator!(_selectedItem);
                } else {
                  return null;
                }
              },
              onSaved: (str) {
                if (widget.onSaved != null) {
                  widget.onSaved!(_selectedItem);
                }
              },
              builder: (state) {
                return InputDecorator(
                  decoration: (widget.decoration ??
                          const InputDecoration(
                            border: UnderlineInputBorder(),
                            suffixIcon: Icon(Icons.arrow_drop_down),
                          ))
                      .copyWith(
                    hintText: widget.hintTextBuilder?.call(_selectedItem) ?? '',
                  ),
                  isEmpty: _isEmpty,
                  isFocused: _isFocused,
                  child: this._overlayEntry == null
                      ? _displayItem ?? const SizedBox()
                      : EditableText(
                          style: widget.searchTextStyle ??
                              const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                          // readOnly: widget.enableSearch,
                          controller: _searchTextController,
                          cursorColor: widget.cursorColor ?? Colors.black87,
                          focusNode: _searchFocusNode,
                          backgroundCursorColor: Colors.transparent,
                          onChanged: (str) {
                            if (_overlayEntry == null) {
                              _addOverlay();
                            }
                            _onTextChanged(str);
                          },
                          onSubmitted: (str) {
                            _searchTextController.value =
                                const TextEditingValue(text: "");
                            _setValue();
                            _removeOverlay();
                            _widgetFocusNode.nextFocus();
                          },
                          onEditingComplete: () {},
                        ),
                );
              },
            ),
          ),
        ),
      );
    } else {
      child = CompositedTransformTarget(
        link: this._layerLink,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (_overlayEntry == null) {
              _addOverlay();
            } else {
              _removeOverlay();
            }

            // _toggleOverlay();
          },
          child: _displayItem ?? const SizedBox.expand(),
        ),
      );
    }

    if (widget.width == null) return child;

    return SizedBox(
      width: widget.width,
      child: child,
    );
  }

  OverlayEntry _createOverlayEntry() {
    late final renderObject = context.findRenderObject() as RenderBox;
    // print(renderObject);
    late final Size size = renderObject.size;

    var overlay = OverlayEntry(builder: (context) {
      return Positioned(
        width: widget.dropdownWidth ?? size.width,
        child: CompositedTransformFollower(
          link: this._layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 3.0),
          child: SizedBox(
            height: widget.dropdownHeight,
            child: Container(
              decoration: widget.dropdownDecoration,
              child: Material(
                type: MaterialType.transparency,
                child: ValueListenableBuilder(
                  valueListenable: _listItemsValueNotifier,
                  builder: (context, List<T> items, child) {
                    return _options != null && _options!.isNotEmpty
                        ? ListView.separated(
                            separatorBuilder: (context, index) {
                              return widget.dropdownItemSeparator ??
                                  Container();
                            },
                            shrinkWrap: true,
                            padding: widget.dropdownPadding,
                            itemCount: _options!.length,
                            itemBuilder: (context, position) {
                              T item = _options![position];
                              return widget.dropdownItemFn(
                                item,
                                position,
                                position == _listItemFocusedPosition,
                                (widget.selectionTester ??
                                        defaultSelectionTester)(
                                    _selectedItem, item),
                                () {
                                  _listItemFocusedPosition = position;
                                  _searchTextController.value =
                                      TextEditingValue(
                                    text: widget.hintTextBuilder?.call(item) ??
                                        '',
                                  );
                                  _removeOverlay();
                                  _setValue();
                                },
                              );
                            },
                          )
                        : Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  widget.emptyText,
                                  style: const TextStyle(color: Colors.black45),
                                ),
                                if (widget.onEmptyActionPressed != null)
                                  TextButton(
                                    onPressed: () async {
                                      await widget.onEmptyActionPressed!(
                                          _searchTextController.value.text);
                                      _search(_searchTextController.value.text);
                                    },
                                    child: Text(widget.emptyActionText),
                                  ),
                              ],
                            ),
                          );
                  },
                ),
              ),
            ),
          ),
        ),
      );
    });

    return overlay;
  }

  OverlayEntry _createBackdropOverlay() {
    return OverlayEntry(
        builder: (context) => Positioned(
            left: 0,
            top: 0,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GestureDetector(
              onTap: () {
                _removeOverlay();
              },
            )));
  }

  _addOverlay() {
    if (_overlayEntry == null) {
      _search("");
      _overlayBackdropEntry = _createBackdropOverlay();
      _overlayEntry = _createOverlayEntry();
      if (_overlayEntry != null) {
        // Overlay.of(context)!.insert(_overlayEntry!);
        Overlay.of(context).insertAll([_overlayBackdropEntry!, _overlayEntry!]);
        setState(() {
          _searchFocusNode.requestFocus();
        });
      }
    }
  }

  /// Dettach overlay from the dropdown widget
  _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayBackdropEntry!.remove();
      _overlayEntry!.remove();
      _overlayEntry = null;
      _searchTextController.value = TextEditingValue.empty;
      setState(() {});
    }
  }

  _toggleOverlay() {
    if (_overlayEntry == null)
      _addOverlay();
    else
      _removeOverlay();
  }

  _onTextChanged(String? str) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      // print("_onChanged: $_lastSearchString = $str");
      if (_lastSearchString != str) {
        _lastSearchString = str;
        _search(str ?? "");
      }
    });
  }

  _onKeyPressed(RawKeyEvent event) {
    // print('_onKeyPressed : ${event.character}');
    if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
      if (_searchFocusNode.hasFocus) {
        _toggleOverlay();
      } else {
        _toggleOverlay();
      }
      return KeyEventResult.ignored;
    } else if (event.isKeyPressed(LogicalKeyboardKey.escape)) {
      _removeOverlay();
      return KeyEventResult.handled;
    } else if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
      int v = _listItemFocusedPosition;
      v++;
      if (v >= _options!.length) v = 0;
      _listItemFocusedPosition = v;
      _listItemsValueNotifier.value = List<T>.from(_options ?? []);
      return KeyEventResult.handled;
    } else if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
      int v = _listItemFocusedPosition;
      v--;
      if (v < 0) v = _options!.length - 1;
      _listItemFocusedPosition = v;
      _listItemsValueNotifier.value = List<T>.from(_options ?? []);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  _search(String str) async {
    List<T>? items = await widget.findFn(str);

    if (str.isNotEmpty && widget.filterItems != null) {
      items = items?.where((item) => widget.filterItems!(item, str)).toList();
    }

    _options = items;

    if (items == null) {
      _selectedItem = null;
      setState(() {});
    }

    _listItemsValueNotifier.value = items ?? [];

    // print('_search ${_options!.length}');
  }

  _setValue() {
    if (_options != null && _options!.isNotEmpty) {
      var item = _options![_listItemFocusedPosition];
      _selectedItem = item;
      widget.onChanged?.call(_selectedItem);
    }

    setState(() {});
  }

  _clearValue() {
    if (widget.onChanged != null) {
      widget.onChanged!(_selectedItem);
    }
    _searchTextController.value = const TextEditingValue(text: "");
  }
}
