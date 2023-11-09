import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';
import 'package:navgiator/home_details_model.dart';
import 'package:navgiator/network/auth_repo.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';
part 'package:navgiator/home-page.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState.initial()) {
    // on<_GetData>((event, emit) async {
    //   emit(_Loading());
    //
    //   final AuthRepo authRepo = AuthRepo();
    //   final response = await authRepo.userResponse();
    //
    //   if (response != null && response.error == null) {
    //     emit(const _Sucess(response));
    //   } else {
    //     emit(_Failed(error: response?.error ?? "unknown error"));
    //   }
    //
    //   // // API
    //   // emit(_Sucess);
    // });
  }

  Future<HomeDetailsModel?> fetchData() async {
    final AuthRepo authRepo = AuthRepo();
    final response = await authRepo.userResponse();

    return response;
  }
}
