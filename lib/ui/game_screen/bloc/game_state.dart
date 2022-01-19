part of 'game_bloc.dart';

@immutable
class GameState {
  final int answer;
  final Expression expression;
  final GameStatus status;

  const GameState({
    required this.answer,
    required this.expression,
    required this.status,
  });

  factory GameState.init({required Expression expression}) => GameState(
        answer: 0,
        expression: expression,
        status: GameStatus.idle,
      );

  GameState copyWith({
    int? answer,
    Expression? expression,
    GameStatus? status,
  }) =>
      GameState(
        answer: answer ?? this.answer,
        expression: expression ?? this.expression,
        status: status ?? this.status,
      );
}

enum GameStatus {
  idle,
  correct,
  wrong,
}
