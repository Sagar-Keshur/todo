import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/models/error_state.dart';
import 'package:todo/models/user_data.dart';
import 'package:todo/repositories/user_repository.dart';

part 'profile_state.dart';

class ProfileBloc extends Cubit<ProfileState> {
  ProfileBloc() : super(const ProfileState());

  final UserRepository _userRepo = UserRepository();

  Future<void> getUserInfo() async {
    var value = await _userRepo.getUser();
    if (value.data() != null) {
      emit(state.copyWith(userInfo: value.data(), taskState: _TaskState.succeeded));
    } else {
      emit(state.copyWith(taskState: _TaskState.failed, accountNotExists: true));
    }
  }

  void setUserInfo(UserData user) {
    emit(state.copyWith(userInfo: user, taskState: _TaskState.none));
  }
}
