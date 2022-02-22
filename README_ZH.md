# x_message

在Flutter中显示Toast、Message和Loading。

![](./toast.png)

![](./message.png)

![](./loading.png)

## 安装

```yaml
dependencies:
  x_message: ^0.1.0
```

## 使用

### 引入

```dart
import 'package:x_message/x_message.dart';
// Or
import 'package:x_message/src/toast.dart';
import 'package:x_message/src/message.dart';
import 'package:x_message/src/loading.dart';
```

### 基础用法

#### Toast

```dart
Toast(
    context: context,
    message: 'Toast',
);
```

修改Toast样式。

```dart
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
```

设置Toast默认样式。

```dart
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
```

重置Toast默认样式。

```dart
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
```

设置Toast子元素。

```dart
Toast(
    context: context,
    child: const Icon(Icons.ac_unit),
);
```

#### Message

```dart
Message(
    context: context,
    message: 'Message',
);
```

修改Message样式。

```dart
Message(
    context: context,
    message: 'Message',
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
```

设置Message默认样式。

```dart
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
```

重置Message默认样式。

```dart
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
```

设置Message子元素。

```dart
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
```

#### Loading

```dart
final loading = Loading(
    context: context,
);
loading.show();
await Future.delayed(const Duration(seconds: 2));
loading.hide();
```

修改Loading样式。

```dart
final loading = Loading(
    context: context,
    child: const Icon(Icons.ac_unit),
    backgroundColor: Colors.black12,
);
loading.show();
await Future.delayed(const Duration(seconds: 2));
loading.hide();
```

设置Loading默认样式。

```dart
Loading.defaultIcon = const Icon(Icons.ac_unit);
Loading.defaultBackgroundColor = Colors.black12;
```

重置Loading默认样式。

```dart
// Loading.reset();
Loading.resetDefaultIcon();
Loading.resetDefaultBackgroundColor();
```
