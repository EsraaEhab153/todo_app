class MyUser {
  static const String collectionName = 'users';

  String? id;
  String? name;
  String? email;

  MyUser({required this.id, required this.name, required this.email});

  MyUser.fromJson(Map<String, dynamic> myUser)
      : this(
            id: myUser['id'] as String,
            name: myUser['name'] as String,
            email: myUser['email'] as String);

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email};
  }
}
