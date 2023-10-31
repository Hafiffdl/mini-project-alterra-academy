import 'package:sqflite/sqflite.dart';
import 'package:katalog_elektronik/models/product_model.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  // membuat konstruktor private _internal yang menginisialisasi instans _databaseHelper.
  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  // Factory constructor untuk mendapatkan instance DatabaseHelper
  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDB();
    return _database!;
  }

  final String productTable = "products";

  // Inisialisasi database dan tabel saat pertama kali dibuat
  Future<Database> _initializeDB() async {
    var db = await openDatabase(
      'products_db.db',
      version: 1,
      onCreate: (db, version) async { // Membuat tabel 'product' dengan beberapa kolom
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

// metode insertProduct digunakan untuk menyisipkan produk baru ke dalam database
Future<void> insertProduct(Product product) async {
  final Database db = await database;
  await db.insert(productTable, product.toMap());
}

  // metode getProducts mengambil daftar produk dari database dan mengembalikannya dalam bentuk daftar Product
  Future<List<Product>> getProducts() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(productTable);
    return results.map((e) => Product.fromMap(e)).toList();
  }

  // metode getProductById mengambil produk berdasarkan ID yang diberikan dan mengembalikannya dalam bentuk objek Product
  Future<Product> getProductById(int id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      productTable,
      where: "id = ?",
      whereArgs: [id],
    );
    return Product.fromMap(results.first);
  }

  // metode updateProduct untuk memperbarui informasi produk yang ada dalam database
  Future<void> updateProduct(Product product) async {
    final Database db = await database;
    await db.update(
      productTable,
      product.toMap(),
      where: "id = ?",
      whereArgs: [product.id],
    );
  }

  // metode deleteProduct untuk menghapus produk berdasarkan ID yang diberikan dari database.
  Future<void> deleteProduct(int id) async {
    final Database db = await database;
    await db.delete(
      productTable,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
