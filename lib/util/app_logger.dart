import 'package:logger/logger.dart';

var logger = Logger();

void logInfo(String message) {
  logger.i(message);
}

void logError(String message) {
  logger.e(message);
}
