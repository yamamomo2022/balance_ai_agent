class Lifestyle {
  Lifestyle({
    required this.goals,
    required this.aspirations,
  });

  // MapからLifestyleインスタンスを生成するためのファクトリコンストラクタ
  factory Lifestyle.fromMap(Map<String, dynamic> data) {
    return Lifestyle(
      goals: data['goals'] as String? ?? '',
      aspirations: data['aspirations'] as String? ?? '',
    );
  }
  final String goals;
  final String aspirations;

  // LifestyleインスタンスをMapに変換するメソッド
  Map<String, dynamic> toMap() {
    return {
      'goals': goals,
      'aspirations': aspirations,
    };
  }
}
