import "package:flutter/material.dart";
import 'package:flutter_sqlite/models/shopping_list.dart';
import 'package:flutter_sqlite/utils/db_helper.dart';

class ShoppingListDialog extends StatelessWidget {
  ShoppingList shoppingList;
  final bool
      isNew; // isNew is true if we try to add a new list , false if we try to edit an existing list

  ShoppingListDialog(
      {super.key, required this.shoppingList, required this.isNew});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController priorityController = TextEditingController();

    //
    DbHelper dbHelper = DbHelper();

    if (!isNew) {
      nameController.text = shoppingList.name;
      priorityController.text = shoppingList.priority.toString();
    }

    return AlertDialog(
      //
      title: Text(isNew ? "New Shopping List" : "Edit Shopping List"),

      //
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

      //
      content: SingleChildScrollView(
        child: Column(
          children: [
            //
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: "Shopping List Name"),
            ),

            //
            TextField(
              controller: priorityController,
              decoration: InputDecoration(hintText: "Shopping List Priority"),
            ),

            //
            ElevatedButton(
                onPressed: () {
                  //
                  shoppingList.name = nameController.text;
                  shoppingList.priority = int.parse(priorityController.text);

                  // Inserting the new List into the Database ;
                  dbHelper.insertList(shoppingList);

                  // Returning to the Shopping list Screen after completing
                  Navigator.of(context).pop();
                },
                child: Text("Save Shopping List")),
          ],
        ),
      ),
    );
  }
}
