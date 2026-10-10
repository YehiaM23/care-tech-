import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project2/doc_app.dart';
import 'package:project2/core/Routing/app_router.dart';

void main() {
  testWidgets('Plans and cancels a demo appointment', (tester) async {
    await tester.pumpWidget(DocApp(appRouter: AppRouter()));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Get started'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'Yehia');
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'test@example.com',
    );
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Browse doctors'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Browse doctors'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Plan visit • EGP 300'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Plan visit • EGP 300'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Save demo appointment'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save demo appointment'));
    await tester.pumpAndSettle();
    expect(find.text('Dr. Maya Hassan'), findsOneWidget);
    await tester.tap(find.byTooltip('Cancel appointment'));
    await tester.pumpAndSettle();
    expect(
      find.text('No appointments yet. Browse doctors to plan a visit.'),
      findsOneWidget,
    );
  });
}
