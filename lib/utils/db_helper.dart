import 'package:flutter_sqlite/models/shopping_list.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  // Database Version
  final int version = 1;

  // The SQLite Databse
  Database? db;

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
    final List<Map<String, dynamic>> lists = await db!.query("lists");

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

  //
  Future<void> deleteDb(String db) async {
    await deleteDatabase(join(await getDatabasesPath(), "${db}.db"));
  }
}
