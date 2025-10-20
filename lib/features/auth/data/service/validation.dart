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
    if (value.length < 6) return 'Password must be at least 6 characters';
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
}
