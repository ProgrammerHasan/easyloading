<h1 align="center">Easy Loading.</h1>
<h4 align="center">A simple and customizable Flutter package for showing loading indicator. It helps developers display smooth and responsive loading overlays with minimal setup and easy-to-use APIs.
.</h4>

<p align="center">
  <a href="https://pub.dartlang.org/packages/easyloading"><img src="https://img.shields.io/pub/v/easyloading.svg"></a>
</p>

<p align="center">
  <img src="https://github.com/programmerhasan/easyloading/raw/master/screenshots/02.png" alt="Payment dialog for Flutter" width="120" style="border-radius: 50%;" />
</p>


---

## Features
- Normal loading overlay with blur effect
- Customizable `CircularProgressIndicator`
- Progress loader with percentage display
- Easy to show and dismiss

---

## Quickstart

### Add dependency to your pubspec file

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  easyloading: ^1.0.0
```
Then run:
```
flutter pub get
```

### Usage

Show normal loader
```agsl
Loading.show(context);
```
Show progress loader
```agsl
Loading.showProgress(context, 50); // 50% complete
```
Dismiss loader
```agsl
Loading.dismiss();
```

### Example

See example/main.dart for a full working example.

```dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:easyloading/easyloading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EasyLoading Example',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("EasyLoading Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                EasyLoading.show(context);
                Future.delayed(const Duration(seconds: 3), () {
                  EasyLoading.dismiss();
                });
              },
              child: const Text("Show Loader"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                double percent = 0;
                EasyLoading.showProgress(context, percent);

                // simulate progress using Timer.periodic
                Timer.periodic(const Duration(milliseconds: 300), (timer) {
                  percent += 10;
                  if (percent > 100) {
                    EasyLoading.dismiss();
                    timer.cancel();
                  } else {
                    EasyLoading.showProgress(context, percent);
                  }
                });
              },
              child: const Text("Show Progress Loader"),
            ),
          ],
        ),
      ),
    );
  }
}
```
