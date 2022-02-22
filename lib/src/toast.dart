import 'package:flutter/material.dart';

enum ToastPosition {
  top,
  center,
  bottom,
}

// const double _defaultToEdge = 30;

class Toast {
  static const double _toEdge = 30;
  static const ToastPosition _position = ToastPosition.bottom;
  static const Duration _duration = Duration(seconds: 1, milliseconds: 500);
  static const EdgeInsets _padding = EdgeInsets.all(10);
  static const double _fontSize = 15;
  static const Color _color = Colors.white;
  static const Color _backgroundColor = Colors.black87;
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

  static double _defaultToEdge = _toEdge;
  static ToastPosition _defaultPosition = _position;
  static Duration _defaultDuration = _duration;
  static EdgeInsets _defaultPadding = _padding;
  static double _defaultFontSize = _fontSize;
  static Color _defaultColor = _color;
  static Color _defaultBackgroundColor = _backgroundColor;
  static Border _defaultBorder = _border;
  static double _defaultBorderRadius = _borderRadius;

  final _opacityDuration = const Duration(milliseconds: 250);
  final _offsetDuration = const Duration(milliseconds: 350);

  Toast({
    required BuildContext context,
    double? toEdge,
    ToastPosition? position,
    Duration? duration,
    final String? message,
    EdgeInsets? padding,
    double? fontSize,
    Color? color,
    Color? backgroundColor,
    Border? border,
    double? borderRadius,
    final Widget? child,
  })  : assert(message == null || child == null,
            'Cannot provide both a message and a child.'),
        assert(
            child == null ||
                (padding == null &&
                    fontSize == null &&
                    color == null &&
                    backgroundColor == null &&
                    border == null &&
                    borderRadius == null),
            'Those attributes are only set to meessage.') {
    toEdge ??= _defaultToEdge;
    position ??= _defaultPosition;
    duration ??= _defaultDuration;
    padding ??= _defaultPadding;
    fontSize ??= _defaultFontSize;
    color ??= _defaultColor;
    backgroundColor ??= _defaultBackgroundColor;
    border ??= _defaultBorder;
    borderRadius ??= _defaultBorderRadius;

    double? top = 0;
    double? bottom = 0;
    if (position == ToastPosition.top) {
      top = toEdge;
      bottom = null;
    } else if (position == ToastPosition.bottom) {
      top = null;
      bottom = toEdge;
    }

    final overlayState = Overlay.of(context);

    final showController = AnimationController(
      vsync: overlayState as TickerProvider,
      duration: _opacityDuration,
    );
    final showAnimation = Tween(begin: 0.0, end: 1.0).animate(showController);

    final offsetController = AnimationController(
      vsync: overlayState as TickerProvider,
      duration: _offsetDuration,
    );

    final offsetCurvedAnimation = CurvedAnimation(
      parent: offsetController,
      curve: Curves.easeOutQuart,
    );
    final offsetAnimation =
        Tween(begin: position == ToastPosition.top ? -20.0 : 20.0, end: 0.0)
            .animate(offsetCurvedAnimation);

    final hideController = AnimationController(
      vsync: overlayState as TickerProvider,
      duration: _opacityDuration,
    );
    final hideAnimation = Tween(begin: 1.0, end: 0.0).animate(hideController);

    final OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: top,
        bottom: bottom,
        left: 0,
        right: 0,
        child: AnimatedBuilder(
          animation: showAnimation,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                color: Colors.transparent,
                child: child ??
                    _buildMessage(
                      message: message!,
                      padding: padding!,
                      fontSize: fontSize!,
                      color: color!,
                      backgroundColor: backgroundColor!,
                      border: border!,
                      borderRadius: borderRadius!,
                    ),
              ),
            ],
          ),
          builder: (BuildContext context, Widget? widget) => Opacity(
            opacity: showAnimation.value,
            child: AnimatedBuilder(
              animation: offsetAnimation,
              builder: (BuildContext context, _) => Transform.translate(
                offset: Offset(0, offsetAnimation.value),
                child: AnimatedBuilder(
                  animation: hideAnimation,
                  builder: (BuildContext context, _) => Opacity(
                    opacity: hideAnimation.value,
                    child: widget,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context)?.insert(overlayEntry);
    showController.forward();
    offsetController.forward();
    Future.delayed(duration, () async {
      hideController.forward();
      await Future.delayed(_opacityDuration);
      overlayEntry.remove();
    });
  }

  Widget _buildMessage({
    required final String message,
    required final EdgeInsets padding,
    required final double fontSize,
    required final Color color,
    required final Color backgroundColor,
    required final Border border,
    required final double borderRadius,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: backgroundColor,
        border: border,
      ),
      padding: padding,
      child: Text(
        message,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
        ),
      ),
    );
  }

  static set defaultToEdge(final double toEdge) => _defaultToEdge = toEdge;

  static void resetDefaultToEdge() => _defaultToEdge = _toEdge;

  static set defaultPosition(final ToastPosition position) =>
      _defaultPosition = position;

  static void resetDefaultPosition() => _defaultPosition = _position;

  static set defaultDuration(Duration duration) => _defaultDuration = duration;

  static void resetDefaultDuration() => _defaultDuration = _duration;

  static set defaultPadding(final EdgeInsets padding) =>
      _defaultPadding = padding;

  static void resetDefaultPadding() => _defaultPadding = _padding;

  static set defaultFontSize(final double fontSize) =>
      _defaultFontSize = fontSize;

  static void resetDefaultFontSize() => _defaultFontSize = _fontSize;

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

  static void reset() {
    resetDefaultToEdge();
    resetDefaultPosition();
    resetDefaultDuration();
    resetDefaultPadding();
    resetDefaultFontSize();
    resetDefaultColor();
    resetDefaultBackgroundColor();
    resetDefaultBorder();
    resetDefaultBorderRadius();
  }
}
