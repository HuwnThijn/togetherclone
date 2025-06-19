import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/config.dart';
import 'package:lovejourney/cores/extentions/messagingservice.dart';
import 'package:lovejourney/cores/purchase/in_app_purchase.dart';
import 'package:lovejourney/cores/servicelocator/service_locator.dart';
import 'package:lovejourney/cores/shared.dart';
import 'package:lovejourney/cores/store/share_prefer.dart';
import 'package:lovejourney/cores/ultils.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';
import 'package:lovejourney/pages/bottomsheets/comfirm_pass_bottomsheet.dart';
import 'package:lovejourney/pages/homeviews/countlove_view.dart';
import 'package:lovejourney/pages/love_story/love_story_page.dart';
import 'package:lovejourney/pages/settings/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String backGround = '';

  final store = serviceLocator<SharePrefer>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (store.getPassLockApp().isNotEmpty) {
        showModalBottomSheet(
            context: context, builder: (context) => ComfirmPassBottomsheet());
      }
    });

    serviceLocator<MessagingService>().subscribe(
      this,
      channel: MessageChannel.themeChanged,
      action: (val) => setState(() {}),
    );

    LocalInAppPurchase.onInAppSuccess = (val) {
      final item = LocalInAppPurchase.listProduct
          .firstWhere((element) => element.id == val.productID);

      int userStart = serviceLocator<SharePrefer>().getStarApp();
      userStart += item.coin;
      serviceLocator<SharePrefer>().saveStarApp(userStart).then(
        (value) {
          serviceLocator<MessagingService>()
              .send(channel: MessageChannel.startUserChanged, parameter: '');
        },
      );
    };
  }

  @override
  void dispose() {
    super.dispose();
    serviceLocator<MessagingService>()
        .unsubscribe(this, channel: MessageChannel.themeChanged);
  }

  @override
  Widget build(BuildContext context) {
    backGround = store.getBackground();
    return DecoratedBox(
      decoration: BoxDecoration(
          color: backGround.isEmpty
              ? Theme.of(context).scaffoldBackgroundColor
              : null,
          image: backGround.isNotEmpty
              ? DecorationImage(
                  image: MemoryImage(base64Decode(backGround)),
                  fit: BoxFit.cover)
              : DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(AssetsClass.images.imageHomeDefault.path))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: Configs.keyHomePage,
        // appBar: AppBar(
        //   backgroundColor: AppColors.accentDark.withValues(alpha: .3),
        //   leading: IconButton(
        //       onPressed: () =>
        //           Navigator.push(context, createRouter(LoveStoryPage())),
        //       icon: AssetsClass.icons.calendarHeart.svg(
        //           width: 24,
        //           color: Shared.instance.isMainColor
        //               ? AppColors.accentDark
        //               : Colors.white)),
        //   title: Text(
        //     Shared.instance.packageInfo.appName,
        //     style: Theme.of(context).textTheme.titleMedium?.copyWith(
        //         color: Shared.instance.isMainColor
        //             ? AppColors.accentDark
        //             : Colors.white,
        //         fontWeight: FontWeight.bold),
        //   ),
        //   actions: [
        //     IconButton(
        //         onPressed: () =>
        //             Navigator.push(context, createRouter(SettingsPage())),
        //         icon: AssetsClass.icons.settings.svg(
        //             width: 24,
        //             color: Shared.instance.isMainColor
        //                 ? AppColors.accentDark
        //                 : Colors.white)),
        //   ],
        // ),
        body: _buildBody(),
        resizeToAvoidBottomInset: false,
      ),
    );
  }

  Widget _buildBody() {
    return ColoredBox(
      color: Shared.instance.isMainColor
          ? AppColors.accentDark.withValues(alpha: .3)
          : Colors.black26,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: Shared.instance.startusBarHeight,
                left: 10,
                right: 10,
                bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'LoveJourney',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Shared.instance.isMainColor
                              ? AppColors.accentDark
                              : Colors.white,
                        ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Fluttertoast.showToast(
                          msg: context.l10n.functionunderdevelopment);
                    },
                    icon: AssetsClass.images.imageBestSeller.image(width: 24)),
                IconButton(
                    onPressed: () =>
                        Navigator.push(context, createRouter(LoveStoryPage())),
                    icon: AssetsClass.icons.calendarHeart.svg(
                        width: 24,
                        color: Shared.instance.isMainColor
                            ? AppColors.accentDark
                            : Colors.white)),
                IconButton(
                  onPressed: () =>
                      Navigator.push(context, createRouter(SettingsPage())),
                  icon: AssetsClass.icons.settings.svg(
                      width: 24,
                      color: Shared.instance.isMainColor
                          ? AppColors.accentDark
                          : Colors.white),
                ),
              ],
            ),
          ),
          Expanded(child: CountLoveView()),
        ],
      ),
    );
  }
}
