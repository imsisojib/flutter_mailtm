import 'package:flutter/cupertino.dart';

class VisibilityTweenEffect extends StatefulWidget{
  final Widget? child;
  final Duration duration;
  const VisibilityTweenEffect({Key? key, this.child, required this.duration,}) : super(key: key);

  @override
  State<VisibilityTweenEffect> createState() => _VisibilityTweenEffectState();
}

class _VisibilityTweenEffectState extends State<VisibilityTweenEffect> {


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return TweenAnimationBuilder<double>(
      key: widget.key,
      tween: Tween(begin: 0.1, end: 1.0),
      duration: widget.duration,
      builder: (context, value, child) => Opacity(
        opacity: value,
        child: child,
      ),
      child: widget.child,
    );
  }
}