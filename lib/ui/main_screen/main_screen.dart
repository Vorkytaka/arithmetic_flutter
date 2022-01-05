import 'package:animations/animations.dart';
import 'package:arithmetic/ui/game_screen/game_screen.dart';
import 'package:arithmetic/widget/you_button.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  static const String pathKey = '/main';

  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: OpenContainer(
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
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _ButtonWithTitle(
                  title: '0-9',
                  buttonChild: Text('1'),
                ),
                _ButtonWithTitle(
                  title: '10-99',
                  buttonChild: Text('10'),
                ),
                _ButtonWithTitle(
                  title: '100-999',
                  buttonChild: Text('100'),
                ),
              ],
            ),
            const SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _ButtonWithTitle(
                  title: 'Сложение',
                  buttonChild: Text('+'),
                ),
                _ButtonWithTitle(
                  title: 'Вычитание',
                  buttonChild: Text('-'),
                ),
                _ButtonWithTitle(
                  title: 'Умножение',
                  buttonChild: Text('×'),
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

  const _ButtonWithTitle({
    Key? key,
    required this.buttonChild,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        YouButton(child: buttonChild),
        const SizedBox(height: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }
}
