class Lifestyle {
  final String investment;
  final String savings;
  final String growth;
  final String goals;

  Lifestyle({
    required this.investment,
    required this.savings,
    required this.growth,
    required this.goals,
  });

  // MapからLifestyleインスタンスを生成するためのファクトリコンストラクタ
  factory Lifestyle.fromMap(Map<String, dynamic> data) {
    return Lifestyle(
      investment: data['investment'] ?? '',
      savings: data['savings'] ?? '',
      growth: data['growth'] ?? '',
      goals: data['goals'] ?? '',
    );
  }

  // LifestyleインスタンスをMapに変換するメソッド
  Map<String, dynamic> toMap() {
    return {
      'investment': investment,
      'savings': savings,
      'growth': growth,
      'goals': goals,
    };
  }
}
