import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T? response;
  final DioException? exception;
  const DataState({this.response, this.exception});
}
class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(response: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(DioException exception) : super(exception: exception);
}