import 'package:flutter/material.dart';
import 'package:todo/model/todo.dart';

class ItemTodo extends StatelessWidget {
  final Todo todo;
  final Function(bool?) onCheck;
  final Function() onEdit;
  final Function() onDelete;
  const ItemTodo({super.key, required this.todo, required this.onCheck, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: todo.isDone, 
        onChanged:(value) => onCheck(value),
      ),
      title: Text(todo.title,style: TextStyle(decoration: todo.isDone ? TextDecoration.lineThrough : TextDecoration.none),),
      subtitle: Text(todo.description),
      trailing: Row(
        children: [
          GestureDetector(
            onTap: onEdit,
            child: const Icon(Icons.edit),
          ),
          GestureDetector(
            onTap: onDelete,
            child: const Icon(Icons.delete),
          )
        ],
      ),
    );
  }
}