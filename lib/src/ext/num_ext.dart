import 'package:decimal/decimal.dart';

/// int extension methods.
extension IntExt on int {
  BigInt toBigInt() => BigInt.from(this);

  Duration get days => Duration(days: this);

  Duration get hours => Duration(hours: this);

  Duration get minutes => Duration(minutes: this);

  Duration get seconds => Duration(seconds: this);

  Duration get milliseconds => Duration(milliseconds: this);

  Duration get microseconds => Duration(microseconds: this);
}

/// BigInt extension methods.
extension BigIntExt on BigInt {
  Decimal toDecimal() => Decimal.fromBigInt(this);
}

/// num extension methods.
extension NumExt on num {

  Decimal toDecimal() => Decimal.parse('$this');
}
