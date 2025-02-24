class Lifestyle {
  final String goals;
  final String aspirations;

  Lifestyle({
    required this.goals,
    required this.aspirations,
  });

  // MapからLifestyleインスタンスを生成するためのファクトリコンストラクタ
  factory Lifestyle.fromMap(Map<String, dynamic> data) {
    return Lifestyle(
      goals: data['goals'] ?? '',
      aspirations: data['aspirations'] ?? '',
    );
  }

  // LifestyleインスタンスをMapに変換するメソッド
  Map<String, dynamic> toMap() {
    return {
      'goals': goals,
      'aspirations': aspirations,
    };
  }
}
