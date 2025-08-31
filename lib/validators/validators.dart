String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Email cannot be empty";
  }
  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  if (!emailRegex.hasMatch(value)) {
    return "Enter a valid email address";
  }
  return null;
}

String? notNullOrEmpty(String? value) {
  if (value != null && value.trim().isNotEmpty) {
    return null;
  } else {
    return "This field cannot be empty";
  }
}
