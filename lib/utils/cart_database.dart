import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:dressupexchange_mobile/models/cartItem_model.dart';

class CartDatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    final String dbPath = join(await getDatabasesPath(), 'cart.db');
    return await openDatabase(dbPath, version: 3, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
  CREATE TABLE cart_items (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    productId TEXT,
    voucherId INTEGER,
    laundryId INTEGER,
    name TEXT,
    price REAL,
    quantity INTEGER
  )
''');
  }

  // Add a product to the cart
  Future<int> addToCart(CartItem cartItem) async {
    final db = await database;
    return await db.insert('cart_items', cartItem.toMap());
  }

  // Retrieve all items in the cart
  Future<List<CartItem>> getCartItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cart_items');
    return List.generate(maps.length, (index) {
      return CartItem.fromMap(maps[index]);
    });
  }

  // Remove an item from the cart
  Future<void> removeFromCart(String productId) async {
    final db = await database;
    await db.delete('cart_items', where: 'productId = ?', whereArgs: [productId]);
  }

  Future<CartItem?> getCartItemByProductId(String productId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'cart_items',
      where: 'productId = ?',
      whereArgs: [productId],
    );

    if (maps.isNotEmpty) {
      // If a matching item is found, return it as a CartItem
      return CartItem.fromMap(maps.first);
    } else {
      // If no matching item is found, return null
      return null;
    }
  }

  Future<int> updateCartItem(CartItem cartItem) async {
    final db = await database;
    return await db.update(
      'cart_items',
      cartItem.toMap(),
      where: 'productId = ?',
      whereArgs: [cartItem.productId],
    );
  }
}
