import 'dart:convert';

/// Decode a [base64String] into the original bytes.
List<int> base64Decode(String base64String) => base64.decode(base64String.trim());

/// Base64 encode the [bytes] array.
String base64Encode(List<int> bytes) => base64.encode(bytes);
