import 'package:flutter/material.dart';

class Loading {
  final BuildContext context;
  late final OverlayEntry _overlayEntry;
  late final AnimationController _showController;
  late final AnimationController _hideController;
  final _opacityDuration = const Duration(milliseconds: 250);

  static const Widget _icon = CircularProgressIndicator();
  static const Color _backgroundColor = Color.fromRGBO(0, 0, 0, 0.2);

  static Widget _defaultIcon = _icon;
  static Color _defaultBackgroundColor = _backgroundColor;

  Loading({
    required this.context,
    Widget? child,
    Color? backgroundColor,
  }) {
    child ??= _defaultIcon;
    backgroundColor ??= _defaultBackgroundColor;

    final OverlayState overlayState = Overlay.of(context)!;

    _showController = AnimationController(
      vsync: overlayState,
      duration: _opacityDuration,
    );
    final showAnimation = Tween(begin: 0.0, end: 1.0).animate(_showController);

    _hideController = AnimationController(
      vsync: overlayState,
      duration: _opacityDuration,
    );
    final hideAnimation = Tween(begin: 1.0, end: 0.0).animate(_hideController);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        child: AnimatedBuilder(
          animation: showAnimation,
          child: Container(
            color: backgroundColor,
            width: double.infinity,
            height: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  color: Colors.transparent,
                  child: child,
                ),
              ],
            ),
          ),
          builder: (BuildContext context, Widget? widget) => Opacity(
            opacity: showAnimation.value,
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
    );
  }

  void show() {
    Overlay.of(context)?.insert(_overlayEntry);
    _showController.forward();
  }

  void hide() {
    _hideController.forward();
    _overlayEntry.remove();
  }

  static set defaultIcon(Widget icon) => _defaultIcon = icon;

  static void resetDefaultIcon() => _defaultIcon = _icon;

  static set defaultBackgroundColor(final Color backgroundColor) =>
      _defaultBackgroundColor = backgroundColor;

  static void resetDefaultBackgroundColor() =>
      _defaultBackgroundColor = _backgroundColor;

  static void reset() {
    resetDefaultIcon();
    resetDefaultBackgroundColor();
  }
}
