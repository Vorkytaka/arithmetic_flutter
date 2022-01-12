import 'package:arithmetic/data/storage.dart';
import 'package:arithmetic/domain/mode/mode_bloc.dart';
import 'package:arithmetic/main.dart';
import 'package:arithmetic/ui/game_screen/game_screen.dart';
import 'package:arithmetic/ui/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dependencies(
      child: MaterialApp(
        title: 'Arithmetic',
        initialRoute: MainScreen.pathKey,
        routes: {
          MainScreen.pathKey: (context) => const MainScreen(),
          GameScreen.pathKey: (context) => const GameScreen(),
        },
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.green.shade600,
          scaffoldBackgroundColor: Colors.grey.shade900,
          primaryIconTheme: const IconThemeData(color: Colors.white),
          errorColor: Colors.red.shade900,
          colorScheme: ColorScheme(
            brightness: Brightness.dark,
            background: Colors.green.shade600,
            onBackground: Colors.white,
            error: Colors.red.shade900,
            onError: Colors.white,
            primary: Colors.green.shade600,
            primaryVariant: Colors.grey.shade700,
            onPrimary: Colors.white,
            secondary: Colors.cyan.shade700,
            secondaryVariant: Colors.grey.shade700,
            onSecondary: Colors.white,
            surface: Colors.grey.shade900,
            onSurface: Colors.white,
          ),
        ),
      ),
    );
  }
}

class Dependencies extends StatelessWidget {
  final Widget child;

  const Dependencies({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<Storage>(
      create: (context) => SharedPreferencesStorage(sharedPreferences: sharedPreferences),
      child: BlocProvider(
        create: (context) => ModeBloc(storage: context.read()),
        lazy: false,
        child: child,
      ),
    );
  }
}
