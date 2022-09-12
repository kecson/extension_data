import 'package:convert/convert.dart' show hex;

/// Decode a [hexString] into the original bytes.
///
/// Example:
/// ```dart
/// hexDecode('0x0102030a'); // [1,2,3,10]
/// hexDecode('0a0b0102'); // [10,11,1,2]
/// hexDecode('000f010a'); // [0,15,1,10]
/// hexDecode('F0102'); // [15,1,2]
///```
List<int> hexDecode(String hexString) {
  var encoded =
      hexString.trim().replaceFirst(RegExp('^0x', caseSensitive: false), '');
  if (encoded.length % 2 != 0) {
    encoded = encoded.padLeft(encoded.length + 1, '0');
  }
  final decode = hex.decode(encoded);
  return decode;
}

/// Convert to Hex String without prefix.
///
/// Example:
/// ```dart
/// hexEncode([1,2,3,4]); // 01020304
/// hexEncode([0,1,2,3,10]); // 000102030a
///```
String hexEncode(List<int> input) => hex.encode(input);
