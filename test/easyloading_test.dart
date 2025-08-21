import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easyloading/easyloading.dart';

void main() {
  testWidgets('EasyLoading shows and dismisses loader', (WidgetTester tester) async {
    // Build a simple app with a Scaffold
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return Column(
                children: [
                  ElevatedButton(
                    onPressed: () => EasyLoading.show(context),
                    child: const Text('Show Loader'),
                  ),
                  ElevatedButton(
                    onPressed: () => EasyLoading.dismiss(),
                    child: const Text('Dismiss Loader'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );

    // Tap show loader button
    await tester.tap(find.text('Show Loader'));
    await tester.pump(); // rebuild widget tree

    // Verify loader is displayed
    expect(find.byType(BackdropFilter), findsWidgets);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Tap dismiss loader button
    await tester.tap(find.text('Dismiss Loader'));
    await tester.pump(); // rebuild widget tree

    // Verify loader is removed
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('EasyLoading shows progress loader', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => EasyLoading.showProgress(context, 50),
              child: const Text('Show Progress'),
            ),
          ),
        ),
      ),
    );

    // Tap show progress loader
    await tester.tap(find.text('Show Progress'));
    await tester.pump();

    // Verify progress indicator and percentage text
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('50%'), findsOneWidget);
  });
}
