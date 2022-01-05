import 'package:animations/animations.dart';
import 'package:arithmetic/domain/mode/mode_bloc.dart';
import 'package:arithmetic/ui/game_screen/game_screen.dart';
import 'package:arithmetic/widget/you_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  static const String pathKey = '/main';

  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<ModeBloc, ModeState>(
        buildWhen: (prev, curr) => prev.canStart != curr.canStart,
        builder: (context, state) => state.canStart ? OpenContainer(
          transitionDuration: const Duration(milliseconds: 450),
          closedColor: Theme.of(context).primaryColor,
          closedElevation: 3,
          closedShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
          tappable: true,
          closedBuilder: (context, _) => SizedBox(
            width: 80,
            height: 80,
            child: IconTheme(
              data: Theme.of(context).primaryIconTheme,
              child: const Icon(Icons.arrow_forward_ios),
            ),
          ),
          openBuilder: (context, _) => const GameScreen(),
        ) : const SizedBox.shrink(),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _Button(
                  title: '0-9',
                  onPressed: () => context.read<ModeBloc>().numberModeClicked(NumberMode.ones),
                  selector: (state) => state.isOnesEnable,
                  child: const Text('1'),
                ),
                _Button(
                  title: '10-99',
                  onPressed: () => context.read<ModeBloc>().numberModeClicked(NumberMode.tens),
                  selector: (state) => state.isTensEnable,
                  child: const Text('10'),
                ),
                _Button(
                  title: '100-999',
                  onPressed: () => context.read<ModeBloc>().numberModeClicked(NumberMode.hundreds),
                  selector: (state) => state.isHundredsEnable,
                  child: const Text('100'),
                ),
              ],
            ),
            const SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _Button(
                  title: 'Сложение',
                  onPressed: () => context.read<ModeBloc>().operationModeClicked(OperationMode.addition),
                  selector: (state) => state.isAdditionEnable,
                  child: const Text('+'),
                ),
                _Button(
                  title: 'Вычитание',
                  onPressed: () => context.read<ModeBloc>().operationModeClicked(OperationMode.subtraction),
                  selector: (state) => state.isSubtractionEnable,
                  child: const Text('-'),
                ),
                _Button(
                  title: 'Умножение',
                  onPressed: () => context.read<ModeBloc>().operationModeClicked(OperationMode.multiplication),
                  selector: (state) => state.isMultiplicationEnable,
                  child: const Text('×'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _ButtonWithTitle extends StatelessWidget {
  final String title;
  final Widget buttonChild;
  final Color? color;
  final VoidCallback? onPressed;

  const _ButtonWithTitle({
    Key? key,
    required this.buttonChild,
    required this.title,
    this.color,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        YouButton(
          child: buttonChild,
          color: color,
          onPressed: onPressed,
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }
}

typedef _FieldSelector = bool Function(ModeState state);

class _Button extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback onPressed;
  final _FieldSelector selector;

  const _Button({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.selector,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModeBloc, ModeState>(
      buildWhen: (prev, curr) => selector(prev) != selector(curr),
      builder: (context, state) => _ButtonWithTitle(
        title: title,
        buttonChild: child,
        color: selector(state) ? Theme.of(context).primaryColor : Theme.of(context).errorColor,
        onPressed: onPressed,
      ),
    );
  }
}
