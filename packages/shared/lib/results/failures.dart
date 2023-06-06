import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;
  final String? errorCode;

  const Failure({this.message, this.errorCode});

  @override
  List<Object?> get props => [];
}

class SystemFailure extends Failure {
  const SystemFailure({super.message, super.errorCode});
}

class NoInternetConnection extends Failure {
  const NoInternetConnection({super.message});
}

class NoDataFound extends Failure {
  const NoDataFound({super.message});
}

class DataConsistencyError extends Failure {
  const DataConsistencyError({super.message});
}

class NoCacheData extends Failure {
  const NoCacheData({super.message});
}

//Error when execute server function
class NoPermission extends Failure {
  const NoPermission({super.message});
}

// To remove
class AuthFailure extends Failure {
  final String? code;
  const AuthFailure({this.code, super.message});

  @override
  List<Object?> get props => [code];
}
