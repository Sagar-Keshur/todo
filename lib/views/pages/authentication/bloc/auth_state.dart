// ignore_for_file: library_private_types_in_public_api

part of 'auth_bloc.dart';

enum _State { none, login, register, logout, failed }

class AuthState extends Equatable {
  final _State state;
  final UserData? userInfo;
  final ErrorState<String> errorState;

  const AuthState({
    this.userInfo,
    this.state = _State.none,
    this.errorState = const ErrorState<String>(error: ''),
  });

  AuthState copyWith({
    UserData? userInfo,
    _State? state,
    ErrorState<String>? errorState,
  }) {
    return AuthState(
      userInfo: userInfo ?? this.userInfo,
      state: state ?? this.state,
      errorState: errorState ?? this.errorState,
    );
  }

  @override
  List<Object?> get props {
    return [
      userInfo,
      state,
      errorState,
    ];
  }
}

extension AuthStateEx on AuthState {
  void onChangeState({
    void Function(UserData? userInfo)? onLogin,
    void Function(UserData? userInfo)? onRegister,
    TaskFailedCallback<String>? onFailed,
  }) {
    switch (state) {
      case _State.login:
        if (onLogin != null) onLogin(userInfo);
        break;
      case _State.register:
        if (onRegister != null) onRegister(userInfo);
        break;
      case _State.failed:
        if (onFailed != null) onFailed(errorState);
        break;
      default:
    }
  }
}
