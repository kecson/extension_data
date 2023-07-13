import 'dart:convert';

import 'package:decimal/decimal.dart';
import 'package:extension_data/src/codec/base58_codec.dart';
import 'package:extension_data/src/codec/hex_codec.dart';
import 'package:extension_data/src/data/base58_data.dart';
import 'package:extension_data/src/data/base64_data.dart';
import 'package:extension_data/src/data/hex_data.dart';
import 'package:extension_data/src/ext/date_time_ext.dart';

/// String extension methods.
extension StringExt on String {
  int toInt({int? radix}) => int.parse(trim(), radix: radix);

  int? tryToInt({int? radix}) => int.tryParse(trim(), radix: radix);

  double toDouble() => double.parse(trim());

  double? tryToDouble() => double.tryParse(trim());

  num toNum() => num.parse(trim());

  num? tryToNum() => num.tryParse(trim());

  BigInt toBigInt({int? radix}) => BigInt.parse(trim(), radix: radix);

  BigInt? tryToBigInt({int? radix}) => BigInt.tryParse(trim(), radix: radix);

  /// Parse num string to exactly Decimal.
  Decimal toDecimal() => Decimal.parse(trim());

  Decimal? tryToDecimal() => Decimal.tryParse(trim());

  Uri toUri([int start = 0, int? end]) => Uri.parse(trim(), start, end);

  Uri? tryToUri([int start = 0, int? end]) => Uri.tryParse(trim(), start, end);

  /// Parse timestamp
  DateTime toDateTime(TimeUnit unit, {bool isUtc = false}) =>
      unit.parseTimestamp(trim(), isUtc: isUtc);

  /// Try to parse timestamp.
  DateTime? tryToDateTime(TimeUnit unit, {bool isUtc = false}) {
    try {
      return toDateTime(unit, isUtc: isUtc);
    } catch (e) {
      return null;
    }
  }

  /// Convert Base64 String to [Base64Data].
  Base64Data toBase64Data() => Base64Data.fromBytes(base64Decode(this));

  Base64Data? tryToBase64Data() {
    try {
      return toBase64Data();
    } catch (e) {
      return null;
    }
  }

  /// Convert Base58 String to [Base58Data].
  Base58Data toBase58Data() => Base58Data.fromBytes(base58Decode(this));

  Base58Data? tryToBase58Data() {
    try {
      return toBase58Data();
    } catch (e) {
      return null;
    }
  }

  /// Convert Hex String to [HexData].
  HexData toHexData() => HexData.fromBytes(hexDecode(this));

  HexData? tryToHexData() {
    try {
      return toHexData();
    } catch (e) {
      return null;
    }
  }
}
