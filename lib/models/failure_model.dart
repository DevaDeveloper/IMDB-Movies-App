import 'package:equatable/equatable.dart';

import 'response.dart';

class Failure extends Equatable implements ResponseAPI {
  final String code;
  final String message;
  final String key;

  const Failure({required this.code, this.message = '', required this.key});

  static unhandled() {
    return const Failure(key: 'UNHANDLED_ERROR', code: '999', message: 'Unhandled error');
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [code, message, key];
}

const Failure parsingError = Failure(code: '12345', key: 'parsing_error', message: 'Parsing error');
const Failure noContentError = Failure(code: '204', key: 'no_content', message: 'No Content');
