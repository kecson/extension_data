import 'package:extension_data/src/data/byte_array.dart';
import 'package:extension_data/src/ext/iterable_int_ext.dart';

/// Base64Data Contain a base64 String [value]. also can decode [value] to [bytes].
class Base64Data {
  /// From base64 String [value]
  const Base64Data(this.value);

  Base64Data.fromBytes(Iterable<int> bytes) : this(bytes.toBase64());

  /// Base64 String
  final String value;

  /// decode base64 String [value] to [bytes]
  Iterable<int> get bytes => ByteArray.fromBase64(value);

  /// return base64 String [value]
  @override
  String toString() => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Base64Data &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
