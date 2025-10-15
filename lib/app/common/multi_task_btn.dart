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
    return ElevatedButton(
      onPressed: (isLoading || !isEnabled) ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.appColor,
        disabledBackgroundColor: AppColors.appColor.withAlpha(100),
        minimumSize: Size(double.infinity, AppDimensions.buttonHeightL),
        shape: RoundedRectangleBorder(
          borderRadius: AppDimensions.borderRadiusM,
        ),
      ),
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (iconLeft != null) iconLeft!,
                Text(text, style: AppTextStyles.buttonText),
                if (iconRight != null) iconRight!,
              ],
            ),
    );
  }
}
