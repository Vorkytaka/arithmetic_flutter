import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class GameBloc extends Cubit<GameState> {
  GameBloc() : super(GameState.init());

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
