import 'dart:async';

import 'package:flutter/material.dart';
import 'package:easyloading_plus/easyloading_plus.dart';

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
