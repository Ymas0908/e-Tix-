class UnauthorizedException implements Exception {
  final String? message;

  UnauthorizedException({this.message});
}

class BadRequestException implements Exception {
  final String? _message;

  BadRequestException({String? message}) : _message = message;

  @override
  String toString() => _message ?? 'Bad request';
}

class FetchDataException implements Exception {
  final String message;

  FetchDataException(this.message);
}

class NotFoundException implements Exception {
  final String? message;

  NotFoundException({this.message});
}

class ServerException implements Exception {
  final String? message;

  ServerException({this.message});
}

class NoInternetException implements Exception {
  final String message;

  NoInternetException(this.message);
}

class ForbiddenException implements Exception {
  final String? message;

  ForbiddenException({this.message});
}

class ConflictException implements Exception {
  final String? message;

  ConflictException({this.message});
}

class UnknownException implements Exception {
  final String message;

  UnknownException(this.message);
}

class TimeoutException implements Exception {
  final String message;

  TimeoutException(this.message);
}

class TooManyRequestsException implements Exception {
  final String message;

  TooManyRequestsException(this.message);
}

class ServiceUnavailableException implements Exception {
  String? message;

  ServiceUnavailableException({this.message});
}
