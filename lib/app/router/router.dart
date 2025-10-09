import 'package:flutter/material.dart';
import 'package:multitasking/app/router/path_router.dart';
import 'package:multitasking/presentation/pages/index.dart';

class AppRouter {
  const AppRouter._();
  static Route generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case PathRouter.splash:
        return _buildPageRoute(SplashPage(), settings);
      case PathRouter.login:
        return _buildPageRouteAnimated(LoginPage(), settings);
      case PathRouter.register:
        return slideFromBottomRoute(RegisterPage(), settings);
      case PathRouter.home:
        return _buildPageRoute(HomePage(), settings);
      default:
        return _buildPageRoute(
          const Scaffold(body: Center(child: Text('No route defined'))),
          settings,
        );
    }
  }

  static MaterialPageRoute _buildPageRoute(
    Widget page,
    RouteSettings? settings,
  ) {
    return MaterialPageRoute(settings: settings, builder: (context) => page);
  }

  static MaterialPageRoute _buildPageRouteAnimated(
    Widget page,
    RouteSettings? settings,
  ) {
    return MaterialPageRoute(settings: settings, builder: (context) => page);
  }

  // fade transition
  PageRouteBuilder fadeTransitionBuilder({required Widget child}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final opacity = animation.drive(Tween<double>(begin: 0, end: 1));

        return FadeTransition(opacity: opacity, child: child);
      },
    );
  }

  //  Rotation Transition

  PageRouteBuilder rotationTransitionBuilder({required Widget child}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final rotation = animation.drive(Tween<double>(begin: 0, end: 1));

        return RotationTransition(turns: rotation, child: child);
      },
    );
  }

  static PageRouteBuilder slideFromBottomRoute(
    Widget page,
    RouteSettings? settings,
  ) {
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Hiệu ứng khi push
        final slideIn = Tween<Offset>(
          begin: const Offset(0, 1), // từ dưới màn hình
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeOutCubic)).animate(animation);

        // Hiệu ứng khi pop (back)
        final slideOut =
            Tween<Offset>(begin: Offset.zero, end: const Offset(0, 1))
                .chain(CurveTween(curve: Curves.easeInCubic))
                .animate(secondaryAnimation);

        return SlideTransition(
          position: slideIn,
          child: SlideTransition(position: slideOut, child: child),
        );
      },
    );
  }
}
