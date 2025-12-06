import 'dart:math';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/password_entry.dart';
import '../services/storage_service.dart';
import '../utils/constants.dart';

class AddPasswordScreen extends StatefulWidget {
  final String platformName;
  final PlatformCategory category;
  final String logoPath;
  final bool isGenerating;
  final bool isCustom;

  const AddPasswordScreen({
    super.key,
    required this.platformName,
    required this.category,
    required this.logoPath,
    required this.isGenerating,
    this.isCustom = false,
  });

  @override
  State<AddPasswordScreen> createState() => _AddPasswordScreenState();
}

class _AddPasswordScreenState extends State<AddPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  final _customNameController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    if (widget.isGenerating) {
      _passwordController.text = _generateRandomPassword();
    }
    if (widget.isCustom) {
      _customNameController.text = widget.platformName;
    }
  }

  String _generateRandomPassword() {
    const length = 16;
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()';
    final rnd = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(rnd.nextInt(chars.length)),
      ),
    );
  }

  Future<void> _save() async {
    if (_formKey.currentState!.validate()) {
      final storage = StorageService();
      final entry = PasswordEntry(
        id: const Uuid().v4(),
        platformName: widget.isCustom
            ? _customNameController.text
            : widget.platformName,
        category: widget.category,
        accountIdentifier: _identifierController.text,
        password: _passwordController.text,
        logoPath: widget.logoPath,
        isCustom: widget.isCustom,
      );

      await storage.savePassword(entry);
      if (mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isBank = widget.category == PlatformCategory.bank;
    final identifierLabel = isBank ? 'IBAN' : 'E-posta / Kullanıcı Adı';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(widget.isCustom ? 'Hesap Ekle' : widget.platformName),
        backgroundColor: AppColors.background,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: widget.logoPath.isNotEmpty
                    ? Image.asset(widget.logoPath, width: 80, height: 80)
                    : Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryLow,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _getIconForCategory(widget.category),
                          size: 40,
                          color: AppColors.primary,
                        ),
                      ),
              ),
              const SizedBox(height: 32),

              if (widget.isCustom) ...[
                TextFormField(
                  controller: _customNameController,
                  decoration: _inputDecoration('Platform Adı'),
                  validator: (value) => value!.isEmpty ? 'Gerekli' : null,
                ),
                const SizedBox(height: 16),
              ],

              TextFormField(
                controller: _identifierController,
                decoration: _inputDecoration(identifierLabel),
                validator: (value) => value!.isEmpty ? 'Gerekli' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: _inputDecoration('Şifre').copyWith(
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () => setState(
                          () => _isPasswordVisible = !_isPasswordVisible,
                        ),
                      ),
                      if (widget.isGenerating)
                        IconButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: () {
                            setState(() {
                              _passwordController.text =
                                  _generateRandomPassword();
                            });
                          },
                        ),
                    ],
                  ),
                ),
                validator: (value) => value!.isEmpty ? 'Gerekli' : null,
              ),

              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Kaydet',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForCategory(PlatformCategory cat) {
    switch (cat) {
      case PlatformCategory.bank:
        return Icons.account_balance;
      case PlatformCategory.mail:
        return Icons.mail;
      case PlatformCategory.movie:
        return Icons.movie;
      case PlatformCategory.design:
        return Icons.brush;
      case PlatformCategory.edit:
        return Icons.edit;
      default:
        return Icons.public;
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }
}
