import "package:flutter/material.dart";
import 'package:flutter_sqlite/models/shopping_list.dart';
import 'package:flutter_sqlite/routes/list_items_screen.dart';
import 'package:flutter_sqlite/utils/db_helper.dart';
import 'package:flutter_sqlite/widgets/shopping_list_dialog.dart';

class ShoppingListsScreen extends StatefulWidget {
  ShoppingListsScreen({Key? key}) : super(key: key);

  @override
  State<ShoppingListsScreen> createState() => _ShoppingListsScreenState();
}

class _ShoppingListsScreenState extends State<ShoppingListsScreen> {
  //
  List<ShoppingList> shoppingLists = [];

  //
  DbHelper dbHelper = DbHelper();

  //
  Future<void> getData() async {
    
    shoppingLists = await dbHelper.getLists();
    setState(() {
      shoppingLists = shoppingLists;
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      //
      appBar: AppBar(
        title: Text("Shopping Lists"),
      ),

      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          //
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                //
                key: Key(shoppingLists[index].id.toString()),

                //
                direction: DismissDirection.endToStart,

                //
                onDismissed: (DismissDirection dismissDirection) {
                  //
                  dbHelper.deleteList(shoppingLists[index]);

                  //
                  setState(() {
                    shoppingLists.removeAt(index);
                  });
                },

                //
                child: Card(
                  //
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),

                  //
                  margin:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  elevation: 8,

                  //
                  child: ListTile(
                    //
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ListItemsScreen(
                            shoppingList: shoppingLists[index]);
                      }));
                    },
                    //
                    leading: CircleAvatar(
                        child: Text(shoppingLists[index].priority.toString())),

                    //
                    title: Text(shoppingLists[index].name),

                    //
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return ShoppingListDialog(
                                  shoppingList: ShoppingList(
                                      id: shoppingLists[index].id,
                                      name: shoppingLists[index].name,
                                      priority: shoppingLists[index].priority),
                                  isNew: false);
                            });
                      },
                    ),
                  ),
                ),
              );
            },
            itemCount: shoppingLists.length,
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return ShoppingListDialog(
                    shoppingList: ShoppingList(id: 0, name: "", priority: 0),
                    isNew: true);
              });
        },
      ),
    );
  }
}
