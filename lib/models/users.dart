class Users {
  final int id;
  final String username;
  final String email;
  final String password;
  final int mobileNumber;

  const Users(
      {required this.id,
      required this.username,
      required this.email,
      required this.password,
      required this.mobileNumber});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        id: json['id'],
        username: json['username'],
        password: json['password'],
        email: json['email'],
        mobileNumber: json['mobileNumber']);
  }

  @override
  String toString() {
    return 'Users{id: $id, name: $username, email: $email}';
  }
}
