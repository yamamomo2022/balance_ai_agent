import 'package:dio/dio.dart';

/// Genkit 経由で Gemini Pro 1.5 Flash を使用してチャット応答を生成するためのクライアント
class GenkitClient {
  GenkitClient({
    required Dio dio,
  }) : dio = dio
          ..options.connectTimeout =
              const Duration(seconds: 60); // Set timeout to 60 seconds

  final Dio dio;

  Future<String> generateChatResponse(String inputText) async {
    try {
      final response = await dio.post(
        'http://10.0.2.2/model/vertexai/gemini-1.5-flash/chat',
        data: {
          "messages": [
            {
              "role": "user",
              "content": [
                {"text": inputText}
              ]
            }
          ],
          "config": {"temperature": 0.4, "topK": 32, "topP": 0.95},
          "tools": []
        },
      );

      if (response.statusCode == 200) {
        print("Chat response received");
        return response.data['result']['text'] as String;
      }
      throw Exception(
          'Failed to generate chat response: ${response.statusCode}');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw Exception('Failed to generate chat response: Connection refused');
      } else if (e.type == DioExceptionType.sendTimeout) {
        throw Exception(
            'Failed to generate chat response: Connection timed out');
      }
      throw Exception('Failed to generate chat response: ${e.message}');
    }
  }
}
