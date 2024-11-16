
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:notes_app_testing_starter/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Complete App Test', (tester) async {
    // Start the app
    app.main();

    await tester.pumpAndSettle();

    // Add new todoo
    final textField = find.byType(TextField);

    await tester.enterText(textField, 'Quran');

    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.add));

    await tester.pumpAndSettle();

    // verify a todoo is added
    final textGym = find.text('Gym');

    expect(textGym, findsOneWidget);

    // mark the todoo is completed
    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();

    // verify the todoo mark as completed
    final textWidget  = tester.widget<Text>(textGym);
    expect(textWidget.style?.decoration, TextDecoration.lineThrough);

    // Delete the todoo
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();

    expect(textGym, findsNothing);


  });
}