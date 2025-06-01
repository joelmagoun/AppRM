import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

void setupLogging() {
  Logger.root.level = Level.INFO;
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      debugPrint(
          '[${record.loggerName}] ${record.level.name}: ${record.time}: ${record.message}');

      if (record.error != null) {
        debugPrint(record.error?.toString());
      }
      if (record.stackTrace != null) {
        debugPrint(record.stackTrace?.toString());
      }
    }
  });
}
