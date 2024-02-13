import 'package:flutter/material.dart';
import 'package:todo/todo_page.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TodoPage();
  }
}