import 'lifestyle.dart';

class User {
  final String id;
  final String name;
  final String email;
  final Lifestyle lifestyle;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.lifestyle,
  });

  // MapからUserインスタンスを生成するためのファクトリコンストラクタ
  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      lifestyle: Lifestyle.fromMap(data['lifestyle'] ?? {}),
    );
  }

  // UserインスタンスをMapに変換するメソッド
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'lifestyle': lifestyle.toMap(),
    };
  }
}
