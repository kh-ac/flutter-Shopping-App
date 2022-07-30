class ListItem {
  int id;
  int idList;
  String name;
  String quantity;
  String note;

  ListItem(
      {required this.id,
      required this.idList,
      required this.name,
      required this.quantity,
      required this.note });

  Map<String, dynamic> toMap() {
    return {
      "id": id == 0 ? null : id,
      "idList": idList,
      "name": name,
      "quantity": quantity,
      "note": note,
    };
  }
}
