import 'package:flutter/material.dart';
import 'package:x_message/x_message.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'X Message',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'X Message'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Color _buttonColor = Colors.blue;
  final TextStyle _textStyle = const TextStyle(color: Colors.white);
  final Widget _itemSpacer = const SizedBox(height: 10);
  final Widget _groupSpacer = const SizedBox(height: 40);

  int _messageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: <Widget>[
          MaterialButton(
            onPressed: () {
              Toast(
                context: context,
                message: 'Toast',
              );
            },
            color: _buttonColor,
            child: Text(
              'Toast',
              style: _textStyle,
            ),
          ),
          _itemSpacer,
          MaterialButton(
            onPressed: () {
              Toast(
                context: context,
                message: 'Toast',
                position: ToastPosition.center,
                padding: const EdgeInsets.all(5),
                fontSize: 16,
                color: Colors.blue,
                backgroundColor: Colors.white,
                border: Border.all(
                  color: Colors.blue,
                  width: 1,
                ),
                borderRadius: 8,
              );
            },
            color: _buttonColor,
            child: Text(
              'Toast Styles',
              style: _textStyle,
            ),
          ),
          _itemSpacer,
          MaterialButton(
            onPressed: () {
              Toast.defaultToEdge = 40;
              Toast.defaultPosition = ToastPosition.center;
              Toast.defaultDuration = const Duration(seconds: 2);
              Toast.defaultPadding = const EdgeInsets.all(20);
              Toast.defaultFontSize = 16;
              Toast.defaultColor = Colors.grey;
              Toast.defaultBackgroundColor = Colors.black;
              Toast.defaultBorder = Border.all(
                color: Colors.black,
                width: 0.5,
              );
              Toast.defaultBorderRadius = 7;
              Toast(
                context: context,
                message: 'Toast',
              );
            },
            color: _buttonColor,
            child: Text(
              'Set default styles of Toast',
              style: _textStyle,
            ),
          ),
          _itemSpacer,
          MaterialButton(
            onPressed: () {
              // Toast.reset();
              Toast.resetDefaultToEdge();
              Toast.resetDefaultPosition();
              Toast.resetDefaultDuration();
              Toast.resetDefaultPadding();
              Toast.resetDefaultFontSize();
              Toast.resetDefaultColor();
              Toast.resetDefaultBackgroundColor();
              Toast.resetDefaultBorder();
              Toast.resetDefaultBorderRadius();
              Toast(
                context: context,
                message: 'Toast',
              );
            },
            color: _buttonColor,
            child: Text(
              'Reset default styles of Toast',
              style: _textStyle,
            ),
          ),
          _itemSpacer,
          MaterialButton(
            onPressed: () {
              Toast(
                context: context,
                child: const Icon(Icons.ac_unit),
              );
            },
            color: _buttonColor,
            child: Text(
              'Toast Child',
              style: _textStyle,
            ),
          ),
          _groupSpacer,
          MaterialButton(
            onPressed: () {
              Message(
                context: context,
                message: 'Message ${_messageIndex++}',
              );
            },
            color: _buttonColor,
            child: Text(
              'Message',
              style: _textStyle,
            ),
          ),
          _itemSpacer,
          MaterialButton(
            onPressed: () {
              Message(
                context: context,
                message: 'Message ${_messageIndex++}',
                width: 400,
                spacer: 20,
                duration: const Duration(seconds: 15),
                padding: const EdgeInsets.all(15),
                fontSize: 17,
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
                softWrap: true,
                color: Colors.grey,
                backgroundColor: Colors.black,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                ),
                borderRadius: 7,
                // showClose: false,
                close: const Icon(
                  Icons.ac_unit,
                  color: Colors.grey,
                ),
              );
            },
            color: _buttonColor,
            child: Text(
              'Message Styles',
              style: _textStyle,
            ),
          ),
          _itemSpacer,
          MaterialButton(
            onPressed: () {
              Message.defaultWidth = 400;
              Message.defaultSpacer = 20;
              Message.defaultDuration = const Duration(seconds: 15);
              Message.defaultPadding = const EdgeInsets.all(15);
              Message.defaultFontSize = 17;
              Message.defaultTextAlign = TextAlign.center;
              Message.defaultOverFlow = TextOverflow.clip;
              Message.defaultSoftWrap = true;
              Message.defaultColor = Colors.grey;
              Message.defaultBackgroundColor = Colors.black;
              Message.defaultBorder = Border.all(
                color: Colors.black,
                width: 0.5,
              );
              Message.defaultBorderRadius = 7;
              // Message.defaultShowClose = false;
              Message.defaultClose = const Icon(
                Icons.ac_unit,
                color: Colors.grey,
              );

              Message(
                context: context,
                message: 'Message ${_messageIndex++}',
              );
            },
            color: _buttonColor,
            child: Text(
              'Set default styles of Message',
              style: _textStyle,
            ),
          ),
          _itemSpacer,
          MaterialButton(
            onPressed: () {
              // Message.reset();
              Message.resetDefaultWidth();
              Message.resetDefaultSpacer();
              Message.resetDefaultDuration();
              Message.resetDefaultPadding();
              Message.resetDefaultFontSize();
              Message.resetDefaultTextAlign();
              Message.resetDefaultOverFlow();
              Message.resetDefaultSoftWrap();
              Message.resetDefaultColor();
              Message.resetDefaultBackgroundColor();
              Message.resetDefaultBorder();
              Message.resetDefaultBorderRadius();
              Message.resetDefaultShowClose();
              Message.resetDefaultClose();

              Message(
                context: context,
                message: 'Message ${_messageIndex++}',
              );
            },
            color: _buttonColor,
            child: Text(
              'Reset default styles of Message',
              style: _textStyle,
            ),
          ),
          _itemSpacer,
          MaterialButton(
            onPressed: () {
              late Message message;
              message = Message(
                context: context,
                child: Row(
                  children: [
                    const Text('Message'),
                    MaterialButton(
                      onPressed: () {
                        message.remove();
                      },
                      child: const Text('remove'),
                    ),
                  ],
                ),
              );
            },
            color: _buttonColor,
            child: Text(
              'Message Child',
              style: _textStyle,
            ),
          ),
          _groupSpacer,
          MaterialButton(
            onPressed: () async {
              final loading = Loading(
                context: context,
              );
              loading.show();
              await Future.delayed(const Duration(seconds: 2));
              loading.hide();
            },
            color: _buttonColor,
            child: Text(
              'Loading',
              style: _textStyle,
            ),
          ),
          _itemSpacer,
          MaterialButton(
            onPressed: () async {
              final loading = Loading(
                context: context,
                child: const Icon(Icons.ac_unit),
                backgroundColor: Colors.black12,
              );
              loading.show();
              await Future.delayed(const Duration(seconds: 2));
              loading.hide();
            },
            color: _buttonColor,
            child: Text(
              'Loading Style',
              style: _textStyle,
            ),
          ),
          _itemSpacer,
          MaterialButton(
            onPressed: () async {
              Loading.defaultIcon = const Icon(Icons.ac_unit);
              Loading.defaultBackgroundColor = Colors.black12;

              final loading = Loading(
                context: context,
              );
              loading.show();
              await Future.delayed(const Duration(seconds: 2));
              loading.hide();
            },
            color: _buttonColor,
            child: Text(
              'Set default style of Loading',
              style: _textStyle,
            ),
          ),
          _itemSpacer,
          MaterialButton(
            onPressed: () async {
              // Loading.reset();
              Loading.resetDefaultIcon();
              Loading.resetDefaultBackgroundColor();

              final loading = Loading(
                context: context,
              );
              loading.show();
              await Future.delayed(const Duration(seconds: 2));
              loading.hide();
            },
            color: _buttonColor,
            child: Text(
              'Reset default style of Loading',
              style: _textStyle,
            ),
          ),
          _itemSpacer,
        ],
      ),
    );
  }
}
