import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/pages/add_screen.dart';
import 'package:todo/pages/home_screen.dart';

final routeObserver = RouteObserver<ModalRoute>();
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      navigatorObservers: [routeObserver],
      onGenerateRoute: (settings) {
        switch(settings.name){
          case '/home':
            return MaterialPageRoute(builder: (_) => HomeScreen());
          case '/add':
            return MaterialPageRoute(builder: (_) => AddScreen());
          default:
            return MaterialPageRoute(builder: (_) => Placeholder());
        }
      },
    );
  }
}