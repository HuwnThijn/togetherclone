import 'package:flutter/material.dart';
import 'package:flutter_dynamic_icon_plus/flutter_dynamic_icon_plus.dart';
import 'package:intl/intl.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/config.dart';
import 'package:lovejourney/cores/extentions/messagingservice.dart';
import 'package:lovejourney/cores/models/loveday_model.dart';
import 'package:lovejourney/cores/routes/routes.dart';
import 'package:lovejourney/cores/servicelocator/service_locator.dart';
import 'package:lovejourney/cores/shared.dart';
import 'package:lovejourney/cores/store/share_prefer.dart';
import 'package:lovejourney/cores/ultils.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';
import 'package:lovejourney/pages/bottomsheets/changed_choose_bottomsheet.dart';
import 'package:lovejourney/pages/bottomsheets/changed_icon_app_bottomsheet.dart';
import 'package:lovejourney/pages/bottomsheets/changed_language_bottomsheet.dart';
import 'package:lovejourney/pages/bottomsheets/changed_theme_bottomsheet.dart';
import 'package:lovejourney/pages/lock_app/lock_app_page.dart';
import 'package:lovejourney/pages/settings/widgets/button_setting_widget.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  late LoveDayModel? loveData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loveData = null;
    getLoveData();
  }

  void getLoveData() async {
    loveData = await serviceLocator<SharePrefer>().getLoveday();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 10, bottom: 7),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Configs.commonRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.settings,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.color
                    ?.withValues(alpha: .3)),
          ),
          ButtonSettingWidget(
            title: context.l10n.setTheAnniversarystartdate,
            child: loveData != null
                ? Text(
                    DateFormat('dd-MM-yyyy').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            loveData!.loveday ?? 0)),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.color
                            ?.withValues(alpha: .5)),
                  )
                : null,
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => ChangedChooseBottomsheet(
                        title: 'Start date',
                        initialDate: DateTime.fromMillisecondsSinceEpoch(
                            loveData!.loveday ?? 0),
                      )).then((value)  {
                        if(value != null && value is DateTime)  {
                          serviceLocator<SharePrefer>()
                              .saveLoveDay(LoveDayModel(loveday: value.millisecondsSinceEpoch))
                              .then((_) async {
                            getLoveData();
                          loveData= await  serviceLocator<SharePrefer>().getLoveday();
                          setState(() {
                            
                          });
                          });
                        }
                      
                      }
                      
                      ,);
            },
          ),
          ButtonSettingWidget(
            title: context.l10n.changeWallpaper,
            onPressed: () => Navigator.pushNamed(context, Routes.wallpaperPage),
          ),
          ButtonSettingWidget(
            title: context.l10n.changeTheme,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.accentDark),
            ),
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => ChangedThemeBottomsheet()).then(
                (value) {
                  if (value is Color) {
                    serviceLocator<SharePrefer>().saveMainColor(value).then(
                      (_) {
                        AppColors.setMainColor(value);
                        serviceLocator<MessagingService>().send(
                            channel: MessageChannel.themeChanged,
                            parameter: '');
                      },
                    );
                  }
                },
              );
            },
          ),
          ButtonSettingWidget(
            title: context.l10n.changeIconApp,
            onPressed: () => showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => ChangedIconAppBottomsheet()).then(
              (value) {
                if (value is String && value.isNotEmpty) {
                  Shared.instance.iconApp = Configs.listIcon
                      .firstWhere((element) => element.id == value);
                  applyIconChanged(Shared.instance.iconApp);
                }
              },
            ),
          ),
          ButtonSettingWidget(
            title: context.l10n.language,
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) => ChangedLanguageBottomsheet()).then(
                (value) {
                  if (value is String && value.isNotEmpty) {
                    serviceLocator<SharePrefer>().saveLanguage(value).then(
                      (_) {
                        Shared.instance.languageCode = Locale(value);
                        serviceLocator<MessagingService>().send(
                            channel: MessageChannel.languageChanged,
                            parameter: '');
                      },
                    );
                  }
                },
              );
            },
          ),
          ButtonSettingWidget(
            title: context.l10n.usePasswordLock,
            isLine: false,
            icon: AssetsClass.images.imageCrown.image(width: 20),
            onPressed: () =>
                Navigator.push(context, createRouter(LockAppPage())),
          ),
        ],
      ),
    );
  }
}
