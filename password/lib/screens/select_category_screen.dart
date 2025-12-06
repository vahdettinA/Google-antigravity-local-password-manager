import 'package:flutter/material.dart';
import '../models/password_entry.dart';
import '../utils/constants.dart';
import 'add_password_screen.dart';

class SelectCategoryScreen extends StatelessWidget {
  final bool isGenerating;

  const SelectCategoryScreen({super.key, required this.isGenerating});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'name': 'Banka',
        'icon': Icons.account_balance,
        'cat': PlatformCategory.bank,
      },
      {'name': 'Mail', 'icon': Icons.mail, 'cat': PlatformCategory.mail},
      {'name': 'Film', 'icon': Icons.movie, 'cat': PlatformCategory.movie},
      {'name': 'Tasarım', 'icon': Icons.brush, 'cat': PlatformCategory.design},
      {'name': 'Edit', 'icon': Icons.edit, 'cat': PlatformCategory.edit},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Kategori Seçin'),
        backgroundColor: AppColors.background,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final cat = categories[index];
          return ListTile(
            tileColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryLow,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(cat['icon'] as IconData, color: AppColors.primary),
            ),
            title: Text(
              cat['name'] as String,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPasswordScreen(
                    platformName:
                        cat['name']
                            as String, // Use category name as platform name initially, user can edit? No, user enters details.
                    // Actually for "Other", user might want to name the platform (e.g. "My Local Bank").
                    // But the prompt says "onlardan birini seçince bu türlere özel bir icon koyucaksın".
                    // It doesn't explicitly say user enters platform name, but it makes sense.
                    // Let's assume the Platform Name is the Category Name for now, or allow editing.
                    // The prompt says "banka ise iban artı şifre...".
                    // Let's pass the category.
                    category: cat['cat'] as PlatformCategory,
                    logoPath: '', // No logo path, use icon
                    isGenerating: isGenerating,
                    isCustom: true,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
