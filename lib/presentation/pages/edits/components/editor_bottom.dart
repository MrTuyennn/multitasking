import 'package:flutter/material.dart';
import 'package:multitasking/app/extensions/build_context_extension.dart';
import 'package:multitasking/app/theme/app_colors.dart';
import 'package:multitasking/app/theme/app_text_styles.dart';

class EditorBottom extends StatelessWidget {
  const EditorBottom({super.key, required this.rotate});

  final Function() rotate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingAllL,
      child: Container(
        decoration: BoxDecoration(borderRadius: context.borderRadiusS),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
              onTap: rotate,
              child: Container(
                padding: context.paddingAllS,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariantDark,
                  borderRadius: context.borderRadiusS,
                ),
                child: Text(
                  "Rotate",
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.background,
                  ),
                ),
              ),
            ),
            Container(
              padding: context.paddingAllS,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariantDark,
                borderRadius: context.borderRadiusS,
              ),
              child: Text(
                "Hoàn tất",
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.background,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
