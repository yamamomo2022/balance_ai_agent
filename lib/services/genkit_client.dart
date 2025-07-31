import 'dart:convert';

import 'package:balance_ai_agent/models/lifestyle.dart';
import 'package:balance_ai_agent/services/logger_service.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Genkit 経由で Gemini Pro 1.5 Flash を使用してチャット応答を生成するためのクライアント
class GenkitClient {
  GenkitClient({
    required Dio dio,
  }) : dio = dio
          ..options.connectTimeout =
              const Duration(seconds: 60); // Set timeout to 60 seconds

  final Dio dio;
  final _logger = LoggerService.instance;

  final String baseUrl = dotenv.env['API_SERVER'] ?? 'http://127.0.0.1:4300';

  Future<String> generateChatResponse(
      String inputText, Lifestyle? lifestyle) async {
    try {
      _logger.debug('Starting chat response generation');
      
      // get current user's id
      final user = FirebaseAuth.instance.currentUser;
      String? idToken;
      if (user != null) {
        idToken = await user.getIdToken();
        _logger.debug('User authenticated for chat request');
      } else {
        _logger.debug('Guest user for chat request');
      }

      var combinedInputText = inputText;

      if (lifestyle != null) {
        combinedInputText =
            'Goals: ${lifestyle.goals}\nAspirations: ${lifestyle.aspirations}\nしかし，以下の逆効果のことをやろうとしてしまっています．願望と目標に沿った代替案を具体的に30字程度で提案してください．\n\n```\n$inputText\n```';
        _logger.debug('Enhanced prompt with lifestyle context');
      }

      // add user id to the request header
      final headers = <String, dynamic>{};
      if (idToken != null) {
        headers['Authorization'] = 'Bearer $idToken';
      }

      _logger.logApiCall('$baseUrl/chat', method: 'POST');

      final response = await dio.post('$baseUrl/chat',
          data: {
            'data': {'message': combinedInputText},
          },
          options: Options(
            headers: headers,
          ));

      if (response.statusCode == 200) {
        _logger.logApiCall('$baseUrl/chat', method: 'POST', statusCode: response.statusCode);
        _logger.debug('Response data received from chat API');

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
          } catch (e) {
            _logger.warning('Failed to parse JSON response, returning as string', error: e);
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
      
      _logger.logApiCall('$baseUrl/chat', method: 'POST', statusCode: response.statusCode, error: 'Unexpected status code');
      throw Exception(
          'Failed to generate chat response: ${response.statusCode}');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        _logger.logApiCall('$baseUrl/chat', method: 'POST', error: 'Connection refused');
        throw Exception('Failed to generate chat response: Connection refused');
      } else if (e.type == DioExceptionType.sendTimeout) {
        _logger.logApiCall('$baseUrl/chat', method: 'POST', error: 'Connection timed out');
        throw Exception(
            'Failed to generate chat response: Connection timed out');
      }
      _logger.logApiCall('$baseUrl/chat', method: 'POST', error: e.message);
      throw Exception('Failed to generate chat response: ${e.message}');
    }
  }
}
