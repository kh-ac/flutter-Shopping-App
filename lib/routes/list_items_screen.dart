import "package:flutter/material.dart";
import 'package:flutter_sqlite/models/list_item.dart';
import 'package:flutter_sqlite/models/shopping_list.dart';
import 'package:flutter_sqlite/utils/db_helper.dart';
import 'package:flutter_sqlite/widgets/list_item_dialog.dart';

class ListItemsScreen extends StatefulWidget {
  final ShoppingList shoppingList;

  const ListItemsScreen({super.key, required this.shoppingList});

  @override
  State<ListItemsScreen> createState() => _ListItemsScreenState();
}

class _ListItemsScreenState extends State<ListItemsScreen> {
  //
  List<ListItem> items = [];

  //
  DbHelper dbHelper = DbHelper();
  //
  Future<void> getData() async {
    items = await dbHelper.getItems(widget.shoppingList.id);
    setState(() {
      items = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      //
      appBar: AppBar(
        title: Text(widget.shoppingList.name),
      ),

      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          //
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                //
                key: Key(items[index].id.toString()),

                //
                direction: DismissDirection.endToStart,

                //
                onDismissed: (DismissDirection dismissDirection) {
                  //
                  dbHelper.deleteItem(items[index].id);

                  //
                  setState(() {
                    items.removeAt(index);
                  });

                  /*ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("${items[index].name} is deleted")));*/
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

                    //

                    //
                    title: Text(items[index].name),

                    //
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return ListItemDialog(
                                  listItem: ListItem(
                                      id: items[index].id,
                                      idList: items[index].idList,
                                      name: items[index].name,
                                      quantity: items[index].quantity,
                                      note: items[index].note),
                                  isNew: false);
                            });
                      },
                    ),
                  ),
                ),
              );
            },
            itemCount: items.length,
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return ListItemDialog(
                    listItem: ListItem(
                        id: 0,
                        idList: widget.shoppingList.id,
                        name: "",
                        quantity: "",
                        note: ""),
                    isNew: true);
              });
        },
      ),
    );
  }
}
