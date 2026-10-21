import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

// Tabel untuk menyimpan data barang
class Items extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  IntColumn get quantity =>
      integer().withDefault(const Constant(0))();
}

@DriftDatabase(tables: [Items])
class AppDatabase extends _$AppDatabase {
  // Constructor untuk aplikasi
  AppDatabase() : super(_openConnection());

  // Constructor khusus untuk pengujian
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  // CREATE: Menambahkan barang
  Future<int> addItem(String name, int quantity) {
    return into(items).insert(
      ItemsCompanion.insert(
        name: name,
        quantity: Value(quantity),
      ),
    );
  }

  // READ: Mengambil semua barang
  Future<List<Item>> getAllItems() {
    return select(items).get();
  }

  // READ: Memantau perubahan data barang
  Stream<List<Item>> watchAllItems() {
    return select(items).watch();
  }

  // UPDATE: Mengubah nama dan jumlah barang
  Future<int> updateItem(
    int id,
    String name,
    int quantity,
  ) {
    return (update(items)..where((item) => item.id.equals(id))).write(
      ItemsCompanion(
        name: Value(name),
        quantity: Value(quantity),
      ),
    );
  }

  // DELETE: Menghapus barang berdasarkan ID
  Future<int> deleteItem(int id) {
    return (delete(items)..where((item) => item.id.equals(id))).go();
  }
}

// Koneksi database untuk aplikasi
QueryExecutor _openConnection() {
  return driftDatabase(name: 'stockco_database');
}