import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/main.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: ".env");
  });

  testWidgets('Test Logging in with valid email & password', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(getGetMaterialApp());
    // final emailField = find.byKey(const Key('emailField'));
    // final passwordField = find.byKey(const Key('passwordField'));
    // final loginButton = find.byType(ElevatedButton);
  });
  testWidgets('Test email validation', (WidgetTester tester) async {
    // await tester.pumpWidget(getGetMaterial App());
    // final emailField = find.byKey(const Key('emailField'));
    // final passwordField = find.byKey(const Key('passwordField'));
    // final loginButton = find.byType(ElevatedButton);
  });
  testWidgets('Test logging in with invalid credentials', (
    WidgetTester tester,
  ) async {
    // await tester.pumpWidget(getGetMaterial App());
    // final emailField = find.byKey(const Key('emailField'));
    // final passwordField = find.byKey(const Key('passwordField'));
    // final loginButton = find.byType(ElevatedButton);
  });
}
