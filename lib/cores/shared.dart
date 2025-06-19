import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:lovejourney/cores/extentions/messagingservice.dart';
import 'package:lovejourney/cores/models/icon_app_model.dart';
import 'package:lovejourney/cores/servicelocator/service_locator.dart';
import 'package:lovejourney/cores/store/share_prefer.dart';
import 'package:lovejourney/gen/assets.gen.dart';

class Shared {
  static final Shared _instance = Shared();

  static Shared get instance => _instance;
  final brightness =
      WidgetsBinding.instance.platformDispatcher.platformBrightness;

  late final bool _isChooseFinalLanguage;

  final startDefraul = 100;

  late String _numberSeparatorFormat;

  bool get isChooseFinalLanguage => _isChooseFinalLanguage;

  String get numberSeparatorFormat => _numberSeparatorFormat;

  final defaultNumberSeparatorFormat = '#,###';

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  late PackageInfo _packageInfo;

  PackageInfo get packageInfo => _packageInfo;

  String _fontFamily = 'Inter';

  String get fontFamily => _fontFamily;

  set fontFamily(String fontFamily) => _fontFamily = fontFamily;

  Locale languageCode = Locale('en');

  double get startusBarHeight => MediaQuery.of(context).padding.top;

  late IconAppModel _iconApp;

  IconAppModel get iconApp => _iconApp;

  bool _isMainColor = false;

  bool get isMainColor => _isMainColor;

  set isMainColor(bool isMainColor) => _isMainColor = isMainColor;

  set iconApp(IconAppModel iconApp) => _iconApp = iconApp;

  late BuildContext cacheContext;

  void setContext(BuildContext context) {
    cacheContext = context;
  }

  void setNumberSeparatorFormat(String numberSeparatorFormat) {
    _numberSeparatorFormat = numberSeparatorFormat;
  }

  void setIsChooseFinalLanguage(bool isChooseFinalLanguage) {
    _isChooseFinalLanguage = isChooseFinalLanguage;
  }

  void setPackageInfo(PackageInfo packageInfo) {
    _packageInfo = packageInfo;
  }

  void setLanguage(
    String codeLanguage, {
    bool save = true,
  }) {
    languageCode = Locale(codeLanguage);
    if (save) {
      serviceLocator<SharePrefer>().saveLanguage(codeLanguage);
      serviceLocator<MessagingService>().send(
          channel: MessageChannel.languageChanged, parameter: codeLanguage);
    }
  }

  void setThemeMode(ThemeMode themeMode, {bool save = true}) {
    _themeMode = themeMode;
    if (save) {
      // MainController.instance.changeThemeMode();
    }
  }

  BuildContext get context => cacheContext;
  bool get isDarkMode => brightness == Brightness.dark;
  bool get isLightMode => brightness == Brightness.light;

  ThemeData get theme => Theme.of(context);

  // TextTheme get textTheme => theme.textTheme;

  double get heightStatusBar => MediaQuery.of(context).padding.top;

  final Map<String, Map<String, String>> listLanguage = {
    'en': {
      'name': 'English',
      'flag': AssetsClass.images.imageFlagEnglish.path,
      'dialCode': '+1',
    },
    'vi': {
      'name': 'Tiếng Việt',
      'flag': AssetsClass.images.imageFlagVietnam.path,
      'dialCode': '+84',
    },
    'in': {
      'name': 'Bhārat Gaṇarājya',
      'flag': AssetsClass.images.imageFlagIndia.path,
      'dialCode': '+91',
    },
    'zh': {
      'name': '简体中文',
      'flag': AssetsClass.images.imageFlagChina.path,
      'dialCode': '+86',
    },
  };
}
