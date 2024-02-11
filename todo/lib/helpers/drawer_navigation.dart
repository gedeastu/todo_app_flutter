import 'package:flutter/material.dart';
import 'package:todo/screens/CategoriesScreen.dart';
import 'package:todo/screens/HomeScreen.dart';

class DrawerNavigation extends StatelessWidget {
  const DrawerNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/myPict.jpg")),
              accountName: Text("Gede Astu Nugraha"), 
              accountEmail: Text("gede.astu@gmail.com"),
              decoration: BoxDecoration(
                color: Colors.blue
              ),
            ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.view_list),
            title: const Text("Categories"),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CategoriesScreen()));
            },
          ),
        ],
      ),
    );
  }
}