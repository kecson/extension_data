import 'package:extension_data/src/data/byte_array.dart';
import 'package:extension_data/src/ext/iterable_int_ext.dart';

/// Hex String Data.
class HexData {
  /// From Hex String.
  const HexData(this.value);

  HexData.fromBytes(Iterable<int> bytes) : this(bytes.toHex());

  /// Hex String
  final String value;

  /// decode Hex String [value] to [bytes]
  Iterable<int> get bytes => ByteArray.fromHex(value);

  /// Convert to Hex String with prefix.
  ///
  /// Example:
  /// ```dart
  /// HexData.fromBytes([0,1,2,3,4]).toHex(); // "0x0001020304"
  /// ```
  String toHex() => bytes.toHex();

  /// Convert to Hex String without prefix.
  ///
  /// ```
  /// Example:
  /// ```dart
  /// HexData.fromBytes([0,1,2,3,4]).toNoPrefixHex(); // "0001020304"
  /// ```
  String toNoPrefixHex() => bytes.toNoPrefixHex();

  /// Convert to Hex String Trim extra zeroes in the beginning of a string.
  ///
  /// ```
  /// Example:
  /// HexData.fromBytes([0,1,2,3,4]).toShortHex(); // "0x1020304"
  /// ```
  String toShortHex() => bytes.toShortHex();

  /// return Hex String [value].
  @override
  String toString() => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HexData &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
