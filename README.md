# Shopping App

Simple flutter application which uses SQLite Database.

# About the App
While Shopping, you might forget things now and then , this App will help resolving this problem by saving things you want to buy. 

The App has two screens, the first one is for lists, the second is for items contained in each list.  

<img src = "APP/1.jpg" height = "500">
<img src = "APP/2.jpg" height = "500">
<img src = "APP/3.jpg" height = "500">
<img src = "APP/4.jpg" height = "500">
<img src = "APP/5.jpg" height = "500">
<img src = "APP/6.jpg" height = "500">
<img src = "APP/7.jpg" height = "500">
<img src = "APP/8.jpg" height = "500">

<br>

# DbHelper Class
`DbHelper` Class contains all the methods related to the interaction with our Database and contains  **CRUD** operations (Create , Read , Update , Delete).

## About the Database
The Database has tow _tables_: **lists** table and **items** table.

    final CREATE_LISTS_TABLE =
      "CREATE TABLE lists (id INTEGER PRIMARY KEY , name TEXT , priority INTEGER)";
      
    final CREATE_ITEMS_TABLE =
      "CREATE TABLE items (id INTEGER PRIMARY KEY , idList INTEGER , name TEXT , quantity TEXT , note TEXT , " +
          " FOREIGN KEY(idList) REFERENCES lists(id))";



### Creating and Updating Data:
The parametre `conflictAlgorithm: ConflictAlgorithm.replace`,This method allows us to create a List if it's new and update it if it exists already.

    Future<int> insertList(ShoppingList list) async{
        db = await openDb();
        int id = await db!.insert("lists", list.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
        return id;
    }

### Reading Data:

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

### Deleting Data :

    Future<int> deleteItem(int id) async {
        db = await openDb();
        int result = await db!.delete("items", where: "id= ?", whereArgs: [id]);
        return result;
    }










