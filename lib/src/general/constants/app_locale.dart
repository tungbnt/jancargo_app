import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/app_strings/app_string_JP.dart';
import 'package:jancargo_app/src/general/app_strings/app_string_VN.dart';
import 'package:jancargo_app/src/general/app_strings/app_strings_EN.dart';

import '../app_strings/app_strings.dart';

enum AppLocaleEnum {
  JP('ja'),
  VN('vi'),
  EN('en');

  const AppLocaleEnum(this.languageCode);
  final String languageCode;

  Locale getLocale() {
    switch (this) {
      case AppLocaleEnum.JP:
        return const Locale('ja', '');
      case AppLocaleEnum.VN:
        return const Locale('vi', '');
      case AppLocaleEnum.EN:
        return const Locale('en', '');
    }
  }

  AppStrings getAppString() {
    switch (this) {
      case AppLocaleEnum.JP:
        return AppStringsJP();
      case AppLocaleEnum.VN:
        return AppStringsVN();
      case AppLocaleEnum.EN:
        return AppStringsEN();
    }
  }

  String getLanguageName() {
    switch (this) {
      case AppLocaleEnum.JP:
        return '日本語';
      case AppLocaleEnum.VN:
        return 'Tiếng Việt';
      case AppLocaleEnum.EN:
        return 'English';
    }
  }
}
