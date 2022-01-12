import 'package:flutter/material.dart';

class YouButton extends StatefulWidget {
  final Widget child;
  final double width;
  final double height;
  final double startRadius;
  final Duration duration;
  final Duration reverseDuration;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final Color? color;
  final double elevation;

  const YouButton({
    Key? key,
    required this.child,
    this.color,
    this.width = 80,
    this.height = 80,
    this.duration = const Duration(milliseconds: 150),
    this.reverseDuration = const Duration(milliseconds: 100),
    this.textStyle,
    this.onPressed,
    this.onLongPress,
    this.elevation = 3,
  })  : startRadius = width > height ? height / 2 : width / 2,
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
    animation = AnimationController(
      vsync: this,
      duration: widget.duration,
      reverseDuration: widget.reverseDuration,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    radius ??= Tween<double>(begin: widget.startRadius, end: widget.startRadius / 2).animate(CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ));
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
          color: widget.color ?? Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(radius?.value ?? 50)),
          elevation: widget.elevation,
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTapDown: widget.onPressed != null ? (_) => animation.forward() : null,
            onTap: widget.onPressed != null
                ? () {
                    animation.reverse();
                    widget.onPressed!.call();
                  }
                : null,
            onTapCancel: widget.onPressed != null ? () => animation.reverse() : null,
            onLongPress: widget.onLongPress,
            child: Container(
              width: widget.width,
              height: widget.height,
              alignment: Alignment.center,
              child: child,
            ),
          ),
        );
      },
      child: IconTheme(
        data: Theme.of(context).primaryIconTheme,
        child: DefaultTextStyle(
          style: widget.textStyle ??
              Theme.of(context).textTheme.headline5!.copyWith(color: Theme.of(context).colorScheme.onPrimary),
          child: widget.child,
        ),
      ),
    );
  }
}
