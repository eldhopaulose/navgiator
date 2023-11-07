import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:navgiator/network/auth_repo.dart';
import 'package:navgiator/home-page.dart';
import 'package:navgiator/usermodel.dart';
part '../../login-page.dart';
part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  LoginBloc() : super(const LoginState.initial()) {
    on<LoginEvent>((event, emit) {

    });
  }
}
//dart run build_runner build --delete-conflicting-outputs
