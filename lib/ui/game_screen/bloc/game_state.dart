part of 'game_bloc.dart';

@immutable
class GameState {
  final int answer;
  final Expression expression;

  const GameState({
    required this.answer,
    required this.expression,
  });

  factory GameState.init({required Expression expression}) => GameState(
        answer: 0,
        expression: expression,
      );

  GameState copyWith({
    int? answer,
    Expression? expression,
  }) =>
      GameState(
        answer: answer ?? this.answer,
        expression: expression ?? this.expression,
      );
}

@immutable
class Expression {
  final int x;
  final int y;
  final OperationMode operation;
  final int answer;

  Expression({
    required this.x,
    required this.y,
    required this.operation,
  }) : answer = _answer(x, y, operation);

  static int _answer(int x, int y, OperationMode operation) {
    switch (operation) {
      case OperationMode.addition:
        return x + y;
      case OperationMode.subtraction:
        return x - y;
      case OperationMode.multiplication:
        return x * y;
    }
  }

  @override
  String toString() {
    final String operationString;
    switch (operation) {
      case OperationMode.addition:
        operationString = '+';
        break;
      case OperationMode.subtraction:
        operationString = '-';
        break;
      case OperationMode.multiplication:
        operationString = '*';
        break;
    }
    return '$x $operationString $y';
  }
}
