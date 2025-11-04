import 'package:flutter/material.dart';
import 'package:multitasking/app/assets/images.dart';
import 'package:multitasking/app/common/index.dart';
import 'package:multitasking/app/extensions/build_context_extension.dart';
import 'package:multitasking/app/router/path_router.dart';
import 'package:multitasking/app/theme/app_colors.dart';
import 'package:multitasking/app/theme/app_dimensions.dart';
import 'package:multitasking/app/theme/app_text_styles.dart';
import 'package:multitasking/presentation/pages/splash/components/popup_menu_translate.dart';

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
          ),
          const Spacer(),
          Center(
            child: SizedBox(
              width: 261,
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
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        PathRouter.editor,
                      );
                    },
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
