class ContactEntity {
  final String id;
  final String username;
  final String lastName;
  final String email;
  final String gender;
  final String avatar;

  static const tableName = 'contacts';
  static const idField = 'id';
  static const genderField = 'gender';
  static const avatarField = 'avatar';
  static const usernameField = 'username';
  static const lastNameField = 'last_name';
  static const emailField = 'email';

  ContactEntity({
    required this.id,
    required this.username,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.avatar,
  });

  Map<String, dynamic> toMap() {
    return {
      idField: id,
      usernameField: username,
      lastNameField: lastName,
      avatarField: avatar,
      genderField: gender,
      emailField: email,
    };
  }

  @override
  String toString() {
    return 'ContactEntity{$idField: $id, $usernameField: $username, $lastNameField: $lastName, $emailField: $email, $genderField: $gender, $avatarField: $avatar,}';
  }
}
