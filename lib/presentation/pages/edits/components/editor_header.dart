import 'package:flutter/material.dart';
import 'package:multitasking/app/extensions/build_context_extension.dart';
import 'package:multitasking/app/theme/app_colors.dart';
import 'package:multitasking/app/theme/app_text_styles.dart';

class EditorHeader extends StatelessWidget {
  const EditorHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingAllL,
      child: Container(
        decoration: BoxDecoration(borderRadius: context.borderRadiusS),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: context.paddingAllS,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariantDark,
                borderRadius: context.borderRadiusS,
              ),
              child: Text(
                "Hủy",
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.background,
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
