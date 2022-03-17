class DomainException<T> implements Exception {
  final T? failureType;
  DomainException({this.failureType});
}