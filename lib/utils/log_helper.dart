import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class LogHelper {
  static void error(error, stackTrace) {
    FlutterError.reportError(
        FlutterErrorDetails(exception: error, stack: stackTrace));
  }
}

Logger logger = Logger();
