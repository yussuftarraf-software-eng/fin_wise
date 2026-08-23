class UserModelSignUp {
  final String firstName;
  final String lastName;
  final int age;
  UserModelSignUp({
    required this.firstName,
    required this.lastName,
    required this.age,
  });
  factory UserModelSignUp.fromJson(Map<String, dynamic> json) {
    return UserModelSignUp(
      firstName: json["firstName"],
      lastName: json["lastName"],
      age: json['age'],
    );
  }
}

class UserModelSignIn {
  final String userName;
  final String password;
  final int expiresInMins = 60;
  int? id;
  String? firstName;
  String? lastName;
  String? gender;
  String? image;
  String? accessToken;
  String? refreshToken;
  UserModelSignIn({
    required this.userName,
    required this.password,
    this.firstName,
    this.id,
    this.lastName,
    this.gender,
    this.image,
    this.accessToken,
    this.refreshToken,
  });
  factory UserModelSignIn.fromJson(Map<String, dynamic> json) {
    return UserModelSignIn(
      userName: json["username"],
      password: json["password"] ?? "",
      id: json['id'] ?? "",
      firstName: json['firstName'] ?? "",
      lastName: json['lastName'] ?? "",
      gender: json['gender'] ?? "",
      image: json['image'] ?? "",
      accessToken: json['accessToken'] ?? "",
      refreshToken: json['refreshToken'] ?? "",
    );
  }
}
