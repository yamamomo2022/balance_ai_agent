/// ユーザー情報を保持するクラス
class User {
  /// コンストラクタ
  const User({
    required this.userId,
    required this.email,
    required this.isAnonymous,
    this.createdAt,
  });

  /// MapからUserインスタンスを生成するためのファクトリコンストラクタ
  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      userId: data['userId'] as String? ?? '',
      email: data['email'] as String? ?? '',
      isAnonymous: data['isAnonymous'] as bool? ?? false,
      createdAt: DateTime.tryParse(data['created_at'] as String? ?? ''),
    );
  }

  /// ユーザー情報を保持するフィールド
  final String userId;

  /// ユーザーのメールアドレス
  final String email;

  /// ユーザーが匿名かどうか
  final bool isAnonymous;

  /// ユーザーの作成日時(null許容)
  final DateTime? createdAt;

  /// UserインスタンスをMapに変換するメソッド
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'isAnonymous': isAnonymous,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
