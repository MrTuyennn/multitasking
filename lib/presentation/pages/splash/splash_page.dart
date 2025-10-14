import 'package:flutter/material.dart';
import 'package:multitasking/app/assets/images.dart';
import 'package:multitasking/app/extensions/build_context_extension.dart';
import 'package:multitasking/app/router/path_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
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

    Future.delayed(const Duration(seconds: 3), _goNext);
  }

  _goNext() {
    Navigator.pushReplacementNamed(context, PathRouter.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Center(
            child: FadeTransition(
              opacity: _fade,
              child: ScaleTransition(
                scale: _scale,
                child: SizedBox(
                  width: context.width / 2,
                  height: context.height / 2,
                  child: Image.asset(
                    ImagePath.appIcon,
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
      ),
    );
  }
}
