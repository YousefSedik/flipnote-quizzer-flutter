String? emailValidator(value) {
  if (value == null || value.isEmpty) {
    return "Please enter your email";
  }
  String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return "Enter a valid email";
  }
  return null; // means valid
}
