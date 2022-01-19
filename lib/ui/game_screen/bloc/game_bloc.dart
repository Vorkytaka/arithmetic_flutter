import 'dart:math';

import 'package:arithmetic/data/expression_storage.dart';
import 'package:arithmetic/domain/mode/mode_bloc.dart';
import 'package:arithmetic/entity/expression.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'game_state.dart';

class GameBloc extends Cubit<GameState> {
  final ModeState modes;

  final Random random;

  final List<NumberMode> numberModes;
  final List<OperationMode> operationModes;

  final ExpressionStorage expressionStorage;

  // todo: Обдумать создание первого выражения
  GameBloc({
    required this.modes,
    required this.random,
    required this.expressionStorage,
  })  : numberModes = [
          if (modes.isOnesEnable) NumberMode.ones,
          if (modes.isTensEnable) NumberMode.tens,
          if (modes.isHundredsEnable) NumberMode.hundreds,
        ],
        operationModes = [
          if (modes.isAdditionEnable) OperationMode.addition,
          if (modes.isSubtractionEnable) OperationMode.subtraction,
          if (modes.isMultiplicationEnable) OperationMode.multiplication,
        ],
        super(
          GameState.init(
            expression: getExpression(
              [
                if (modes.isOnesEnable) NumberMode.ones,
                if (modes.isTensEnable) NumberMode.tens,
                if (modes.isHundredsEnable) NumberMode.hundreds,
              ],
              [
                if (modes.isAdditionEnable) OperationMode.addition,
                if (modes.isSubtractionEnable) OperationMode.subtraction,
                if (modes.isMultiplicationEnable) OperationMode.multiplication,
              ],
              random,
            ),
          ),
        );

  static Expression getExpression(
    List<NumberMode> numberModes,
    List<OperationMode> operationModes,
    Random random,
  ) {
    final x = getNumber(numberModes, random);
    final y = getNumber(numberModes, random);
    final operation = operationModes[random.nextInt(operationModes.length)];
    return Expression(
      x: max(x, y),
      y: min(x, y),
      operation: operation,
    );
  }

  static int getNumber(
    List<NumberMode> numberModes,
    Random random,
  ) {
    final mode = numberModes[random.nextInt(numberModes.length)];
    switch (mode) {
      case NumberMode.ones:
        return random.nextInt(10);
      case NumberMode.tens:
        return random.nextInt(90) + 10;
      case NumberMode.hundreds:
        return random.nextInt(900) + 100;
    }
  }

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

  void equalsPressed() {
    final status = state.answer == state.expression.answer ? GameStatus.correct : GameStatus.wrong;
    emit(state.copyWith(status: status));
    expressionStorage.saveExpression(expression: state.expression, answer: state.answer);
  }

  void resultWasShown() {
    final expression = getExpression(numberModes, operationModes, random);
    emit(state.copyWith(
      status: GameStatus.idle,
      expression: expression,
      answer: 0,
    ));
  }
}
