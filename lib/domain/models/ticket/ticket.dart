class Ticket {
  final int id;
  final String name;
  final String description;
  final DateTime eventDate;
  final double price;
  final List<String> images;

  Ticket(
      {required this.id,required this.name,
      required this.description,
      required this.eventDate,
      required this.price,
      required this.images});

  static Ticket fromJson(Map<String, dynamic> json) => Ticket(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        eventDate: DateTime.parse(json["event_date"]),
        price: json["price"].toDouble(),
        images: _getImages(json),
      );

  static _getImages(Map<String, dynamic> json) {
    final List<String> images = [];
    if (json["images"] != null) {
      images.add(json["images"].map((value) => value));
    }
    return images;
  }
}
