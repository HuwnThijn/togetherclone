import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/config.dart';
import 'package:lovejourney/cores/extentions/messagingservice.dart';
import 'package:lovejourney/cores/models/loveday_model.dart';
import 'package:lovejourney/cores/routes/navigator_routes.dart';
import 'package:lovejourney/cores/servicelocator/service_locator.dart';
import 'package:lovejourney/cores/shared.dart';
import 'package:lovejourney/cores/store/share_prefer.dart';
import 'package:lovejourney/cores/themes_app.dart';
import 'package:lovejourney/l10n/arb/app_localizations.dart';
// import 'package:lovejourney/pages/setting_dating_page.dart';
import 'package:lovejourney/pages/splash/splash_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpServiceLocator().then(
    (value) async {
      final data = await serviceLocator<SharePrefer>().getLoveday();
      Shared.instance.setPackageInfo(await PackageInfo.fromPlatform());
      Shared.instance.setLanguage(serviceLocator<SharePrefer>().getLanguage());
      AppColors.setMainColor(serviceLocator<SharePrefer>().getMainColor());
      Shared.instance.iconApp = serviceLocator<SharePrefer>().getIconApp();
      Shared.instance.isMainColor =
          serviceLocator<SharePrefer>().getMainColorString().isNotEmpty;
      runApp(MyApp(
        data: data,
      ));
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.data});

  final LoveDayModel data;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    serviceLocator<MessagingService>().subscribe(
      this,
      channel: MessageChannel.languageChanged,
      action: (val) {
        if (val is String) {
          setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          Shared.instance.setContext(context);
          return MaterialApp(
            // key: Configs.mainKey,
            title: '',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.system,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Shared.instance.languageCode,
            home: SplashPage(
              data: widget.data,
            ),
            onGenerateRoute: (settings) => NavigatorRoutes.getRoutes(settings),
          );
        },
      ),
    );
  }
}
