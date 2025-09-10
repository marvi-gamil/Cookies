import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'food_delivery.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // جدول المنتجات
        await db.execute('''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            price REAL,
            image TEXT
          )
        ''');

        // جدول الطلبات
        await db.execute('''
          CREATE TABLE orders(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            productId INTEGER,
            quantity INTEGER,
            status TEXT
          )
        ''');

        // جدول المستخدمين (لـ Signup/Login)
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            email TEXT UNIQUE,
            phone TEXT,
            password TEXT
          )
        ''');
      },
    );
  }

  // --- Products ---
  static Future<void> insertProduct(Map<String, dynamic> product) async {
    final db = await database;
    await db.insert(
      'products',
      product,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getProducts() async {
    final db = await database;
    return await db.query('products');
  }

  // --- Orders ---
  static Future<void> insertOrder(Map<String, dynamic> order) async {
    final db = await database;
    await db.insert(
      'orders',
      order,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getOrders() async {
    final db = await database;
    return await db.query('orders');
  }

  // --- Users (new) ---
  static Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert(
      'users',
      user,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<Map<String, dynamic>?> getUser(
    String email,
    String password,
  ) async {
    final db = await database;
    List<Map<String, dynamic>> res = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (res.isNotEmpty) return res.first;
    return null;
  }
}
