import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/password_entry.dart';

class StorageService {
  final _storage = const FlutterSecureStorage();
  static const _keyPasswords = 'saved_passwords';

  Future<List<PasswordEntry>> getPasswords() async {
    final String? jsonString = await _storage.read(key: _keyPasswords);
    if (jsonString == null) return [];

    try {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => PasswordEntry.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> savePassword(PasswordEntry entry) async {
    final List<PasswordEntry> currentPasswords = await getPasswords();
    currentPasswords.add(entry);
    await _saveList(currentPasswords);
  }

  Future<void> deletePassword(String id) async {
    final List<PasswordEntry> currentPasswords = await getPasswords();
    currentPasswords.removeWhere((entry) => entry.id == id);
    await _saveList(currentPasswords);
  }

  Future<void> _saveList(List<PasswordEntry> list) async {
    final String jsonString = jsonEncode(list.map((e) => e.toJson()).toList());
    await _storage.write(key: _keyPasswords, value: jsonString);
  }
}
