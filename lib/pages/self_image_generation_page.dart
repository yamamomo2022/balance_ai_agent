import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:balance_ai_agent/widgets/custom_app_bar.dart';
import 'package:balance_ai_agent/widgets/app_bottom_nav_bar.dart';

class SelfImageGenerationPage extends StatefulWidget {
  const SelfImageGenerationPage({super.key});

  @override
  State<SelfImageGenerationPage> createState() =>
      _SelfImageGenerationPageState();
}

class _SelfImageGenerationPageState extends State<SelfImageGenerationPage> {
  final TextEditingController _promptController = TextEditingController();
  bool _isLoading = false;
  String? _generatedImageUrl;
  final String _placeholderImage = 'assets/images/profile_placeholder.png';

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  Future<void> _generateImage() async {
    if (_promptController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('テキストを入力してください')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Create multipart request
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('https://your-backend-api.com/generate-image'),
      );

      // Add text field
      request.fields['prompt'] = _promptController.text;

      // Add image file from assets
      ByteData imageData =
          await DefaultAssetBundle.of(context).load(_placeholderImage);
      List<int> bytes = imageData.buffer.asUint8List();

      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          bytes,
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
        setState(() {
          _generatedImageUrl = responseData['imageUrl'];
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to generate image: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('エラーが発生しました: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Text(
                    'あなたの画像を生成します',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'どのように自分が見えるか説明してください。AIがあなたの画像を生成します。',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Display either placeholder or generated image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _generatedImageUrl != null
                      ? Image.network(
                          _generatedImageUrl!,
                          width: 300,
                          height: 300,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        )
                      : Image.asset(
                          _placeholderImage,
                          width: 300,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
            ),

            const SizedBox(height: 24),

            // Text input field
            TextField(
              controller: _promptController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: '例：私は黒い髪と茶色の目を持つ30代の女性です。笑顔が特徴で...',
                border: OutlineInputBorder(),
                labelText: 'あなたの特徴を入力',
              ),
            ),

            const SizedBox(height: 16),

            // Generate button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _generateImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        '何かあった未来の自画像',
                        style: TextStyle(fontSize: 18),
                      ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 2),
    );
  }
}
