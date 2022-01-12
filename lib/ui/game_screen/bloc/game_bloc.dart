import 'package:arithmetic/domain/mode/mode_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'game_state.dart';

class GameBloc extends Cubit<GameState> {
  final ModeState modes;

  GameBloc({
    required this.modes,
  }) : super(GameState.init());

  void numberClicked(int n) {
    final newAnswer = state.answer * 10 + n;
    if (newAnswer >= 1000000) return;
    emit(state.copyWith(answer: newAnswer));
  }

  void deleteClicked() {
    emit(state.copyWith(answer: state.answer ~/ 10));
  }

  void deleteLongClicked() {
    emit(state.copyWith(answer: 0));
  }
}
