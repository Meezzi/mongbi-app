class AuthCancelledException implements Exception {
  const AuthCancelledException(this.message);
  final String message;

  @override
  String toString() => message;
}

class AuthFailedException implements Exception {
  const AuthFailedException(this.message);
  final String message;

  @override
  String toString() => message;
}

class WithdrawnUserException implements Exception {
  const WithdrawnUserException(this.message);
  final String message;

  @override
  String toString() => message;
}
