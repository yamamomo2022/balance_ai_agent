import 'package:balance_ai_agent/models/lifestyle.dart';

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.lifestyle,
  });

  // MapからUserインスタンスを生成するためのファクトリコンストラクタ
  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      id: data['id'] as String? ?? '',
      name: data['name'] as String? ?? '',
      email: data['email'] as String? ?? '',
      lifestyle:
          Lifestyle.fromMap((data['lifestyle'] ?? {}) as Map<String, dynamic>),
    );
  }
  final String id;
  final String name;
  final String email;
  final Lifestyle lifestyle;

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
