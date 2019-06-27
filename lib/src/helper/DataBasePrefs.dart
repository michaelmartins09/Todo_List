import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/src/model/task.dart';

class DataBasePrefs {
  DataBasePrefs._();

  static final DataBasePrefs db = DataBasePrefs._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await openDatabase(
        join(await getDatabasesPath(), 'task_database.db'),
        onCreate: (db, version){
          return db.execute(
            "CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, subTitle TEXT, isFinished INTEGER NOT NULL)",
          );
        },
        version: 1
      );
      return _database;
    }
  }
  
  insertTask(Task task) async {
    final db = await database;
    await db.insert('tasks', task.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Task>> tasks() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i){
      return Task(
        id: maps[i]['id'],
        title: maps[i]['title'],
        subTitle: maps[i]['subTitle'],
        isFinished: maps[i]['isFinished'] == 1 ? true : false
      );
    });
  }

  updateTask(Task task) async {
    final db = await database;
    await db.update(
      'tasks',
      task.toMap(),
      where: 'id == ?',
      whereArgs: [task.id]
    );
  }

  deleteTask(int id) async {
    final db = await database;
    await db.delete(
      'tasks',
      where: 'id == ?',
      whereArgs: [id]
    );
  }
  
}
