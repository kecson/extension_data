import 'dart:convert' show utf8;

/// Decode a [base58String] into the original bytes.
///
/// **See also:**
/// * https://github.com/bitcoin/bitcoin/blob/master/src/base58.cpp
List<int> base58Decode(String base58String) {
  final trimmed = base58String.trim();
  if (trimmed.isEmpty) return [];

  int length = 0;
  final zeroes = trimmed.split('').takeWhile((v) => v == '1').length;

  final size = (trimmed.length - zeroes) * 733 ~/ 1000 + 1;
  final bytes256 = List.filled(size, 0);
  final List<int> inputBytes = utf8.encode(trimmed);
  for (final currentByte in inputBytes) {
    // Decode base58 character
    int carry = _reverseMap[currentByte];
    int i = 0;
    if (carry == -1) {
      throw FormatException('Invalid base58 character found: $currentByte');
    }
    for (int j = size - 1; j >= 0; j--, i++) {
      if (!((carry != 0) || (i < length))) break;
      carry += 58 * bytes256[j];
      bytes256[j] = carry % 256;
      carry ~/= 256;
    }
    length = i;
  }

  return List<int>.filled(zeroes, 0)
      .followedBy(bytes256.sublist(size - length))
      .toList(growable: false);
}

/// Base58 encode the [bytes] array.
///
/// **See also:**
/// * https://github.com/bitcoin/bitcoin/blob/master/src/base58.cpp
String base58Encode(List<int> bytes) {
  String encoded = '';
  if (bytes.isEmpty) return encoded;
  final zeroes = bytes.takeWhile((v) => v == 0).length;
  int length = 0;
  // Compute final size
  final size = (bytes.length - zeroes) * 138 ~/ 100 + 1;
  // Create temporary storage
  final List<int> b58bytes = List<int>.filled(size, 0);
  for (final byteValue in bytes.skip(zeroes)) {
    int carry = byteValue;
    int i = 0;
    for (int j = 0; j < size; j++, i++) {
      if (!((carry != 0) || (i < length))) break;
      carry += 256 * b58bytes[j];
      b58bytes[j] = carry % 58;
      carry ~/= 58;
    }
    length = i;
  }
  final List<int> finalBytes = b58bytes.sublist(0, length);
  for (final byte in finalBytes) {
    encoded = _base58Alphabet[byte] + encoded;
  }

  return '1' * zeroes + encoded;
}

/// All alphanumeric characters except for "0", "I", "O", and "l"
const String _base58Alphabet =
    '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz';

const List<int> _reverseMap = [
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, //
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, -1, -1, -1, -1, -1, -1,
  -1, 9, 10, 11, 12, 13, 14, 15, 16, -1, 17, 18, 19, 20, 21, -1,
  22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, -1, -1, -1, -1, -1,
  -1, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, -1, 44, 45, 46,
  47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
];
