import 'package:arithmetic/data/mode_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class ModeBloc extends Cubit<ModeState> {
  final ModeStorage storage;

  ModeBloc({
    required this.storage,
  }) : super(ModeState.init()) {
    storage.getModes().onError((_, __) => 0).then((value) => emit(ModeState(modes: value)));
  }

  void numberModeClicked(NumberMode mode) {
    final int x;
    switch (mode) {
      case NumberMode.ones:
        x = ModeState.ones;
        break;
      case NumberMode.tens:
        x = ModeState.tens;
        break;
      case NumberMode.hundreds:
        x = ModeState.hundreds;
        break;
    }

    emit(state.copyWith(modes: state.modes ^ x));
  }

  void operationModeClicked(OperationMode mode) {
    final int x;
    switch (mode) {
      case OperationMode.addition:
        x = ModeState.addition;
        break;
      case OperationMode.subtraction:
        x = ModeState.subtraction;
        break;
      case OperationMode.multiplication:
        x = ModeState.multiplication;
        break;
    }

    emit(state.copyWith(modes: state.modes ^ x));
  }

  @override
  void onChange(Change<ModeState> change) {
    super.onChange(change);
    final current = change.currentState.modes;
    final next = change.nextState.modes;
    if (current != next) {
      storage.saveModes(modes: next);
    }
  }
}

@immutable
class ModeState {
  static final int ones = int.parse('000001', radix: 2);
  static final int tens = int.parse('000010', radix: 2);
  static final int hundreds = int.parse('000100', radix: 2);
  static final int addition = int.parse('001000', radix: 2);
  static final int subtraction = int.parse('010000', radix: 2);
  static final int multiplication = int.parse('100000', radix: 2);

  final int modes;

  const ModeState({
    required this.modes,
  });

  factory ModeState.init() => ModeState(modes: int.parse('000000', radix: 2));

  ModeState copyWith({int? modes}) => ModeState(modes: modes ?? this.modes);

  bool get isOnesEnable => modes & ones == ones;

  bool get isTensEnable => modes & tens == tens;

  bool get isHundredsEnable => modes & hundreds == hundreds;

  bool get isAdditionEnable => modes & addition == addition;

  bool get isSubtractionEnable => modes & subtraction == subtraction;

  bool get isMultiplicationEnable => modes & multiplication == multiplication;

  bool get canStart =>
      (isOnesEnable || isTensEnable || isHundredsEnable) &&
      (isAdditionEnable || isSubtractionEnable || isMultiplicationEnable);
}

enum NumberMode {
  ones,
  tens,
  hundreds,
}

enum OperationMode {
  addition,
  subtraction,
  multiplication,
}
