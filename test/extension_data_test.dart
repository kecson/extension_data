import 'dart:convert';

import 'package:extension_data/extension_data.dart';
import 'package:test/test.dart';

void main() {
  const str = 'extension_data';
  //utf8:  [101, 120, 116, 101, 110, 115, 105, 111, 110, 95, 100, 97, 116, 97]
  final bytes = utf8.encode(str);
  const hexStr = '0x657874656e73696f6e5f64617461';
  const strBs64 = 'ZXh0ZW5zaW9uX2RhdGE=';
  const strBs58 = 'eJdhyKqktt8nj9vnTwe';
  test('Test Codec', () {
    print('$str:  bytes: ${bytes.toList()}');
    //base58
    expect(base58Encode(bytes), strBs58);
    expect(base58Decode(strBs58), bytes);
    //base64
    expect(base64Encode(bytes), strBs64);
    expect(base64Decode(strBs64), bytes);
    //hex
    expect(hexEncode(bytes).toHexData().value, hexStr);
    expect(hexDecode(hexStr), bytes);
    expect(hexDecode('0x0102030a'), [1, 2, 3, 10]);
    expect(hexDecode('0a0b0102'), [10, 11, 1, 2]);
    expect(hexDecode('000f010a'), [0, 15, 1, 10]);
    expect(hexDecode('F0102'), [15, 1, 2]);
  });

  test('Test Data', () {
    //base58Data
    expect(Base58Data(strBs58).bytes, bytes);
    expect(Base58Data.fromBytes(bytes).value, strBs58);
    //base64Data
    expect(Base64Data(strBs64).bytes, bytes);
    expect(Base64Data.fromBytes(bytes).value, strBs64);
    //hexData
    expect(HexData(hexStr).bytes, bytes);
    expect(HexData.fromBytes(bytes).value, hexStr);
    //ByteArray.fromBase58
    expect(ByteArray.fromBase58(strBs58), bytes);
    expect(ByteArray.fromBase58(strBs58).toBase64(), strBs64);
    expect(ByteArray.fromBase58(strBs58).toHex(), hexStr);
    expect(ByteArray.fromBase64(strBs64), bytes);
    //ByteArray.fromHex
    expect(ByteArray.fromHex(hexStr), bytes);
    expect(ByteArray.fromHex(hexStr.replaceFirst('0x', '')), bytes);
    expect(ByteArray.fromHex('0x0102030a').toList(), [1, 2, 3, 10]);
    expect(ByteArray.fromHex('0a0b0102').toList(), [10, 11, 1, 2]);
    expect(ByteArray.fromHex('000f010a').toList(), [0, 15, 1, 10]);
    expect(ByteArray.fromHex('F0102').toList(), [15, 1, 2]);
    //ByteArray from bytes an to Hex String
    expect(ByteArray([255, 2, 3, 10]).toHex(), '0xff02030a');
    expect(ByteArray([255, 2, 3, 10]).toNoPrefixHex(), 'ff02030a');
    expect(ByteArray([0, 0, 0, 255, 2, 3, 10]).toShortHex(), '0xff02030a');
  });

  test('Test extension', () {
    const utcTimestampInMs = 1661966625123;
    //DateTimeExt
    final dateTime = TimeUnit.milliseconds.parseTimestamp('$utcTimestampInMs',isUtc: true);
    expect(dateTime.toString(), '2022-08-31 17:23:45.123Z');
    expect(
        DateTime.utc(2022, 8, 31, 17, 23, 45, 123,).toTimestamp(TimeUnit.milliseconds),
        utcTimestampInMs);
    //StringExt
    expect(strBs64.toBase64Data().bytes, bytes);
    expect(strBs64.toBase64Data().value, strBs64);
    expect(strBs58.toBase58Data().bytes, bytes);
    expect(strBs58.toBase58Data().value, strBs58);
    expect(hexStr.toHexData().bytes, bytes);
    expect(hexStr.toHexData().value, hexStr);
  });
}
