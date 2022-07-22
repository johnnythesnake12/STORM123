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
  group('App Test', (){
   testWidgets("full app test", (tester) async {
     app.main();
     await tester.pumpAndSettle();

     await tester.enterText(find.byKey(const ValueKey("emailSignInField")),"person1@gmail.com");
     await tester.enterText(find.byKey(const ValueKey("passwordSignInField")),"password123");
     await tester.pumpAndSettle();

     // dismiss keyboard
     FocusManager.instance.primaryFocus?.unfocus();
     await tester.pumpAndSettle();

     await tester.tap(find.text("Sign In"));
     await tester.pumpAndSettle();

     await Future.delayed(const Duration(seconds: 2));

     await tester.tap(find.text("Request Page"));
     await tester.pumpAndSettle();

   });
  });
}