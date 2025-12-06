import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'select_platform_screen.dart';

class AddOptionsScreen extends StatelessWidget {
  const AddOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Şifre Ekle',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildOptionCard(
              context,
              title: 'Mevcut Şifreyi Kaydet',
              subtitle: 'Halihazırda kullandığınız bir şifreyi kaydedin',
              icon: Icons.save_alt_rounded,
              color: AppColors.primary,
              isGenerating: false,
            ),
            const SizedBox(height: 24),
            _buildOptionCard(
              context,
              title: 'Yeni Şifre Oluştur',
              subtitle: 'Güvenli ve rastgele bir şifre oluşturun',
              icon: Icons.vpn_key_rounded,
              color: Colors.black87,
              isGenerating: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required bool isGenerating,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                SelectPlatformScreen(isGenerating: isGenerating),
          ),
        );
      },
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: const [
            BoxShadow(
              color: AppColors.blackLow,
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color == AppColors.primary
                    ? AppColors.primaryLow
                    : AppColors.blackLow,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.grey[300],
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
