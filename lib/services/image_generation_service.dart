import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class ImageGenerationResult {
  final bool success;
  final String? imageUrl;
  final String? errorMessage;

  ImageGenerationResult({
    required this.success,
    this.imageUrl,
    this.errorMessage,
  });

  factory ImageGenerationResult.success(String url) {
    return ImageGenerationResult(success: true, imageUrl: url);
  }

  factory ImageGenerationResult.error(String message) {
    return ImageGenerationResult(success: false, errorMessage: message);
  }
}

class ImageGenerationService {
  final String apiUrl;

  ImageGenerationService({
    this.apiUrl = 'https://your-backend-api.com/generate-image',
  });

  Future<ImageGenerationResult> generateImage(
      String prompt, Uint8List imageBytes) async {
    try {
      // Create multipart request
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(apiUrl),
      );

      // Add text field
      request.fields['prompt'] = prompt;

      // Add image file
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          imageBytes,
          filename: 'profile_image.png',
        ),
      );

      // Send the request
      final response = await request.send();

      // Process the response
      if (response.statusCode == 200) {
        final responseBytes = await response.stream.toBytes();
        final responseData = jsonDecode(utf8.decode(responseBytes));

        // Assuming the API returns a URL to the generated image
        final imageUrl = responseData['imageUrl'];
        if (imageUrl == null) {
          return ImageGenerationResult.error('APIからの応答に画像URLが含まれていません');
        }
        return ImageGenerationResult.success(imageUrl);
      } else {
        return ImageGenerationResult.error(
            '画像生成に失敗しました: ステータス ${response.statusCode}');
      }
    } catch (e) {
      return ImageGenerationResult.error('エラーが発生しました: $e');
    }
  }
}
