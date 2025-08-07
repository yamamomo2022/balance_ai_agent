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
      body: Stack(
        children: [
          // Main content
          Center(
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
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  '願望その${index + 1}',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24, // Increased font size
                                        color: AppTheme.primaryColor,
                                      ),
                                ),
                                const SizedBox(
                                    height: 16), // Slightly larger spacing
                                Text(
                                  'This is a description for lifestyle item number '
                                  '${index + 1}. Make your life better!',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        fontSize: 20, // Increased font size
                                        color: Colors.grey[800],
                                      ),
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
          // Floating action button at bottom right
          Positioned(
            right: 40,
            bottom: 20,
            child: Material(
              color: AppTheme.transparent,
              child: InkWell(
                onTap: () {
                  // TODO: Implement festival action
                },
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    color: AppTheme.secondaryColor, // テーマカラー
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      color: AppTheme.whiteColor,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
