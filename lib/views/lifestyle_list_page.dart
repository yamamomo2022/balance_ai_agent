import 'package:balance_ai_agent/views/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

/// LifestyleListPage is a simple page that displays a list of lifestyle items.
class LifestyleListPage extends StatelessWidget {
  /// Constructor for LifestyleListPage
  const LifestyleListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('title'),
                  Text('content $index'),
                  const Text('title'),
                  Text('content $index'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
