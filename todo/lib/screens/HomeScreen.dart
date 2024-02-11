import 'package:flutter/material.dart';
import 'package:todo/helpers/drawer_navigation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          title: const Text("Todo App",style: TextStyle(fontWeight: FontWeight.bold),),
          centerTitle: false,
          toolbarHeight: 60,
        ),
        drawer: const DrawerNavigation(),
        body: const Center(
          child: Text("Hello World"),
        ),
      ),
    );
  }
}