import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:storm_application/main.dart' as app;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  if (binding is LiveTestWidgetsFlutterBinding) {
    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
  }
  group('Signup Test', (){
    testWidgets("full app test", (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text("Register now.")); //press register button
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(const ValueKey("firstnamefield")),"John");
      await tester.enterText(find.byKey(const ValueKey("lastnamefield")),"Smith");
      await tester.enterText(find.byKey(const ValueKey("emailfield")),"johnsmith9@gmail.com");
      await tester.enterText(find.byKey(const ValueKey("passwordfield")),"password123");
      await tester.enterText(find.byKey(const ValueKey("confirmpasswordfield")),"password123");
      await tester.pumpAndSettle();

      FocusManager.instance.primaryFocus?.unfocus();
      await tester.pumpAndSettle();

      await tester.tap(find.text("Sign Up"));
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      await tester.tap(find.text("Back to Login"));
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      await tester.tap(find.text("Request Page"));
      await tester.pumpAndSettle();


    });
  });
}