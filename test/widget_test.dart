import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sigap/main.dart';

void main() {
  testWidgets('SIGAP app smoke test renders onboarding', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: SigapApp()));
    await tester.pumpAndSettle();

    // Verify Onboarding elements appear
    expect(find.text('SIGAP'), findsOneWidget);
    expect(find.text('Mulai'), findsOneWidget);
  });
}
