import 'package:flutter/cupertino.dart';
import 'dart:core';

@immutable
class Result<Failure, Success> {
  final dynamic data;
  const Result._({this.data});

  factory Result.success([Success? result]) => Result._(data: result);
  factory Result.failure(Failure failure) => Result._(data: failure);

  bool get isSuccess => data is! Failure;

  @override
  int get hashCode => Object.hash(super.hashCode, data.hashCode);

  @override
  bool operator ==(Object other) {
    if (other is! Result<Failure, Success>) return false;
    return data == other.data && isSuccess == other.isSuccess;
  }
}
