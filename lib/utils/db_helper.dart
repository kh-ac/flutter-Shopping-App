import 'package:flutter_sqlite/models/list_item.dart';
import 'package:flutter_sqlite/models/shopping_list.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  // Database Version
  final int version = 1;

  // The SQLite Databse
  Database? db;

  //
  

  //
  final CREATE_LISTS_TABLE =
      "CREATE TABLE lists (id INTEGER PRIMARY KEY , name TEXT , priority INTEGER)";
  final CREATE_ITEMS_TABLE =
      "CREATE TABLE items (id INTEGER PRIMARY KEY , idList INTEGER , name TEXT , quantity TEXT , note TEXT , " +
          " FOREIGN KEY(idList) REFERENCES lists(id))";

  //
  Future<Database?> openDb() async {
    if (db == null) {
      //
      db = await openDatabase(join(await getDatabasesPath(), "shopping.db"),
          onCreate: (database, version) {
        // Creating lists table
        database.execute(CREATE_LISTS_TABLE);

        // Creating items table
        database.execute(CREATE_ITEMS_TABLE);
      }, version: version);
    }

    return db;
  }

  //
  Future<void> testDb() async {
    db = await openDb();

    //
    await db!.execute('INSERT INTO lists VALUES(0,"Fruits" , 1)');
    await db!.execute(
        'INSERT INTO items VALUES(0,1,"apples","2 KG" , "Better if they are green")');

    List lists = await db!.rawQuery("SELECT* FROM lists");
    List items = await db!.rawQuery("SELECT* FROM items");

    print(lists[0].toString());
    print(items[0].toString());
  }

  //
  Future<List<ShoppingList>> getLists() async {
    db = await openDb();

    final List<Map<String, dynamic>> lists =
        await db!.query("lists", orderBy: "priority");

    return List.generate(lists.length, (index) {
      return ShoppingList(
          id: lists[index]["id"],
          name: lists[index]["name"],
          priority: lists[index]["priority"]);
    });
  }

  //
  Future<int> insertList(ShoppingList list) async {
    db = await openDb();
    int id = await db!.insert("lists", list.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<int> deleteList(ShoppingList list) async {
    db = await openDb();
    int count =
        await db!.delete("items", where: "idList = ?", whereArgs: [list.id]);
    count = await db!.delete("lists", where: "id = ?", whereArgs: [list.id]);
    return count;
  }

  //
  Future<void> deleteDb(String dbName) async {
    await deleteDatabase(join(await getDatabasesPath(), "${dbName}.db"));
  }

  //
  Future<List<ListItem>> getItems(int idList) async {
    db = await openDb();
    List<Map<String, dynamic>> items =
        await db!.query("items", where: "idList = ?", whereArgs: [idList]);

    return List.generate(items.length, (index) {
      return ListItem(
          id: items[index]["id"],
          idList: items[index]["idList"],
          name: items[index]["name"],
          quantity: items[index]["quantity"],
          note: items[index]["note"]);
    });
  }

  //
  Future<int> insertItem(ListItem listItem) async {
    db = await openDb();
    int id = await db!.insert("items", listItem.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  //
  Future<int> deleteItem(int id) async {
    db = await openDb();

    int result = await db!.delete("items", where: "id= ?", whereArgs: [id]);
    return result;
  }
}
