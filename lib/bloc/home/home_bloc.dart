import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'homek_event.dart';
part 'homek_state.dart';
part 'homek_bloc.freezed.dart';

class HomekBloc extends Bloc<HomekEvent, HomekState> {
  HomekBloc() : super(const HomekState.initial()) {
    on<HomekEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
