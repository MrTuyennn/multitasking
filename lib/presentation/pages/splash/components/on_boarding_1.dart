import 'package:flutter/material.dart';
import 'package:multitasking/app/assets/images.dart';
import 'package:multitasking/app/extensions/build_context_extension.dart';


class OnBoarding1 extends StatefulWidget {
  const OnBoarding1({super.key});

  @override
  State<OnBoarding1> createState() => _OnBoarding1State();
}

class _OnBoarding1State extends State<OnBoarding1>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scale;
  late final Animation<double> _fade;
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    final curve = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );
    _scale = Tween(begin: 0.1, end: 1.1).animate(curve);
    _fade = Tween(begin: 0.0, end: 1.0).animate(curve);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Center(
          child: FadeTransition(
            opacity: _fade,
            child: ScaleTransition(
              scale: _scale,
              child: SizedBox(
                width: 261,
                child: Image.asset(
                  fit: BoxFit.fill,
                  ImagePath.logo,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: context.viewPadding.bottom,
          child: Text("Version 1.0.0"),
        ),
      ],
    );
  }
}