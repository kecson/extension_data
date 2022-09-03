import 'dart:convert';
import 'dart:typed_data';

import 'package:extension_data/src/codec/base58_codec.dart';
import 'package:extension_data/src/codec/hex_codec.dart';
import 'package:extension_data/src/ext/iterable_int_ext.dart';

/// ByteArray Buffer.
class ByteArray extends Iterable<int> {
  ByteArray(Iterable<int> data)
      : assert(data.every((e) => e < 256), 'All elements should be less than 256'),
        _data = data.toList();

  const ByteArray._(this._data);

  /// empty ByteArray Buffer.
  const ByteArray.empty() : this._(const []);

  ByteArray._fromByteData(ByteData data) : _data = data.buffer.asUint8List();

  factory ByteArray.merge(Iterable<ByteArray> arrays) {
    final list = Uint8List.fromList(arrays.expand((e) => e).toList());
    return ByteArray(list);
  }

  /// Decode [base58String] to ByteArray.
  factory ByteArray.fromBase58(String base58String) =>
      ByteArray(Uint8List.fromList(base58Decode(base58String)));

  /// Decode [base64String] to ByteArray.
  factory ByteArray.fromBase64(String base64String) =>
      ByteArray(Uint8List.fromList(base64Decode(base64String)));

  /// Decode [hexString] to ByteArray.
  ///
  /// Example:
  /// ```dart
  /// ByteArray.fromHex('0x0102030a').toList(); // [1,2,3,10]
  /// ByteArray.fromHex('0a0b0102').toList(); // [10,11,1,2]
  /// ByteArray.fromHex('000f010a').toList(); // [0,15,1,10]
  /// ByteArray.fromHex('F0102').toList(); // [15,1,2]
  ///```
  factory ByteArray.fromHex(String hexString) => ByteArray(hexDecode(hexString));

  /// Init ByteArray from int8 value.
  factory ByteArray.i8(int value) => ByteArray._fromByteData(ByteData(1)..setUint8(0, value));

  /// Init ByteArray from uint8 value.
  factory ByteArray.u8(int value) => ByteArray._fromByteData(ByteData(1)..setUint8(0, value));

  /// Init ByteArray from int16 value.
  factory ByteArray.i16(int value) =>
      ByteArray._fromByteData(ByteData(2)..setUint16(0, value, Endian.little));

  /// Init ByteArray from uint16 value.
  factory ByteArray.u16(int value) =>
      ByteArray._fromByteData(ByteData(2)..setUint16(0, value, Endian.little));

  /// Init ByteArray from int32 value.
  factory ByteArray.i32(int value) =>
      ByteArray._fromByteData(ByteData(4)..setUint32(0, value, Endian.little));

  /// Init ByteArray from uint32 value.
  factory ByteArray.u32(int value) =>
      ByteArray._fromByteData(ByteData(4)..setUint32(0, value, Endian.little));

  /// Init ByteArray from int64 value.
  factory ByteArray.i64(int value) => _encodeBigInt(BigInt.from(value), 8);

  /// Init ByteArray from uint64 value.
  factory ByteArray.u64(int value) => _encodeBigIntAsUnsigned(BigInt.from(value), 8);

  /// Bytes value.
  final List<int> _data;

  @override
  Iterator<int> get iterator => _data.iterator;

  /// Convert to Base58 String
  String toBase58() => _data.toBase58();

  /// Convert to Base64 String
  String toBase64() => _data.toBase64();

  /// Convert to Hex String with prefix.
  ///
  /// Example:
  /// ```dart
  /// ByteArray([255,2,3,10]).toHex(); // 0xff02030a
  ///```
  String toHex() => _data.toHex();

  /// Convert to Hex String without prefix.
  ///
  /// Example:
  /// ```dart
  /// ByteArray([255,2,3,10]).toNoPrefixHex(); // ff02030a
  ///```
  String toNoPrefixHex() => _data.toNoPrefixHex();

  /// Convert to Hex String Trim extra zeroes in the beginning of a string with prefix.
  ///
  /// Example:
  /// ```dart
  /// ByteArray([0,0,0,255,2,3,10]).toShortHex(); // 0xff02030a
  ///```
  String toShortHex() => _data.toShortHex();
}

final _byteMask = BigInt.from(0xff);

ByteArray _encodeBigInt(BigInt number, int length) {
  if (number == BigInt.zero) {
    return ByteArray(List.filled(length, 0));
  }

  final result = Uint8List(length);
  for (var i = 0; i < length; i++) {
    result[i] = (number & _byteMask).toInt();
    number = number >> 8;
  }

  return ByteArray(result);
}

ByteArray _encodeBigIntAsUnsigned(BigInt number, int length) {
  if (number == BigInt.zero) {
    return ByteArray(List.filled(length, 0));
  }

  final result = Uint8List(length);
  for (var i = 0; i < length; i++) {
    result[i] = (number & _byteMask).toInt();
    number = number >> 8;
  }
  return ByteArray(result);
}
