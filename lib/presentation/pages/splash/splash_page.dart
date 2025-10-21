import 'package:flutter/material.dart';
import 'package:multitasking/app/assets/images.dart';
import 'package:multitasking/app/common/index.dart';
import 'package:multitasking/app/extensions/build_context_extension.dart';
import 'package:multitasking/app/theme/app_colors.dart';
import 'package:multitasking/app/theme/app_dimensions.dart';
import 'package:multitasking/app/theme/app_text_styles.dart';
import 'package:multitasking/presentation/pages/splash/components/popup_menu_translate.dart';

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
    Future.delayed(const Duration(seconds: 3), _goNext);
    super.initState();
  }

  _goNext() {
    _pageController.animateToPage(
      1,
      duration: Duration(seconds: 1),
      curve: Curves.linearToEaseOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}

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
                //height: context.height / 2,
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

class OnBoarding2 extends StatelessWidget {
  const OnBoarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImagePath.bgSplash),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: context.pT),
          Container(
            margin: AppDimensions.paddingHorizontalM,
            padding: AppDimensions.paddingHorizontalM,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: context.borderRadiusM,
            ),
            child: PopupMenuTranslate(),
            // Row(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     Text('english'),
            //     Icon(Icons.keyboard_arrow_down_outlined)
            //   ],
            // ),
          ),
          const Spacer(),
          Center(
            child: SizedBox(
              width: 261,
              //height: context.height / 2,
              child: Image.asset(
                fit: BoxFit.fill,
                ImagePath.logo,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          const Spacer(),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppDimensions.radiusXL),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.backgroundDark.withAlpha(15),
                  offset: const Offset(0, -4),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Padding(
              padding: AppDimensions.paddingAllXL,
              child: Wrap(
                children: [
                  Text(
                    context.l10n.txt_ready_to_explore_beyond_boundaries,
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: AppColors.appColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: context.width / 3),
                  MultiTaskBtn(
                    iconRight: Icon(
                      Icons.connecting_airports,
                      color: AppColors.background,
                      size: AppDimensions.iconM,
                    ),
                    text: context.l10n.txt_your_journey_starts_here,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
