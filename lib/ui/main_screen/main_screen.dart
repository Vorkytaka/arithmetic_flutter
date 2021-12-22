import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  static const String pathKey = '/main';

  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('main screen'),
      ),
    );
  }
}
