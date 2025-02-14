import 'package:dio/dio.dart';
import 'dart:io' show Platform;
import 'dart:convert';

/// Genkit 経由で Gemini Pro 1.5 Flash を使用してチャット応答を生成するためのクライアント
class GenkitClient {
  GenkitClient({
    required Dio dio,
  }) : dio = dio
          ..options.connectTimeout =
              const Duration(seconds: 60); // Set timeout to 60 seconds

  final Dio dio;

  final String baseUrl =
      Platform.isAndroid ? 'http://10.0.2.2:3400' : 'http://127.0.0.1:3400';

  Future<String> generateChatResponse(String inputText) async {
    try {
      final response = await dio.post('$baseUrl/chat', data: {
        "data": {"message": inputText}
      });

      if (response.statusCode == 200) {
        print("Chat response received");
        print("Response data: ${response.data}"); // デバッグ用
        return response.data['result'] as String;
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
