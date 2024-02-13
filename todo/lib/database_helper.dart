import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

import 'package:todo/todo.dart';


class DatabaseHelper{
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  DatabaseHelper.internal();

  factory DatabaseHelper()=>_instance;
  static Database? _db;

  Future<Database?> get db async{
    if(_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async{
    io.Directory docDirectory = await getApplicationDocumentsDirectory();
    String path = join(docDirectory.path, 'todoList.db');
    var localDb = await openDatabase(
      path, version: 1,onCreate: _onCreate
    );
    return localDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      create table if not exists todos(
        id integer primary key autoincrement,
        name text not null,
        description text not null,
        done integer not null default 0
      )''');
  }
  
  Future<List<Todo>> getAllTodos() async {
    var dbClient = await db;
    var todos = await dbClient!.query('todos');
    return todos.map((todo) => Todo.fromMap(todo)).toList();
  }

    Future<List<Todo>> searchTodos(String keyword) async {
    var dbClient = await db;
    var todos = await dbClient!.query('todos',where: 'name like ?',whereArgs: ['%$keyword%']);
    return todos.map((todo) => Todo.fromMap(todo)).toList();
  }

  Future<int> insertTodo(Todo todo) async{
    var dbClient = await db;
    return await dbClient!.insert(
      'todos',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<int> updateTodo(Todo todo) async{
    var dbClient = await db;
    return await dbClient!.update('todos', todo.toMap(), where: 'id == ?', whereArgs:[todo.id]);
  }

  Future<int> deleteTodo(int id) async{
    var dbClient = await db;
    return await dbClient!.delete(
      'todos',
      where:'id = ?',
      whereArgs: [id]
    );
  }
}