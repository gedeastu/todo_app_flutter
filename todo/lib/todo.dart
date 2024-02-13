class Todo{
  String name;
  String description;
  bool done;

  Todo({required this.name,required this.description,this.done = false});
  
  static List<Todo> dummyData = [
    Todo(name: "Latihan Mobile Programming", description: "membuat sebuah aplikasi sederhana"),
    Todo(name: "Latihan Web Programming", description: "membuat sebuah Web sederhana",done: true),
    Todo(name: "Latihan Machine Learning", description: "mengumpulkan sebuah Model sederhana"),
  ];

  Map<String,dynamic> toMap(){
    return <String,dynamic>{ 
      "name" : name,
      "description" : description
     };
  }

  factory Todo.fromMap(Map<String,dynamic>map){
    return Todo(
      name: map['nama'] as String, 
      description: map['description'] as String,
      done: map['done'] == 0 ? false : true
    );
  }
}