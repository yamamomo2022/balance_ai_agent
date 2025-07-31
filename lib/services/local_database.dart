import 'package:balance_ai_agent/models/lifestyle.dart';
import 'package:balance_ai_agent/services/logger_service.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  LocalDatabase._init();
  static final LocalDatabase instance = LocalDatabase._init();
  static Database? _database;
  final _logger = LoggerService.instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('balance_agent.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    _logger.info('Initializing database at path: $path');

    return openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    _logger.info('Creating database tables');
    await db.execute('''
    CREATE TABLE lifestyle (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      goals TEXT NOT NULL,
      aspirations TEXT NOT NULL,
      createdAt INTEGER NOT NULL
    )
    ''');
    _logger.info('Database tables created successfully');
  }

  Future<void> saveLifestyle(Lifestyle lifestyle) async {
    final db = await database;
    try {
      await db.insert('lifestyle', {
        'goals': lifestyle.goals,
        'aspirations': lifestyle.aspirations,
        'createdAt': DateTime.now().millisecondsSinceEpoch
      });
      _logger.logDatabaseOperation('INSERT', table: 'lifestyle');
    } catch (e) {
      _logger.logDatabaseOperation('INSERT', table: 'lifestyle', error: e);
      rethrow;
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
        _logger.logDatabaseOperation('SELECT', table: 'lifestyle');
        return Lifestyle.fromMap({
          'goals': results.first['goals']! as String,
          'aspirations': results.first['aspirations']! as String,
        });
      }
      _logger.debug('No lifestyle data found in database');
    } catch (e) {
      _logger.logDatabaseOperation('SELECT', table: 'lifestyle', error: e);
    }
    return null;
  }
}
