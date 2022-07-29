class ShoppingList {
  final int id;
  String name;
  int priority;

  ShoppingList({required this.id, required this.name,required this.priority });

  Map<String, dynamic> toMap() {
    return {
      "id": (id == 0) ? null : id,
      "name": name,
      "priority": priority,
    };
  }
}
