import 'package:flutter/cupertino.dart';
import 'package:lovejourney/cores/config.dart';
import 'package:lovejourney/cores/routes/routes.dart';
import 'package:lovejourney/pages/gender/changed_gender_page.dart';
import 'package:lovejourney/pages/home_page.dart';
import 'package:lovejourney/pages/wallpaper/wallpaper_page.dart';

class NavigatorRoutes {
  NavigatorRoutes._();
  static dynamic getRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homePage:
        {
          final page = HomePage(
            key: Configs.mainKey,
          );
          return CupertinoPageRoute(
              builder: ((context) => page),
              settings: const RouteSettings(name: Routes.homePage));
        }
      // case Routes.newAnniversaryPage:
      //   {
      //     final page = NewAnniversaryPage(
      //       idAnniver:
      //           settings.arguments != null ? settings.arguments.toString() : '',
      //     );
      //     return CupertinoPageRoute(
      //         builder: ((context) => page),
      //         settings: const RouteSettings(name: Routes.newAnniversaryPage));
      //   }
      // case Routes.femaleInfoPage:
      //   {
      //     const page = FemaleInfoPage();
      //     return CupertinoPageRoute(
      //         builder: ((context) => page),
      //         settings: const RouteSettings(name: Routes.femaleInfoPage));
      //   }
      // case Routes.maleInfoPage:
      //   {
      //     const page = MaleInfoPage();
      //     return CupertinoPageRoute(
      //         builder: ((context) => page),
      //         settings: const RouteSettings(name: Routes.maleInfoPage));
      //   }
      case Routes.genderPage:
        {
          const page = ChangedGenderPage();
          return CupertinoPageRoute(
              builder: ((context) => page),
              settings: const RouteSettings(name: Routes.genderPage));
        }
      // case Routes.loveDayPage:
      //   {
      //     const page = LoveDayPage();
      //     return CupertinoPageRoute(
      //         builder: ((context) => page),
      //         settings: const RouteSettings(name: Routes.loveDayPage));
      //   }
      case Routes.wallpaperPage:
        {
          const page = WallpaperPage();
          return CupertinoPageRoute(
              builder: ((context) => page),
              settings: const RouteSettings(name: Routes.wallpaperPage));
        }
      // case Routes.framePage:
      //   {
      //     const page = FramePage();
      //     return CupertinoPageRoute(
      //         builder: ((context) => page),
      //         settings: const RouteSettings(name: Routes.framePage));
      //   }
      // case Routes.reviewPage:
      //   {
      //     const page = ReviewPage();
      //     return CupertinoPageRoute(
      //         builder: ((context) => page),
      //         settings: const RouteSettings(name: Routes.reviewPage));
      //   }
    }
    return null;
  }
}
