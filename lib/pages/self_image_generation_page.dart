import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:balance_ai_agent/services/image_generation_service.dart';
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
  final ImageGenerationService _imageService = ImageGenerationService();
  bool _isLoading = false;
  String? _generatedImageUrl;
  final String _placeholderImage = 'assets/images/profile_template.jpeg';

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
      // Load image data from assets
      final ByteData imageData =
          await DefaultAssetBundle.of(context).load(_placeholderImage);
      final Uint8List bytes = imageData.buffer.asUint8List();

      // Call the service
      final result = await _imageService.generateImage(
        _promptController.text,
        bytes,
      );

      if (result.success) {
        setState(() {
          _generatedImageUrl = result.imageUrl;
          _isLoading = false;
        });
      } else {
        debugPrint('Image generation failed: ${result.errorMessage}');
        throw Exception(result.errorMessage);
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
    // Your existing build method...
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Your existing UI code...

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
                        'わるいことを続けた未来の自画像',
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
