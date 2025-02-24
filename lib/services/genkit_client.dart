import 'package:balance_ai_agent/models/lifestyle.dart';
import 'package:dio/dio.dart';
import 'dart:io' show Platform;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:balance_ai_agent/models/lifestyle.dart';

/// Genkit 経由で Gemini Pro 1.5 Flash を使用してチャット応答を生成するためのクライアント
class GenkitClient {
  GenkitClient({
    required Dio dio,
  }) : dio = dio
          ..options.connectTimeout =
              const Duration(seconds: 60); // Set timeout to 60 seconds

  final Dio dio;

  final String baseUrl = dotenv.env['API_SERVER'] ?? 'http://10.0.2.2:3400';

  Future<String> generateChatResponse(
      String inputText, Lifestyle? lifestyle) async {
    try {
      String combinedInputText = inputText;

      if (lifestyle != null) {
        combinedInputText =
            'Goals: ${lifestyle.goals}\nAspirations: ${lifestyle.aspirations}\n\n$inputText';
      }
      final response = await dio.post('$baseUrl/chat', data: {
        "data": {"message": combinedInputText}
      });

      if (response.statusCode == 200) {
        print("Chat response received");
        print("Response data: ${response.data}"); // デバッグ用

        final resultData = response.data['result'];

        if (resultData is String) {
          // JSON文字列であればパース
          try {
            final parsed = jsonDecode(resultData);
            if (parsed is Map<String, dynamic>) {
              if (parsed.containsKey('assistant')) {
                return parsed['assistant'] as String;
              } else if (parsed.containsKey('user')) {
                return parsed['user'] as String;
              } else {
                // Map の最初の値を返す
                return parsed.values.first.toString();
              }
            }
          } catch (_) {
            // 単純な文字列として返す
            return resultData;
          }
        } else if (resultData is Map<String, dynamic>) {
          // すでに Map として返ってきている場合
          if (resultData.containsKey('assistant')) {
            return resultData['assistant'] as String;
          } else if (resultData.containsKey('text')) {
            return resultData['text'] as String;
          } else if (resultData.containsKey('user')) {
            return resultData['user'] as String;
          } else {
            return resultData.values.first.toString();
          }
        } else {
          // その他の型の場合は文字列変換して返す
          return resultData.toString();
        }
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
