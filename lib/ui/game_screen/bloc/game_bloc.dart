import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class GameBloc extends Cubit<GameState> {
  GameBloc() : super(GameState.init());
}

@immutable
class GameState {
  final String answer;

  const GameState({
    required this.answer,
  });

  factory GameState.init() => const GameState(answer: '0');
}
