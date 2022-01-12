part of 'game_bloc.dart';

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
