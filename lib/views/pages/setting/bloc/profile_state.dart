// ignore_for_file: library_private_types_in_public_api

part of 'profile_bloc.dart';

enum _TaskState { none, succeeded, failed }

class ProfileState extends Equatable {
  final UserData? userInfo;
  final bool accountNotExists;
  final _TaskState taskState;
  final ErrorState<String> errorState;

  const ProfileState({
    this.userInfo,
    this.accountNotExists = false,
    this.taskState = _TaskState.none,
    this.errorState = const ErrorState(error: ''),
  });

  ProfileState copyWith({
    UserData? userInfo,
    bool? accountNotExists,
    _TaskState? taskState,
    ErrorState<String>? errorState,
  }) {
    return ProfileState(
      userInfo: userInfo ?? this.userInfo,
      accountNotExists: accountNotExists ?? this.accountNotExists,
      taskState: taskState ?? this.taskState,
      errorState: errorState ?? this.errorState,
    );
  }

  bool get hasData => userInfo != null;

  @override
  List<Object?> get props => [userInfo, accountNotExists, taskState, errorState];
}
