import 'package:flutter_test/flutter_test.dart';
import 'package:frontend_pbl/main.dart';

void main() {
  testWidgets('Stock.co app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const StockCoApp());

    expect(find.byType(StockCoApp), findsOneWidget);
  });
}