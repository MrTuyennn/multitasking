
import 'package:flutter/material.dart';
import 'package:multitasking/app/l10n/generated/app_localizations.dart';


/// Extension to make localization easier to access from BuildContext
extension BuildContextExtensions on BuildContext {
  /// Get AppLocalizations instance
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  /// Get current locale
  Locale get locale => Localizations.localeOf(this);

  /// Get current language code
  String get languageCode => locale.languageCode;
}
