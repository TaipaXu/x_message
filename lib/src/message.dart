import 'package:flutter/material.dart';
import 'dart:async';

class Message {
  static const double _width = 300;
  static const double _spacer = 15;
  static const Duration _duration = Duration(seconds: 10);
  static const EdgeInsets _padding = EdgeInsets.all(10);
  static const double _fontSize = 16;
  static const TextAlign _textAlign = TextAlign.left;
  static const TextOverflow _overFlow = TextOverflow.fade;
  static const bool _softWrap = false;
  static const Color _color = Colors.black;
  static const Color _backgroundColor = Colors.white;
  static const BorderSide _borderSide = BorderSide(
    color: Colors.black12,
    width: 0.5,
  );
  static const Border _border = Border(
    top: _borderSide,
    right: _borderSide,
    bottom: _borderSide,
    left: _borderSide,
  );
  static const double _borderRadius = 6;
  static const bool _showClose = true;
  static const Widget _close = Icon(
    Icons.close,
    size: 16,
    color: Colors.black87,
  );

  static final List<Widget> _items = [];
  static double _defaultWidth = _width;
  static double _defaultSpacer = _spacer;
  static Duration _defaultDuration = _duration;
  static EdgeInsets _defaultPadding = _padding;
  static double _defaultFontSize = _fontSize;
  static TextAlign _defaultTextAlign = _textAlign;
  static TextOverflow _defaultOverFlow = _overFlow;
  static bool _defaultSoftWrap = _softWrap;
  static Color _defaultColor = _color;
  static Color _defaultBackgroundColor = _backgroundColor;
  static Border _defaultBorder = _border;
  static double _defaultBorderRadius = _borderRadius;
  static bool _defaultShowClose = _showClose;
  static Widget _defaultClose = _close;

  static bool _overlayEntryInserted = false;
  static OverlayEntry? _overlayEntry;
  static final GlobalKey<AnimatedListState> _animatedListKey =
      GlobalKey<AnimatedListState>();
  static StateSetter? _setState;
  Completer _overlayEntryCompleter = Completer();

  final _insertDuration = const Duration(milliseconds: 200);

  late final Widget _widget;

  Message({
    required BuildContext context,
    final String? message,
    double? width,
    double? spacer,
    Duration? duration,
    EdgeInsets? padding,
    double? fontSize,
    TextAlign? textAlign,
    TextOverflow? overflow,
    bool? softWrap,
    Color? color,
    Color? backgroundColor,
    Border? border,
    double? borderRadius,
    bool? showClose,
    Widget? close,
    final Widget? child,
  })  : assert(message == null || child == null,
            'Cannot provide both a message and a child.'),
        assert(
            child == null ||
                (padding == null &&
                    fontSize == null &&
                    textAlign == null &&
                    overflow == null &&
                    softWrap == null &&
                    color == null &&
                    backgroundColor == null &&
                    border == null &&
                    borderRadius == null &&
                    showClose == null &&
                    close == null),
            'Those attributes are only set to meessage.') {
    width ??= _defaultWidth;
    spacer ??= _defaultSpacer;
    duration ??= _defaultDuration;
    padding ??= _defaultPadding;
    fontSize ??= _defaultFontSize;
    textAlign ??= _defaultTextAlign;
    overflow ??= _defaultOverFlow;
    softWrap ??= _defaultSoftWrap;
    color ??= _defaultColor;
    backgroundColor ??= _defaultBackgroundColor;
    border ??= _defaultBorder;
    borderRadius ??= _defaultBorderRadius;
    showClose ??= _defaultShowClose;
    close ??= _defaultClose;

    if (message != null) {
      _widget = Material(
        color: Colors.transparent,
        child: Container(
          margin: EdgeInsets.only(top: spacer),
          decoration: BoxDecoration(
            color: backgroundColor,
            border: border,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Padding(
            padding: padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(fontSize: fontSize, color: color),
                    overflow: overflow,
                    softWrap: softWrap,
                    textAlign: textAlign,
                  ),
                ),
                Offstage(
                  offstage: !showClose,
                  child: InkWell(
                    onTap: () => _removeWidget(_widget),
                    child: close,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      _widget = Material(
        color: Colors.transparent,
        child: child!,
      );
    }

    if (!_overlayEntryInserted) {
      _overlayEntry = OverlayEntry(
        builder: (BuildContext context) => Positioned(
          top: MediaQuery.of(context).padding.top,
          left: 0,
          right: 0,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              if (_setState == null) {
                _setState = setState;
                _overlayEntryCompleter.complete();
              }

              return Center(
                child: SizedBox(
                  width: width,
                  child: AnimatedList(
                    key: _animatedListKey,
                    shrinkWrap: true,
                    initialItemCount: _items.length,
                    itemBuilder: (BuildContext context, int index,
                            Animation<double> animation) =>
                        SizeTransition(
                      sizeFactor: animation,
                      child: _items[index],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );

      Overlay.of(context)!.insert(_overlayEntry!);
      _overlayEntryInserted = true;
    }

    _insert();

    Future.delayed(duration, () async {
      final int index = _items.indexOf(_widget);
      if (index > -1) {
        _removeItem(index);
      }
    });
  }

  void _insert() async {
    if (_setState == null) {
      await _overlayEntryCompleter.future;
    }
    _setState!(() {
      _items.insert(0, _widget);
      _animatedListKey.currentState?.insertItem(0, duration: _insertDuration);
    });
  }

  void remove() {
    _removeWidget(_widget);
  }

  void _removeItem(final int index) async {
    Widget item = _items[index];
    _animatedListKey.currentState!.removeItem(
        index,
        (BuildContext context, Animation<double> animation) => SizeTransition(
              sizeFactor: animation,
              child: item,
            ),
        duration: _insertDuration);
    _items.removeAt(index);

    if (_items.isEmpty) {
      await Future.delayed(_insertDuration);
      _overlayEntry?.remove();
      _setState = null;
      _overlayEntryCompleter = Completer();
      _overlayEntryInserted = false;
    }
  }

  void _removeWidget(Widget widget) {
    final int index = _items.indexOf(widget);
    if (index > -1) {
      _removeItem(index);
    }
  }

  static set defaultWidth(final double width) => _defaultWidth = width;

  static void resetDefaultWidth() => _defaultWidth = _width;

  static set defaultSpacer(final double spacer) => _defaultSpacer = spacer;

  static void resetDefaultSpacer() => _defaultSpacer = _spacer;

  static set defaultDuration(Duration duration) => _defaultDuration = duration;

  static void resetDefaultDuration() => _defaultDuration = _duration;

  static set defaultPadding(final EdgeInsets padding) =>
      _defaultPadding = padding;

  static void resetDefaultPadding() => _defaultPadding = _padding;

  static set defaultFontSize(final double fontSize) =>
      _defaultFontSize = fontSize;

  static void resetDefaultFontSize() => _defaultFontSize = _fontSize;

  static set defaultTextAlign(final TextAlign textAlign) =>
      _defaultTextAlign = textAlign;

  static void resetDefaultTextAlign() => _defaultTextAlign = _textAlign;

  static set defaultOverFlow(final TextOverflow overFlow) =>
      _defaultOverFlow = overFlow;

  static void resetDefaultOverFlow() => _defaultOverFlow = _overFlow;

  static set defaultSoftWrap(final bool softWrap) =>
      _defaultSoftWrap = softWrap;

  static void resetDefaultSoftWrap() => _defaultSoftWrap = _softWrap;

  static set defaultColor(final Color color) => _defaultColor = color;

  static void resetDefaultColor() => _defaultColor = _color;

  static set defaultBackgroundColor(final Color backgroundColor) =>
      _defaultBackgroundColor = backgroundColor;

  static void resetDefaultBackgroundColor() =>
      _defaultBackgroundColor = _backgroundColor;

  static set defaultBorder(final Border border) => _defaultBorder = border;

  static void resetDefaultBorder() => _defaultBorder = _border;

  static set defaultBorderRadius(final double borderRadius) =>
      _defaultBorderRadius = borderRadius;

  static void resetDefaultBorderRadius() =>
      _defaultBorderRadius = _borderRadius;

  static set defaultShowClose(final bool showClose) =>
      _defaultShowClose = showClose;

  static void resetDefaultShowClose() => _defaultShowClose = _showClose;

  static set defaultClose(final Widget close) => _defaultClose = close;

  static void resetDefaultClose() => _defaultClose = _close;

  static void reset() {
    resetDefaultWidth();
    resetDefaultSpacer();
    resetDefaultDuration();
    resetDefaultPadding();
    resetDefaultFontSize();
    resetDefaultTextAlign();
    resetDefaultOverFlow();
    resetDefaultSoftWrap();
    resetDefaultColor();
    resetDefaultBackgroundColor();
    resetDefaultBorder();
    resetDefaultBorderRadius();
    resetDefaultShowClose();
    resetDefaultClose();
  }
}
