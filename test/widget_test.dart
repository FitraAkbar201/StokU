
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:stoku/main.dart';
import 'package:stoku/providers/barang_provider.dart';

void main() {
  testWidgets('StokU menampilkan Dashboard', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => BarangProvider(),
        child: const StokUApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('StokU'), findsOneWidget);
    expect(find.text('Selamat datang!'), findsOneWidget);
  });
}
