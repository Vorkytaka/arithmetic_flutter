import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  static const String pathKey = '/history';

  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'История',
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
