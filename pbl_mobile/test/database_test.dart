import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:frontend_pbl/database/app_database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase database;

  setUp(() {
    database = AppDatabase.forTesting(
      NativeDatabase.memory(),
    );
  });

  tearDown(() async {
    await database.close();
  });

  test('CRUD barang berfungsi', () async {
    // CREATE
    final id = await database.addItem('Beras', 10);
    expect(id, greaterThan(0));

    // READ
    var items = await database.getAllItems();
    expect(items.length, 1);
    expect(items.first.name, 'Beras');
    expect(items.first.quantity, 10);

    // UPDATE
    await database.updateItem(id, 'Beras Premium', 20);

    items = await database.getAllItems();
    expect(items.first.name, 'Beras Premium');
    expect(items.first.quantity, 20);

    // DELETE
    await database.deleteItem(id);

    items = await database.getAllItems();
    expect(items, isEmpty);
  });
}