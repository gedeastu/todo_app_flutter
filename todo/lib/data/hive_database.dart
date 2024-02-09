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

  //For Get todo item by index
  Future<Todo?> getTodoByIndex(int index) async {
    final box = await Hive.openBox<Todo>(boxName);
    return box.values.toList()[index];
  }
}