import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multitasking/app/theme/app_colors.dart';
import 'package:multitasking/presentation/pages/splash/components/index.dart';
import 'package:multitasking/presentation/pages/splash/cubit/splash_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final PageController _pageController = PageController();

  List<Widget> lsOnBoarding = [OnBoarding1(), OnBoarding2()];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit()..start(),
      child: BlocListener<SplashCubit, SplashState>(
        listenWhen: (prev, curr) => curr is SplashShowPage,
        listener: (context, state) {
          if (state is SplashShowPage) {
            if (state.animate) {
              _pageController.animateToPage(
                state.page,
                duration: const Duration(seconds: 1),
                curve: Curves.linearToEaseOut,
              );
            } 
            else {
              _pageController.jumpToPage(state.page);
            }
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.appColor,
          body: PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            controller: _pageController,
            itemCount: lsOnBoarding.length,
            itemBuilder: (context, index) {
              return lsOnBoarding[index];
            },
          ),
        ),
      ),
    );
  }
}

