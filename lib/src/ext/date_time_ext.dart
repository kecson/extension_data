import 'package:extension_data/src/ext/string_ext.dart';

/// DateTime extension methods.
extension DateTimeExt on DateTime {
  /// Format DateTime to timestamp.
  ///
  /// Example:
  /// ```dart
  /// DateTime(2022, 9, 1, 1, 23, 45, 123).toTimestamp(TimeUnit.milliseconds); // 1661966625123
  /// DateTime(2022, 9, 1, 1, 23, 45).toTimestamp(TimeUnit.seconds); // 1661966625
  /// ```
  int toTimestamp(TimeUnit unit) => unit.formatTimestamp(this);
}

/// Timestamp uint.
enum TimeUnit { seconds, milliseconds, microseconds }

/// TimeUnit extension methods.
extension TimeUnitExt on TimeUnit {
  /// Parse timestamp to DateTime.
  ///
  /// Example:
  /// ```dart
  /// TimeUnit.milliseconds.parseTimestamp('1661966625123'); // 2022-09-01 01:23:45.123
  /// ```
  DateTime parseTimestamp(String timestamp, {bool isUtc = false}) {
    int microsecondsSinceEpoch;
    switch (this) {
      case TimeUnit.microseconds:
        microsecondsSinceEpoch = timestamp.toInt();
        break;
      case TimeUnit.milliseconds:
        microsecondsSinceEpoch = timestamp.toInt() * 1000;
        break;
      case TimeUnit.seconds:
        microsecondsSinceEpoch = timestamp.toInt() * 1000 * 1000;
        break;
    }
    return DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch, isUtc: isUtc);
  }

  /// Format DateTime to timestamp.
  ///
  /// Example:
  /// ```dart
  /// TimeUnit.milliseconds.formatTimestamp(DateTime(2022, 9, 1, 1, 23, 45, 123)); // 1661966625123
  /// TimeUnit.seconds.formatTimestamp(DateTime(2022, 9, 1, 1, 23, 45, 123)); // 1661966625
  /// ```
  int formatTimestamp(DateTime dateTime) {
    int timestamp;
    switch (this) {
      case TimeUnit.microseconds:
        timestamp = dateTime.microsecondsSinceEpoch;
        break;
      case TimeUnit.milliseconds:
        timestamp = dateTime.millisecondsSinceEpoch;
        break;
      case TimeUnit.seconds:
        timestamp = dateTime.millisecondsSinceEpoch ~/ 1000;
        break;
    }
    return timestamp;
  }

  /// Try to arse timestamp to DateTime.
  DateTime? tryParseTimestamp(String timestamp, {bool isUtc = false}) {
    try {
      return parseTimestamp(timestamp, isUtc: isUtc);
    } catch (e) {
      return null;
    }
  }
}
