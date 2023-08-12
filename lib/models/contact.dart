class Contact {
  final String id;
  final String username;
  final String lastName;
  final String email;
  final String gender;
  final String avatar;

  Contact({
    required this.id,
    required this.username,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.avatar,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json["id"],
      username: json["username"],
      lastName: json["last_name"],
      email: json["email"],
      gender: json["gender"],
      avatar: json["avatar"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "last_name": lastName,
      "email": email,
      "gender": gender,
      "avatar": avatar,
    };
  }
}
