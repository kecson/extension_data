import 'dart:convert';

import 'package:extension_data/extension_data.dart';

void main() {
  const str = 'extension_data';
  //utf8 bytes
  const bytes = [
    101,
    120,
    116,
    101,
    110,
    115,
    105,
    111,
    110,
    95,
    100,
    97,
    116,
    97
  ];
  const hexStr = '0x657874656e73696f6e5f64617461';
  const strBs64 = 'ZXh0ZW5zaW9uX2RhdGE=';
  const strBs58 = 'eJdhyKqktt8nj9vnTwe';

  //Codec Example
  final base58Str = base58Encode(utf8.encode(str));
  //eJdhyKqktt8nj9vnTwe
  print(base58Str);

  final rawStr = utf8.decode(base64Decode(strBs64));
  //extension_data
  print(rawStr);

  //Data Example
  //ZXh0ZW5zaW9uX2RhdGE=
  print(Base64Data.fromBytes(bytes).value);
  //[101, 120, 116, 101, 110, 115, 105, 111, 110, 95, 100, 97, 116, 97]
  print(Base58Data(strBs58).bytes);
  //extension_data
  print(utf8.decode(HexData(hexStr).bytes.toList()));
  print(utf8.decode(HexData(hexStr.replaceFirst('0x', '')).bytes.toList()));
  //eJdhyKqktt8nj9vnTwe
  print(HexData(hexStr).bytes.toBase58());

  //Extensions Example
  const timestampInMs = '1661966625123';
  //DateTimeExt
  final dateTime = TimeUnit.milliseconds.parseTimestamp(timestampInMs);
  assert(dateTime.toString() == '2022-09-01 01:23:45.123');

  var d2 = timestampInMs.toDateTime(TimeUnit.milliseconds);
  var atSameMomentAs = d2.isAtSameMomentAs(dateTime);
  print('atSameMomentAs=$atSameMomentAs');
}
