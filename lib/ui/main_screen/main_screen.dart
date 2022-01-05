import 'package:arithmetic/widget/you_button.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  static const String pathKey = '/main';

  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                YouButton(
                  child: Text('1'),
                  width: 80,
                  height: 80,
                ),
                YouButton(
                  child: Text('10'),
                  width: 80,
                  height: 80,
                ),
                YouButton(
                  child: Text('100'),
                  width: 80,
                  height: 80,
                ),
              ],
            ),
            const SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                YouButton(
                  child: Text('+'),
                  width: 80,
                  height: 80,
                ),
                YouButton(
                  child: Text('-'),
                  width: 80,
                  height: 80,
                ),
                YouButton(
                  child: Text('*'),
                  width: 80,
                  height: 80,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
