import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_board/constants/keys.dart';
import 'package:flutter_board/main.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_widgets_flutter_binding.dart';

/*
 Everything necessary for widget test has been implemented.
*/
void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  // Sample test case
  testWidgets('SignIn Page', (WidgetTester tester) async {
    await tester.pumpWidget(const MainApp());
    await tester.pump(const Duration(seconds: 3));

    final signInPage = find.byKey(kSignInPage);
    expect(signInPage, findsOneWidget);

    await tester.enterText(find.byKey(kSignInEmailTextField), '');
    await tester.enterText(find.byKey(kSignInPasswordTextField), 'b');

    await tester.tap(find.byKey(kSignInLogInButton));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(signInPage, findsOneWidget);
  });
}


