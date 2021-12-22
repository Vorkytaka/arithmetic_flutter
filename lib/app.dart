import 'package:arithmetic/ui/main_screen/main_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arithmetic',
      initialRoute: MainScreen.pathKey,
      routes: {
        MainScreen.pathKey: (context) => const MainScreen(),
      },
    );
  }
}
