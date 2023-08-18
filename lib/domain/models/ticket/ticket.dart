class Ticket {
  final int id;
  final String name;
  final String description;
  final DateTime eventDate;
  final double price;
  final List<String> images;

  Ticket(
      {required this.id,
      required this.name,
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

  Ticket copyWith(
      {String? name, String? description, DateTime? eventDate, double? price}) {
    return Ticket(
        id: id,
        name: name ?? this.name,
        description: description ?? this.description,
        eventDate: eventDate ?? this.eventDate,
        price: price ?? this.price,
        images: images);
  }

  //TODO: Faltaria imatge
  static Map<String, dynamic> toJson(Ticket ticket) => {
        "id": ticket.id,
        "name": ticket.name,
        "description": ticket.description,
        "event_date": ticket.eventDate.toString(),
        "price": ticket.price
      };
}
