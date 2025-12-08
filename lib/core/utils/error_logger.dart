import 'package:flutter/foundation.dart';
import 'package:bloc_2026/core/exceptions/http_exception.dart';
import 'package:bloc_2026/core/network/model/either.dart';

class ErrorLogger {
  /// Logs error to console in debug mode with formatted output
  static void log(String identifier, dynamic error) {
    debugPrint('═══════════════════════════════════════');
    debugPrint('🔴 ERROR: $identifier');
    debugPrint('Details: ${error.toString()}');
    debugPrint('═══════════════════════════════════════');
  }

  /// Helper function to handle exceptions in data sources
  /// Usage: return ErrorLogger.handleException(e, 'ClassName.methodName');
  static Left<AppException, T> handleException<T>(
    dynamic exception,
    String identifier, {
    String? customMessage,
  }) {
    // Log the error
    log(identifier, exception);

    // Return Left with AppException
    return Left(
      AppException(
        message: customMessage ?? 'Unknown error occurred',
        statusCode: 1,
        identifier: '${exception.toString()}\n$identifier',
      ),
    );
  }
}
