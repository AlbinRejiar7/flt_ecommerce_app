class AppException implements Exception {
  final String message;

  const AppException(this.message);

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  const NetworkException([super.message = 'No internet connection']);
}

class ServerException extends AppException {
  const ServerException([super.message = 'Server error occurred']);
}

class RequestTimeoutException extends AppException {
  const RequestTimeoutException([super.message = 'Request timed out']);
}

class DataParsingException extends AppException {
  const DataParsingException([
    super.message = 'Invalid data received from server',
  ]);
}

class UnknownException extends AppException {
  const UnknownException([super.message = 'Something went wrong']);
}
