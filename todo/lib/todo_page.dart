import 'package:flutter/material.dart';
import 'package:todo/database_helper.dart';
import 'package:todo/todo.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoList(),
    );
  }
}


class TodoList extends StatefulWidget {
  const TodoList({
    super.key,
  });

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  //TextEditingController
  final TextEditingController _nameTextField = TextEditingController();
  final TextEditingController _descriptionTextField = TextEditingController();
  final TextEditingController _searchTextField = TextEditingController();

  //Make List Variable from Todo Object
  List<Todo> todoList = [];

  //Call the Database
  final dbHelper = DatabaseHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshList();
  }

  //Function CRUD in Tempory Memory
  void updateItem(int index,bool done) async {
    todoList[index].done = done;
    await dbHelper.updateTodo(todoList[index]);
    refreshList();
  }
  void addItem() async{
    await dbHelper.insertTodo(Todo(name: _nameTextField.text, description: _descriptionTextField.text));
    todoList.add(Todo(name: _nameTextField.text, description: _descriptionTextField.text));
    refreshList();
    _nameTextField.text = '';
    _descriptionTextField.text = '';
  }
  void deleteItem(int id) async{
      await dbHelper.deleteTodo(id);
      //todoList.removeAt(index);
      refreshList();
  }
  void refreshList() async {
    final todos = await dbHelper.getAllTodos();
    setState(() {
      todoList = todos;
    });
  }
  void showForm(){
    showDialog(context: context, builder:(context) =>
      AlertDialog(
        insetPadding: const EdgeInsets.all(20),
        title: const Text("Tambah Todo"),
        actions: [
          ElevatedButton(onPressed: () {
            Navigator.of(context).pop();
          }, child: const Text("Close")),
          ElevatedButton(onPressed: (){
             Navigator.of(context).pop();
             addItem();
          }, child: const Text("Add"))
        ],
        content: SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              TextField(
                controller: _nameTextField,
                decoration: const InputDecoration(
                  hintText: "Name",
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 15,),
              TextField(
                controller: _descriptionTextField,
                decoration: const InputDecoration(
                  hintText: "Description",
                  border: OutlineInputBorder()
                ),
              ),
            ],
          ),
        ),
      ),);
  }
  void searchTodo([String? words]) async{
    String text = _searchTextField.text.trim();
    List<Todo> todos = [];
    if (text.isEmpty) {
       todos = await dbHelper.getAllTodos();
    } else {
      todos = await dbHelper.searchTodos(text);
    }
    setState(() {
      todoList = todos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: 65,
        title: const Text("Todo List"),
      ),

      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: TextField(
            decoration: InputDecoration(
              hintText: "Cari apa?",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            controller: _searchTextField,
            onChanged: (value) {
              searchTodo(_searchTextField.text);
            },
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(5),
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: IconButton(
                        icon: todoList[index].done ? const Icon(Icons.check_circle) : const Icon(Icons.radio_button_unchecked),
                        onPressed:(){
                          updateItem(index, !todoList[index].done);
                        },
                      ),
                      title: Text(todoList[index].name),
                      subtitle: Text(todoList[index].description),
                      trailing: IconButton(onPressed:(){
                        deleteItem(todoList[index].id ?? 0);
                      }, icon: const Icon(Icons.delete)),
                    )
                  ],
                );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10,);
            }, 
            itemCount: todoList.length)
          ),
        ],
      ),

      floatingActionButton: IconButton(
        onPressed: () {
          showForm();
        },
        style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue),foregroundColor: MaterialStatePropertyAll(Colors.white),iconSize: MaterialStatePropertyAll(35),elevation: MaterialStatePropertyAll(10)),
        icon: const Icon(Icons.add),
      ),
    );
  }
}