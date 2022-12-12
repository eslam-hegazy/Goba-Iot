import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

Future<void> changeLanguage(context) async {
  return await translator.setNewLanguage(
    context,
    newLanguage: translator.currentLanguage == 'ar' ? 'en' : 'ar',
    remember: true,
    restart: true,
  );
}

Future<void> changeTheme(context) async {
  bool isDarkModeOn = Theme.of(context).brightness == Brightness.dark;
  if (isDarkModeOn) {
    return AdaptiveTheme.of(context).setLight();
  } else {
    return AdaptiveTheme.of(context).setDark();
  }
}

bool getStatusTheme(context) {
  return Theme.of(context).brightness == Brightness.dark;
}
