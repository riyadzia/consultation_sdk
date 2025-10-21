import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int statusCode;
  final List<String> errorList;

  const Failure(this.message, [this.statusCode = 404, this.errorList = const []]);

  @override
  List<Object> get props => [message, statusCode, errorList];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message, super.statusCode);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

class FormValidationFailure extends Failure {
  const FormValidationFailure(super.message,super.statusCode, super.errorList);
}
