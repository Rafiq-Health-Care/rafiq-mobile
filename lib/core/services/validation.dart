class Validation {
  static String? validateEmail(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  static String? validatePassword(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Password is too short';
    if (value.length > 16) return 'Password is too long';
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain uppercase';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain lowercase';
    }
    if (!RegExp(r'\d').hasMatch(value)) return 'Password must contain number';
    final specialPattern = r"""[!@#\$%^&*()_+\-=\[\]{};:'"\\|,.<>/?]""";
    if (!RegExp(specialPattern).hasMatch(value)) {
      return 'Password must contain special char';
    }
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    value = value?.trim();
    if (value == null || value.isEmpty) return 'Required';
    if (value != password) return 'Passwords do not match';
    return null;
  }

  static String? validateNonEmpty(String? value, String fieldName) {
    value = value?.trim();
    if (value == null || value.isEmpty) return '$fieldName is required';
    return null;
  }

  static String? validateAge(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) return 'Age is required';
    final age = int.tryParse(value);
    if (age == null || age <= 0) return 'Enter a valid age';
    return null;
  }

  static String? validatePhone(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) return 'Phone number is required';
    final phoneRegex = RegExp(r'^\+?[\d\s]{7,15}$');
    if (!phoneRegex.hasMatch(value)) return 'Enter a valid phone number';
    return null;
  }

  static String? validateTestResult(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) return 'Test result is required';
    if (double.tryParse(value) == null) {
      return 'Invalid number';
    }
    return null;
  }
}
