import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class GameBloc extends Cubit<GameState> {
  GameBloc() : super(GameState.init());

  void numberClicked(int n) {
    // todo: text size
    if (state.answer.toString().length >= 6) return;
    emit(state.copyWith(answer: state.answer * 10 + n));
  }

  void deleteClicked() {
    emit(state.copyWith(answer: state.answer ~/ 10));
  }

  void deleteLongClicked() {
    emit(state.copyWith(answer: 0));
  }
}

@immutable
class GameState {
  final int answer;

  const GameState({
    required this.answer,
  });

  factory GameState.init() => const GameState(answer: 0);

  GameState copyWith({
    int? answer,
  }) =>
      GameState(answer: answer ?? this.answer);
}
