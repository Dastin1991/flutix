class Transactions {
  int id;
  String title;
  String amount;
  String description;
  String link;
  String type;
  String? cinema;
  String? date;
  String? seat;
  String? price;
  String? fee;
  int? total;

  Transactions(
      {required this.id,
      required this.title,
      required this.amount,
      required this.description,
      required this.link,
      required this.type,
      this.cinema,
      this.date,
      this.seat,
      this.price,
      this.fee,
      this.total});
}
