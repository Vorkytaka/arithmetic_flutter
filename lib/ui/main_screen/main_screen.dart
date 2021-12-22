import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  static const String pathKey = '/main';

  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: YouButton(
          text: '+',
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}

class YouButton extends StatefulWidget {
  final String text;
  final double width;
  final double height;
  final double startRadius;

  const YouButton({
    Key? key,
    required this.text,
    required this.width,
    required this.height,
  })  : startRadius = width > height ? height : width,
        super(key: key);

  @override
  State<YouButton> createState() => _YouButtonState();
}

class _YouButtonState extends State<YouButton> with SingleTickerProviderStateMixin {
  late final AnimationController animation;
  Animation<double>? radius;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    radius ??= Tween<double>(begin: widget.startRadius, end: widget.startRadius / 5).animate(animation);
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Material(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(radius?.value ?? 50)),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTapDown: (d) {
              animation.forward();
            },
            onTap: () {
              animation.reverse();
            },
            onTapCancel: () {
              animation.reverse();
            },
            child: Container(
              width: widget.width,
              height: widget.height,
              alignment: Alignment.center,
              child: child,
            ),
          ),
        );
      },
      child: Text(
        widget.text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline4?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }
}
