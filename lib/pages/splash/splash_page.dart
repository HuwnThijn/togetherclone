import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/config.dart';
import 'package:lovejourney/cores/models/loveday_model.dart';
import 'package:lovejourney/cores/shared.dart';
import 'package:lovejourney/cores/ultils.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';
import 'package:lovejourney/pages/home_page.dart';
import 'package:lovejourney/pages/language/language_page.dart';
import 'package:lovejourney/pages/set_date/set_date_page.dart';
import 'package:lovejourney/pages/set_up_photo/set_up_photo_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key, required this.data});

  final LoveDayModel data;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Timer(Duration(seconds: 1), () {
        Navigator.push(context, createRouter(setMainPage()));
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget setMainPage() {
    if (widget.data.loveday != null && widget.data.isAddPhoto) {
      return HomePage(key: Configs.mainKey);
    } else if (!widget.data.isLanguage) {
      return LanguagePage();
    } else if (widget.data.loveday == null) {
      return SetDatePage();
    } else if (!widget.data.isAddPhoto) {
      return SetUpPhotoPage();
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    Shared.instance.setContext(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsClass.images.imageSplash.path),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Shared.instance.isMainColor
            ? AppColors.accentDark.withValues(alpha: .0)
            : Configs.listColorTheme.first.withValues(alpha: .0),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Center(child: AssetsClass.images.imageIconApp.image(width: 87)),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            Shared.instance.packageInfo.appName,
            style: Shared.instance.theme.textTheme.titleLarge?.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
        ),    
        const Spacer(),   
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Text(
            context.l10n.celebratingEverylovemilestone,
            style: Shared.instance.theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
