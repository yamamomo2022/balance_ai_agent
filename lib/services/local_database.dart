import 'package:balance_ai_agent/models/lifestyle.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  LocalDatabase._init();
  static final LocalDatabase instance = LocalDatabase._init();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('balance_agent.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE lifestyle (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      goals TEXT NOT NULL,
      aspirations TEXT NOT NULL,
      createdAt INTEGER NOT NULL
    )
    ''');
  }

  Future<void> saveLifestyle(Lifestyle lifestyle) async {
    final db = await database;
    try {
      await db.insert('lifestyle', {
        'goals': lifestyle.goals,
        'aspirations': lifestyle.aspirations,
        'createdAt': DateTime.now().millisecondsSinceEpoch
      });
    } catch (e) {
      // エラーロギングや通知の処理をここに追加できます
      print('Error saving lifestyle: $e');
    }
  }

  Future<Lifestyle?> getLatestLifestyle() async {
    final db = await database;
    try {
      final results = await db.query(
        'lifestyle',
        orderBy: 'createdAt DESC',
        limit: 1,
      );

      if (results.isNotEmpty) {
        return Lifestyle.fromMap({
          'goals': results.first['goals']! as String,
          'aspirations': results.first['aspirations']! as String,
        });
      }
    } catch (e) {
      // エラーロギングや通知の処理をここに追加できます
      print('Error getting latest lifestyle: $e');
    }
    return null;
  }
}
