import 'package:flutter/material.dart';

_showFormDialog(BuildContext context){
  return showDialog(context: context, barrierDismissible: true ,builder: (context) {
    return const AlertDialog(
      title: Text("Categories Form",style: TextStyle(fontSize: 10),),
    );
  },);
}