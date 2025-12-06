enum PlatformCategory {
  mail,
  bank,
  movie,
  other,
  design,
  edit,
  film, // For "Other" subcategories
}

class PasswordEntry {
  final String id;
  final String platformName;
  final PlatformCategory category;
  final String accountIdentifier; // Email or IBAN
  final String password;
  final String logoPath;
  final bool isCustom; // If true, it was added via "Other"

  PasswordEntry({
    required this.id,
    required this.platformName,
    required this.category,
    required this.accountIdentifier,
    required this.password,
    required this.logoPath,
    this.isCustom = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'platformName': platformName,
      'category': category.index,
      'accountIdentifier': accountIdentifier,
      'password': password,
      'logoPath': logoPath,
      'isCustom': isCustom,
    };
  }

  factory PasswordEntry.fromJson(Map<String, dynamic> json) {
    return PasswordEntry(
      id: json['id'],
      platformName: json['platformName'],
      category: PlatformCategory.values[json['category']],
      accountIdentifier: json['accountIdentifier'],
      password: json['password'],
      logoPath: json['logoPath'],
      isCustom: json['isCustom'] ?? false,
    );
  }
}
