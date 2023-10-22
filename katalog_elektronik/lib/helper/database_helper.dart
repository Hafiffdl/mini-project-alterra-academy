import 'package:sqflite/sqflite.dart';
import 'package:katalog_elektronik/models/product_model.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDB();
    return _database!;
  }

  final String productTable = "products";

  Future<Database> _initializeDB() async {
    var db = await openDatabase(
      'products_db.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $productTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          description TEXT,
          imageUrl TEXT,
          price REAL
        )''');
      },
    );

    return db;
  }

Future<void> insertProduct(Product product) async {
  final Database db = await database;
  await db.insert(productTable, product.toMap());
}


  Future<List<Product>> getProducts() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(productTable);
    return results.map((e) => Product.fromMap(e)).toList();
  }

  Future<Product> getProductById(int id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      productTable,
      where: "id = ?",
      whereArgs: [id],
    );
    return Product.fromMap(results.first);
  }

  Future<void> updateProduct(Product product) async {
    final Database db = await database;
    await db.update(
      productTable,
      product.toMap(),
      where: "id = ?",
      whereArgs: [product.id],
    );
  }

  Future<void> deleteProduct(int id) async {
    final Database db = await database;
    await db.delete(
      productTable,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
