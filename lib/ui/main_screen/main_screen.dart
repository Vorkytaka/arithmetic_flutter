import 'package:arithmetic/widget/you_button.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  static const String pathKey = '/main';

  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: YouButton(
          child: Text('='),
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
