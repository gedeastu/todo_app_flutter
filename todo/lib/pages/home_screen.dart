import 'package:flutter/material.dart';
import 'package:todo/data/hive_database.dart';
//import 'package:todo/model/todo.dart';
import 'package:todo/widgets/item_todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HiveDatabase hiveDatabase = HiveDatabase();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App",style: TextStyle(),),
      ),
      body: FutureBuilder(
        future: hiveDatabase.getTodos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return ListView.separated(
              itemBuilder: (context, index) {
                //return Text(todos[index].title);
                return ItemTodo(
                  todo: data[index], 
                  onCheck: (value){

                  }, 
                  onEdit: (){

                  }, 
                  onDelete: (){

                  }
                );
              }, 
              separatorBuilder: (context, index) {
              return  const SizedBox(height: 5,);
              }, 
              itemCount: data!.length
            ); 
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}