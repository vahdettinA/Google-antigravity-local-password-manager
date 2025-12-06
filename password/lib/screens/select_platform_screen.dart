import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../models/password_entry.dart';
import 'add_password_screen.dart';
import 'select_category_screen.dart';

class SelectPlatformScreen extends StatelessWidget {
  final bool isGenerating;

  const SelectPlatformScreen({super.key, required this.isGenerating});

  @override
  Widget build(BuildContext context) {
    final allOptions = [...AppAssets.platforms, AppAssets.otherOption];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Platform Seçin'),
        backgroundColor: AppColors.background,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: allOptions.length,
        itemBuilder: (context, index) {
          final option = allOptions[index];
          return InkWell(
            onTap: () {
              if (option.category == PlatformCategory.other) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SelectCategoryScreen(isGenerating: isGenerating),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPasswordScreen(
                      platformName: option.name,
                      category: option.category,
                      logoPath: option.logoPath,
                      isGenerating: isGenerating,
                    ),
                  ),
                );
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.blackLow,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (option.logoPath.isNotEmpty)
                    Image.asset(option.logoPath, width: 48, height: 48)
                  else
                    const Icon(
                      Icons.more_horiz,
                      size: 48,
                      color: AppColors.primary,
                    ),
                  const SizedBox(height: 12),
                  Text(
                    option.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
