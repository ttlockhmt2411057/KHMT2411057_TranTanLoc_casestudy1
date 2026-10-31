import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'transaction_model.dart';

class DatabaseHelper {
  // 1. Áp dụng Design Pattern Singleton: Đảm bảo chỉ có một instance duy nhất mở kết nối
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  // Getter lấy kết nối Database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('expense_manager.db');
    return _database!;
  }

  // 2. Khởi tạo đường dẫn và mở file SQLite trên thiết bị
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // 3. Tạo bảng 'transactions' lưu thông tin giao dịch
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        amount REAL NOT NULL,
        date TEXT NOT NULL,
        category TEXT NOT NULL,
        isExpense INTEGER NOT NULL
      )
    ''');
  }

  // ================= THAO TÁC CƠ SỞ DỮ LIỆU (CRUD) =================

  // Thêm mới giao dịch vào Database
  Future<int> insertTransaction(TransactionModel transaction) async {
    final db = await instance.database;
    return await db.insert(
      'transactions',
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Lấy toàn bộ danh sách giao dịch (sắp xếp mới nhất lên đầu)
  Future<List<TransactionModel>> getAllTransactions() async {
    final db = await instance.database;
    final result = await db.query('transactions', orderBy: 'date DESC');

    return result.map((json) => TransactionModel.fromMap(json)).toList();
  }

  // Cập nhật giao dịch đã có
  Future<int> updateTransaction(TransactionModel transaction) async {
    final db = await instance.database;
    return await db.update(
      'transactions',
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

  // Xóa giao dịch theo mã ID
  Future<int> deleteTransaction(int id) async {
    final db = await instance.database;
    return await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Đóng kết nối Database khi ứng dụng tắt
  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}}