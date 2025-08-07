import 'package:balance_ai_agent/utility/app_theme.dart';
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
          itemCount: 10,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                // Handle tap
              },
              child: Card(
                elevation: 4,
                surfaceTintColor: AppTheme.primaryColor,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Lifestyle Title $index',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'This is a description for lifestyle item number $index. Make your life better!',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
