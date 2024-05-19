import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/data/constants.dart';
import 'package:todo/core/enums/auth_type.dart';
import 'package:todo/models/auth_result.dart';
import 'package:todo/models/error_state.dart';
import 'package:todo/models/user_data.dart';
import 'package:todo/repositories/authentication_repository.dart';
import 'package:todo/repositories/user_repository.dart';
import 'package:todo/views/widgets/loading_indicator.dart';

part 'auth_state.dart';

class AuthBloc extends Cubit<AuthState> {
  AuthBloc() : super(const AuthState());

  static final AuthenticationRepository authRepo = AuthenticationRepository();
  static final UserRepository userRepo = UserRepository();
  final LoadingIndicator _loadingIndicator = LoadingIndicator.instance;

  Future<void> login({required String email, required String password}) async {
    _loadingIndicator.show();

    final AuthResult result = await authRepo.signInWithEmailAndPassword(email: email, password: password);

    _loadingIndicator.hide();

    if (result.status) {
      preferences.isLogged = true;
      preferences.uid = result.user!.uid;
      emit(state.copyWith(state: _State.login));
    } else {
      emit(state.copyWith(state: _State.failed));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    _loadingIndicator.show();

    final AuthResult result = await authRepo.createUserWithEmailAndPassword(email: email, password: password);

    if (result.status) {
      UserData user = UserData(
        authType: AuthType.email,
        createdAt: DateTime.now(),
        email: result.user?.email,
        uid: result.user?.uid,
        name: name,
      );

      await userRepo.createUser(user);

      preferences.isLogged = true;
      preferences.uid = result.user?.uid ?? '';

      emit(state.copyWith(state: _State.register));
    } else {
      emit(state.copyWith(state: _State.failed));
    }

    _loadingIndicator.hide();
  }

  @override
  void emit(AuthState state) {
    if (!isClosed) super.emit(state);
  }

  Future<void> signOut() async {
    _loadingIndicator.show();

    preferences.logOut();
    await authRepo.signOut();

    emit(state.copyWith(state: _State.logout));

    _loadingIndicator.hide();
  }
}
