import 'dart:convert';
import 'dart:typed_data';

import 'package:extension_data/src/codec/base58_codec.dart';
import 'package:extension_data/src/codec/hex_codec.dart';

/// Iterable<int> extension methods.
extension IterableIntExt on Iterable<int> {
  /// Encode to Base58 String.
  String toBase58() => base58Encode(toList());

  /// Encode to Base64 String.
  String toBase64() => base64Encode(toList());

  /// Encode to Hex String with prefix.
  ///
  /// Example:
  /// ```dart
  ///  [0,1,2,3,4].toHex(); // "0x0001020304"
  /// ```
  String toHex() => '0x${toNoPrefixHex()}';

  /// Convert to Hex String without prefix.
  ///
  /// Example:
  /// ```dart
  ///  [0,1,2,3,4].toNoPrefixHex(); // "0001020304"
  /// ```
  String toNoPrefixHex() => hexEncode(toList());

  /// Convert to Hex String Trim extra zeroes in the beginning of a string.
  /// Returns Hex String without leading zeroes.
  ///
  /// Example:
  /// ```dart
  /// [0,1,2,3,4].toShortHex(); // "0x1020304"
  /// ```
  String toShortHex() {
    final trimmed =
        toHex().replaceFirst(RegExp('^0x0*', caseSensitive: false), '');
    return '0x$trimmed';
  }

  /// Convert to Uint8List.
  Uint8List toUint8List() => Uint8List.fromList(toList());
}
