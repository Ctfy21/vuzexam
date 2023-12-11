import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/data_model.dart';

class DataDatabase {
  static final DataDatabase instance = DataDatabase._init();

  final databaseName = 'data.db';

  static Database? _database;

  DataDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(databaseName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    const jsonType = 'JSON NOT NULL';

    await db.execute('''
CREATE TABLE $tableData ( 
  ${DataFields.id} $idType, 
  ${DataFields.name} $textType,
  ${DataFields.localizedName} $textType,
  ${DataFields.primaryAttr} $textType,
  ${DataFields.attackType} $textType,
  ${DataFields.roles} $jsonType,
  ${DataFields.legs} $integerType
  )
''');
  }

  Future<Data> create(Data data) async {
    final db = await instance.database;

    final id = await db.insert(tableData, data.toJson());
    return data.copy(id: id);
  }

  Future<Data> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableData,
      columns: DataFields.values,
      where: '${DataFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Data.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Data>> readAllData() async {
    final db = await instance.database;

    const orderBy = '${DataFields.id} ASC';

    final result = await db.query(tableData, orderBy: orderBy);

    return result.map((json) => Data.fromJson(json)).toList();
  }

  Future<int> update(Data data) async {
    final db = await instance.database;

    return db.update(
      tableData,
      data.toJson(),
      where: '${DataFields.id} = ?',
      whereArgs: [data.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableData,
      where: '${DataFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}