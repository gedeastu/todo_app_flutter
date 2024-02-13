import 'package:flutter/material.dart';
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
  final TextEditingController _nameTextField = TextEditingController();
  final TextEditingController _descriptionTextField = TextEditingController();

  List<Todo> todoList = Todo.dummyData;

  void updateItem(int index,bool done){
    todoList[index].done = done;
    refreshList();
  }

  void addItem(){
    todoList.add(Todo(nama: _nameTextField.text, deskripsi: _descriptionTextField.text));
    refreshList();
    _nameTextField.text = '';
    _descriptionTextField.text = '';
  }

  void deleteItem(int index){
      todoList.removeAt(index);
      refreshList();
  }

  void refreshList(){
    setState(() {
      todoList = todoList;
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
                      title: Text(todoList[index].nama),
                      subtitle: Text(todoList[index].deskripsi),
                      trailing: IconButton(onPressed:(){
                        deleteItem(index);
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