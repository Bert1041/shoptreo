mixin FormValidationMixin {
  // Email validation using a regex
  String? validateEmail(String? val) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (val == null || val.isEmpty) {
      return 'Email is required';
    } else if (!emailRegex.hasMatch(val)) {
      return 'Invalid email format';
    }
    return null;
  }

  // Password validation with minimum length and complexity check
  String? validatePassword(String? val) {
    if (val == null || val.isEmpty) {
      return 'Password is required';
    } else if (val.length < 6) {
      return 'Minimum 6 characters required';
    } else if (!RegExp(r'(?=.*[A-Z])').hasMatch(val)) {
      return 'Password must contain at least one uppercase letter';
    } else if (!RegExp(r'(?=.*[0-9])').hasMatch(val)) {
      return 'Password must contain at least one number';
    } else if (!RegExp(r'(?=.*[!@#$%^&*(),.?":{}|<>])').hasMatch(val)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }
}
