class User {
  final int id;
  final String username;
  final String email;
  final String name;
  final String lastName;
  final DateTime birthDate;
  final String? image;
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.name,
    required this.lastName,
    required this.birthDate,
    this.image,
  });

  static User fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        name: json["name"],
        lastName: json["lastname"],
        birthDate: DateTime.parse(json["birthdate"]),
        image: json["image"]
      );

}
