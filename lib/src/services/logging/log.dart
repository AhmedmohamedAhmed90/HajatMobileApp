import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class Log {
  final Logger logIt = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      colors: true,
    ),
    
  );

  void trace(
    dynamic message, {
    dynamic error,
    bool showInProd = false,
    StackTrace? stackTrace,
  }) {
    if (kReleaseMode && !showInProd) {
      return;
    }

    logIt.t(message, error: error, stackTrace: stackTrace);
  }

  void debug(
    dynamic message, {
    dynamic error,
    bool showInProd = false,
    StackTrace? stackTrace,
  }) {
    if (kReleaseMode && !showInProd) {
      return;
    }

    logIt.d(message, error: error, stackTrace: stackTrace);
  }

  void info(
    dynamic message, {
    dynamic error,
    bool showInProd = false,
    StackTrace? stackTrace,
  }) {
    if (kReleaseMode && !showInProd) {
      return;
    }

    logIt.i(message, error: error, stackTrace: stackTrace);
  }

  void warn(
    dynamic message, {
    dynamic error,
    bool showInProd = false,
    StackTrace? stackTrace,
  }) {
    if (kReleaseMode && !showInProd) {
      return;
    }

    logIt.w(message, error: error, stackTrace: stackTrace);
  }

  void error(
    dynamic message, {
    dynamic error,
    bool showInProd = false,
    StackTrace? stackTrace,
  }) {
    if (kReleaseMode && !showInProd) {
      return;
    }

    logIt.e(message, error: error, stackTrace: stackTrace);
  }

  void fatal(
    dynamic message, {
    dynamic error,
    bool showInProd = false,
    StackTrace? stackTrace,
  }) {
    if (kReleaseMode && !showInProd) {
      return;
    }

    logIt.f(message, error: error, stackTrace: stackTrace);
  }
}
