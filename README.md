# extension_data

[![pub package](https://img.shields.io/pub/v/extension_data.svg)](https://pub.dev/packages/extension_data)

## Using

```dart
import 'package:extension_data/extension_data.dart';

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
    expect(hexEncode(bytes), hexStr);
    expect(hexDecode(hexStr), bytes);
  });
```

```dart
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
  });
```
