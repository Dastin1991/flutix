class Chair {
  int id;
  List<Sheet> sheet;

  Chair({required this.id, required this.sheet});
}

class Sheet {
  String code;

  Sheet({required this.code});
}
