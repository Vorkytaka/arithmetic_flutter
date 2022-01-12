import 'dart:math';

import 'package:arithmetic/domain/mode/mode_bloc.dart';
import 'package:arithmetic/ui/game_screen/bloc/game_bloc.dart';
import 'package:arithmetic/widget/you_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameScreen extends StatelessWidget {
  static const String pathKey = '/game';

  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc(
        modes: context.read<ModeBloc>().state,
        random: Random(),
      ),
      lazy: false,
      child: BlocListener<GameBloc, GameState>(
        listener: (context, state) {
          // todo: Анимация
          final String? text;
          switch (state.status) {
            case GameStatus.correct:
              text = 'Правильно!';
              break;
            case GameStatus.wrong:
              text = 'Ошибся, дуралей';
              break;
            case GameStatus.idle:
              text = null;
              break;
          }
          if (text != null) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
            context.read<GameBloc>().resultWasShown();
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Expanded(
                  flex: 1,
                  child: _Header(),
                ),
                Expanded(
                  flex: 2,
                  child: _Keyboard(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<GameBloc, GameState>(builder: (context, state) {
            return Text(
              state.expression.toString(),
              style: Theme.of(context).textTheme.headline3,
            );
          }),
          BlocBuilder<GameBloc, GameState>(
            buildWhen: (prev, curr) => prev.answer != curr.answer,
            builder: (context, state) => FittedBox(
              child: Text(
                '${state.answer}',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Keyboard extends StatelessWidget {
  const _Keyboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            YouButton(
              child: const Text('7'),
              onPressed: () => context.read<GameBloc>().numberClicked(7),
            ),
            YouButton(
              child: const Text('8'),
              onPressed: () => context.read<GameBloc>().numberClicked(8),
            ),
            YouButton(
              child: const Text('9'),
              onPressed: () => context.read<GameBloc>().numberClicked(9),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            YouButton(
              child: const Text('4'),
              onPressed: () => context.read<GameBloc>().numberClicked(4),
            ),
            YouButton(
              child: const Text('5'),
              onPressed: () => context.read<GameBloc>().numberClicked(5),
            ),
            YouButton(
              child: const Text('6'),
              onPressed: () => context.read<GameBloc>().numberClicked(6),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            YouButton(
              child: const Text('1'),
              onPressed: () => context.read<GameBloc>().numberClicked(1),
            ),
            YouButton(
              child: const Text('2'),
              onPressed: () => context.read<GameBloc>().numberClicked(2),
            ),
            YouButton(
              child: const Text('3'),
              onPressed: () => context.read<GameBloc>().numberClicked(3),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            YouButton(
              child: const Icon(Icons.backspace),
              onPressed: () => context.read<GameBloc>().deleteClicked(),
              onLongPress: () => context.read<GameBloc>().deleteLongClicked(),
            ),
            YouButton(
              child: const Text('0'),
              onPressed: () => context.read<GameBloc>().numberClicked(0),
            ),
            YouButton(
              child: const Text('='),
              onPressed: () => context.read<GameBloc>().equalsPressed(),
            ),
          ],
        ),
      ],
    );
  }
}
