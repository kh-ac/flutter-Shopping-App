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
          scaffoldBackgroundColor: Color(0xFFCFD8DC),
          textTheme: const TextTheme(

              //
              headline4: TextStyle(
                  fontFamily: "RobotoCondensed",
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              bodyText1: TextStyle(fontFamily: "Raleway", fontSize: 20),
              bodyText2: TextStyle(fontFamily: "Raleway", fontSize: 16))),
      //

      //
      home: ShoppingListsScreen(),
    );
  }
}
