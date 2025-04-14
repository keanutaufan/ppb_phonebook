import 'package:myapp/models/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const String fileName = "contacts_database.db";

class AppDatabase {
  AppDatabase._init();

  static final AppDatabase instance = AppDatabase._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initializeDb(fileName);
    return _database!;
  }

  Future<Database> _initializeDb(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        $idField $idType,
        $firstNameField $textType,
        $lastNameField $textTypeNullable,
        $phoneNumberField $textType,
        $emailField $textTypeNullable
      )
    ''');
  }

  Future<Contact> createContact(Contact contact) async {
    final db = await instance.database;
    final id = await db.insert(tableName, contact.toJson());
    return contact.copyWith(id: id);
  }

  Future<List<Contact>> readAllContacts() async {
    final db = await instance.database;
    final result = await db.query(tableName, orderBy: firstNameField);
    return result.map((json) => Contact.fromJson(json)).toList();
  }

  Future<int> updateContact(Contact contact) async {
    final db = await instance.database;
    return await db.update(
      tableName,
      contact.toJson(),
      where: '$idField = ?',
      whereArgs: [contact.id],
    );
  }

  Future<int> deleteContact(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableName,
      where: '$idField = ?',
      whereArgs: [id],
    );
  }

  Future<void> close() async {
    final db = await instance.database;
    return db.close();
  }
}
