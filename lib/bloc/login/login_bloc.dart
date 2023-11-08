import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:navgiator/bloc/home/home_bloc.dart';

import 'package:navgiator/network/auth_repo.dart';
// import 'package:navgiator/home-page.dart';
import 'package:navgiator/usermodel.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
part '../../login-page.dart';
part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState.initial()) {
    on<_OnLoginClicked>((event, emit) async {
      emit(const _Loading());
      AuthRepo repo = AuthRepo();

      final response = await repo
          .loginRequest(UserModel(email: event.email, password: event.pass));

      if (response != null && response.error == null) {
        emit(const _LoginSuccess());
      } else {
        emit(_LoginFail(error: response?.error ?? "unknown error"));
      }
    });
  }
}
//dart run build_runner build --delete-conflicting-outputs
