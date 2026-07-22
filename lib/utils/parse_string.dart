String? nonNullOrEmptyString(String? value) {
  if (value == null || value.isEmpty) return null;
  return value;
}

// Legacy alias for older callers
// ignore: non_constant_identifier_names
String? noneNullOrEmptyString(String? value) => nonNullOrEmptyString(value);