import 'package:equatable/equatable.dart';

class ErrorState<T> extends Equatable {
  final T error;

  const ErrorState({required this.error});

  @override
  List<Object?> get props => [error];

  @override
  String toString() => 'ErrorState(error: ${error.toString()})';
}

typedef TaskFailedCallback<T> = void Function(ErrorState<T> errorState);
