import 'package:flutter/material.dart';

class LogHelper {
  static void error(error, stackTrace) {
    FlutterError.reportError(
        FlutterErrorDetails(exception: error, stack: stackTrace));
  }
}
