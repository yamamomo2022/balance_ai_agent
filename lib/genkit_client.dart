import 'package:dio/dio.dart';

/// Genkit 経由で Imagen 3 を使用して画像を生成するためのクライアント
class GenkitClient {
  GenkitClient({
    required this.dio,
  });
  final Dio dio;

  Future<String> generatetext() async {
    try {
      final response = await dio.post(
        'http://10.0.2.2/genkit/googleai/gemini-1.0-pro',
        data: {
          "messages": [
            {
              "role": "user",
              "content": [
                {"text": "hello"}
              ]
            }
          ],
          "config": {"temperature": 0.4, "topK": 32, "topP": 0.95},
          "tools": []
        },
      );

      if (response.statusCode == 200) {
        print("test");
        return response.data['result']['url'] as String;
      }
      throw Exception('Failed to generate image: ${response.statusCode}');
    } on DioException catch (e) {
      throw Exception('Failed to generate image: ${e.message}');
    }
  }
}
