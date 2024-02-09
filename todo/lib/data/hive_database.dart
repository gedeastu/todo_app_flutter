import 'package:hive/hive.dart';
import 'package:todo/model/todo.dart';

class HiveDatabase {
  final String boxName = 'todoBox';

  //For Add todo Item
  Future<void> addTodo(Todo todo) async {
    final box = await Hive.openBox<Todo>(boxName);
    await box.add(todo);
  } 

  //For Get todo list item
  Future<List<Todo>> getTodos() async {
    final box = await Hive.openBox<Todo>(boxName);
    return box.values.toList();
  } 

  //For Get todo item by index ( to see the detail item )
  Future<Todo?> getTodoByIndex(int index) async {
    final box = await Hive.openBox<Todo>(boxName);
    return box.values.toList()[index];
  }

  //For Delete todo item by index
  Future<void> deleteTodo(int index) async {
    final box = await Hive.openBox<Todo>(boxName);
    await box.delete(index);
  }

  //For Update todo item by index
  Future<void> updateTodo(int index, Todo todo) async {
    final box = await Hive.openBox<Todo>(boxName);
    await box.putAt(index, todo);
  }

  //For Update todo status item by index
  Future<void> updateStatus(int index, Todo todo) async {
    final box = await Hive.openBox<Todo>(boxName);
    todo.isDone = !todo.isDone;
    await box.put(index, todo);
  }
}