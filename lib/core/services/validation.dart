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
    if (value == null || value.isEmpty) return 'This field is required';
    if (value != password) return 'Passwords do not match';
    return null;
  }

  static String? validateNonEmpty(String? value, String fieldName) {
    value = value?.trim();
    if (value == null || value.isEmpty) return '$fieldName is required';
    return null;
  }

  static String? validateBirthDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your birth date';
    }

    final regex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    if (!regex.hasMatch(value)) {
      return 'Invalid format';
    }

    final parts = value.split('-');
    final year = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final day = int.parse(parts[2]);

    if (year < 1900 || year > DateTime.now().year) {
      return 'Invalid year';
    }

    if (month < 1 || month > 12) {
      return 'Invalid month';
    }

    if (day < 1 || day > 31) {
      return 'Invalid day';
    }

    return null;
  }

  static String? validatePhone(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) return 'Phone number is required';
    final phoneRegex = RegExp(r'^(10|11|12|15)\d{8}$');
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

  static String? validateOtp(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) return 'OTP is required';
    if (value.length != 6) return 'OTP must be 6 digits';
    return null;
  }
}
