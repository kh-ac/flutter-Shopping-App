import "package:flutter/material.dart";
import 'package:flutter_sqlite/routes/list_items_screen.dart';
import 'package:flutter_sqlite/routes/shopping_lists_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //
      title: "Shopping App",

      //
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        
        //
        primaryColor: Colors.blueGrey,
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.teal,

        
        
        

        ),
      //
      

      //
      home: ShoppingListsScreen(),
    );
  }
}
