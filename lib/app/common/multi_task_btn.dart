import 'package:flutter/material.dart';
import 'package:multitasking/app/theme/app_colors.dart';
import 'package:multitasking/app/theme/app_dimensions.dart';
import 'package:multitasking/app/theme/app_text_styles.dart';

class MultiTaskBtn extends StatelessWidget {
  const MultiTaskBtn({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.iconLeft,
    this.iconRight,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final Widget? iconLeft;
  final Widget? iconRight;

  @override
  Widget build(BuildContext context) {
    final bool disabled = isLoading || !isEnabled;

    return ElevatedButton(
      onPressed: disabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.appColor,
        foregroundColor: Colors.white,
        disabledBackgroundColor: AppColors.appColor.withAlpha(100),
        disabledForegroundColor: Colors.white.withAlpha(180),
        minimumSize: Size.fromHeight(AppDimensions.buttonHeightL),
        shape: RoundedRectangleBorder(
          borderRadius: AppDimensions.borderRadiusM,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: isLoading ? 0.0 : 1.0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (iconLeft != null) ...[iconLeft!, const SizedBox(width: 8)],
                Flexible(
                  child: Text(
                    text,
                    style: AppTextStyles.buttonText,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (iconRight != null) ...[
                  const SizedBox(width: 8),
                  iconRight!,
                ],
              ],
            ),
          ),

          if (isLoading)
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
