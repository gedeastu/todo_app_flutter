class Todo{
  String nama;
  String deskripsi;
  bool done;

  Todo({required this.nama,required this.deskripsi,this.done = false});
  
  static List<Todo> dummyData = [
    Todo(nama: "Latihan Mobile Programming", deskripsi: "membuat sebuah aplikasi sederhana"),
    Todo(nama: "Latihan Web Programming", deskripsi: "membuat sebuah Web sederhana",done: true),
    Todo(nama: "Latihan Machine Learning", deskripsi: "mengumpulkan sebuah Model sederhana"),
  ];
}