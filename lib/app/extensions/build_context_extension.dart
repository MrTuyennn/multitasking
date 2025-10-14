import 'package:flutter/material.dart';
import 'package:multitasking/app/l10n/generated/app_localizations.dart';

/// Extension to make localization easier to access from BuildContext
extension BuildContextExtensions on BuildContext {
  // ---- L10n ----
  /// Get AppLocalizations instance
  AppLocalizations get l10n => AppLocalizations.of(this)!;
  /// Get current locale
  Locale get locale => Localizations.localeOf(this);
  /// Get current language code
  String get languageCode => locale.languageCode;

  // ---- Theme ----
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
  bool get isDarkMode => theme.brightness == Brightness.dark;

  // ---- MediaQuery / Layout ----
  MediaQueryData get mq => MediaQuery.of(this);
  Size get size => MediaQuery.sizeOf(this); 
  double get width => size.width;
  double get height => size.height;
  EdgeInsets get padding => mq.padding;         
  EdgeInsets get viewPadding => mq.viewPadding; 
  EdgeInsets get viewInsets => mq.viewInsets;  
  bool get keyboardVisible => viewInsets.bottom > 0;
  Orientation get orientation => mq.orientation;
}
