import "package:flutter/material.dart";
import 'package:flutter_sqlite/models/list_item.dart';
import 'package:flutter_sqlite/models/shopping_list.dart';
import 'package:flutter_sqlite/utils/db_helper.dart';

class ListItemDialog extends StatelessWidget {
  ListItem listItem;
  final bool
      isNew; // isNew is true if we try to add a new list , false if we try to edit an existing lis

  ListItemDialog({super.key, required this.listItem, required this.isNew});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController quantityController = TextEditingController();
    TextEditingController noteController = TextEditingController();

    //
    DbHelper dbHelper = DbHelper();

    if (!isNew) {
      nameController.text = listItem.name;
      quantityController.text = listItem.quantity;
      noteController.text = listItem.note;
    }

    return AlertDialog(
      //
      title: Text(isNew ? "New Item " : "Edit Item "),

      //
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

      //
      content: SingleChildScrollView(
        child: Column(
          children: [
            //
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: "Item name"),
            ),

            //
            TextField(
              controller: quantityController,
              decoration: InputDecoration(hintText: "Item quantity"),
            ),

            //
            TextField(
              controller: noteController,
              decoration: InputDecoration(hintText: "note"),
            ),

            //
            ElevatedButton(
                onPressed: () {
                  //
                  listItem.name = nameController.text;
                  listItem.quantity = quantityController.text;
                  listItem.note = noteController.text;

                  // Inserting the new List into the Database ;
                  dbHelper.insertItem(listItem);

                  // Returning to the Shopping list Screen after completing
                  Navigator.of(context).pop();
                },
                child: Text("Save item")),
          ],
        ),
      ),
    );
  }
}
