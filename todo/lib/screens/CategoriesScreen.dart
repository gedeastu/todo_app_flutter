import 'package:flutter/material.dart';
import 'package:todo/models/category.dart';
import 'package:todo/services/category_service.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
    final _categoryNameController = TextEditingController();
    final _categoryDescriptionController = TextEditingController();

    final _category = Category();
    final _categoryServices = CategoryService();

    _showFormDialog(BuildContext context){
    return showDialog(context: context, barrierDismissible: true ,builder: (context) {
      return  AlertDialog(
        actions: [
          FilledButton(
            style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)),
            onPressed: (){
          }, child: Text("Cancel")),
          FilledButton(
            style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue)),
            onPressed: (){
              _category.name = _categoryNameController.text;
              _category.description = _categoryDescriptionController.text;
              _categoryServices.saveCategory(_category);
          }, child: Text("Save")),
        ],
        title: const Text("Categories Form"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _categoryNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  hintText: "Write a Categories",
                  labelText: "Category"
                ),
              ),
              const SizedBox(height: 20,),
              TextField(
                controller: _categoryDescriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  hintText: "Write Description",
                  labelText: "Description"
                ),
              )
            ],
          ),
        ),
      );
    },);
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed:() {
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back)),
          title: const Text("Categories",style: TextStyle(fontWeight: FontWeight.bold),),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: Text("Welcome to Categories"),
        ),
        floatingActionButton:  IconButton(
          style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue)),
          onPressed: () {
            _showFormDialog(context);
          }, 
          icon: const Icon(Icons.add,color: Colors.white,)
          ),
      ),
    );
  }
}