import 'package:extension_data/src/data/byte_array.dart';
import 'package:extension_data/src/ext/iterable_int_ext.dart';

/// Base58Data Contain a base58 String [value]. also can decode [value] to [bytes].
class Base58Data {
  /// From base58 String [value]
  const Base58Data(this.value);

  factory Base58Data.fromBytes(Iterable<int> bytes) => Base58Data(bytes.toBase58());

  /// Base58 String
  final String value;

  /// decode base58 String [value] to [bytes]
  Iterable<int> get bytes => ByteArray.fromBase58(value);

  /// return base58 String [value]
  @override
  String toString() => value;
}
