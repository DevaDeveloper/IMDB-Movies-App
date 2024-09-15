import 'failure_model.dart';

abstract class ResponseAPI {}

class ResponseApp<T> {
  T? data;
  Failure? failure;
  bool isError;

  ResponseApp({this.data, this.failure}) : isError = failure != null;
}
