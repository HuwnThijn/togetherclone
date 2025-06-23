import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/config.dart';
import 'package:lovejourney/cores/enumlist.dart';
import 'package:lovejourney/cores/models/loveday_model.dart';
import 'package:lovejourney/cores/routes/routes.dart';
import 'package:lovejourney/cores/servicelocator/service_locator.dart';
import 'package:lovejourney/cores/store/share_prefer.dart';
import 'package:lovejourney/cores/ultils.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';
import 'package:lovejourney/pages/bottomsheets/changed_bod_bottomsheet.dart';
import 'package:lovejourney/pages/bottomsheets/changed_shape_avatar_bottomsheet.dart';
import 'package:lovejourney/pages/bottomsheets/choose_option_camera_bottomsheet.dart';
import 'package:lovejourney/pages/popups/changed_name_popup.dart';
import 'package:lovejourney/pages/settings/widgets/button_setting_widget2.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  late LoveDayModel? loveData;
  String? gender;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loveData = null;
    getLoveData();
  }

  void getLoveData() async {
    loveData = await serviceLocator<SharePrefer>().getLoveday();
    gender = loveData?.gender;
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
            context.l10n.general.toUpperCase(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.color
                    ?.withValues(alpha: .3)),
          ),
          ButtonSettingWidget2(
            title: context.l10n.yourGender,
            icon: AssetsClass.icons.gender.svg(
              width: 20,
              color: AppColors.accentDark,
            ),
            child: loveData != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      gender?.toUpperCase() ?? loveData!.gender.toUpperCase(),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.color
                              ?.withValues(alpha: .5)),
                    ),
                  )
                : null,
            onPressed: () =>
                Navigator.pushNamed(context, Routes.genderPage).then((value) {
              if (value is String && value.isNotEmpty) {
                gender = value;
              }
            }),
          ),
          ButtonSettingWidget2(
            title: context.l10n.startDating,
            icon: AssetsClass.icons.calenderClock.svg(
              width: 20,
              color: AppColors.accentDark,
            ),
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
              Navigator.pushNamed(context, Routes.startDatingPage).then((value) {
                if (value != null && value is DateTime) {
                  loveData?.loveday = value.millisecondsSinceEpoch;
                }
              });
            },
          ),
          ButtonSettingWidget2(
            title: '${context.l10n.username} 1',
            icon: AssetsClass.icons.circleUser.svg(
              width: 20,
              color: AppColors.accentDark,
            ),
            onPressed: () {
              Navigator.pushNamed(context, Routes.maleInfoPage);
            },
          ),
          ButtonSettingWidget2(
            title: '${context.l10n.username} 2',
            icon: AssetsClass.icons.circleUser.svg(
              width: 20,
              color: AppColors.accentDark,
            ),
            onPressed: () {
              Navigator.pushNamed(context, Routes.femaleInfoPage);
            },
          ),
          ButtonSettingWidget2(
            title: context.l10n.frame,
            icon: AssetsClass.icons.frame.svg(
              width: 20,
              color: AppColors.accentDark,
            ),
            onPressed: () => Navigator.pushNamed(context, Routes.wallpaperPage),
          ),
          ButtonSettingWidget2(
            title: context.l10n.background,
            icon: AssetsClass.icons.picture.svg(
              width: 20,
              color: AppColors.accentDark,
            ),
            onPressed: () => Navigator.pushNamed(context, Routes.wallpaperPage),
          ),

          // ButtonSettingWidget(
          //   title: context.l10n.changeTheme,
          //   child: Container(
          //     width: 20,
          //     height: 20,
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(5),
          //         color: AppColors.accentDark),
          //   ),
          //   onPressed: () {
          //     showModalBottomSheet(
          //         backgroundColor: Colors.transparent,
          //         context: context,
          //         builder: (context) => ChangedThemeBottomsheet()).then(
          //       (value) {
          //         if (value is Color) {
          //           serviceLocator<SharePrefer>().saveMainColor(value).then(
          //             (_) {
          //               AppColors.setMainColor(value);
          //               serviceLocator<MessagingService>().send(
          //                   channel: MessageChannel.themeChanged,
          //                   parameter: '');
          //             },
          //           );
          //         }
          //       },
          //     );
          //   },
          // ),
          // ButtonSettingWidget(
          //   title: context.l10n.changeIconApp,
          //   onPressed: () => showModalBottomSheet(
          //       context: context,
          //       backgroundColor: Colors.transparent,
          //       builder: (context) => ChangedIconAppBottomsheet()).then(
          //     (value) {
          //       if (value is String && value.isNotEmpty) {
          //         Shared.instance.iconApp = Configs.listIcon
          //             .firstWhere((element) => element.id == value);
          //         applyIconChanged(Shared.instance.iconApp);
          //       }
          //     },
          //   ),
          // ),
          // ButtonSettingWidget(
          //   title: context.l10n.language,
          //   onPressed: () {
          //     showModalBottomSheet(
          //         context: context,
          //         backgroundColor: Colors.transparent,
          //         builder: (context) => ChangedLanguageBottomsheet()).then(
          //       (value) {
          //         if (value is String && value.isNotEmpty) {
          //           serviceLocator<SharePrefer>().saveLanguage(value).then(
          //             (_) {
          //               Shared.instance.languageCode = Locale(value);
          //               serviceLocator<MessagingService>().send(
          //                   channel: MessageChannel.languageChanged,
          //                   parameter: '');
          //             },
          //           );
          //         }
          //       },
          //     );
          //   },
          // ),
          // ButtonSettingWidget(
          //   title: context.l10n.usePasswordLock,
          //   isLine: false,
          //   icon: AssetsClass.images.imageCrown.image(width: 20),
          //   onPressed: () =>
          //       Navigator.push(context, createRouter(LockAppPage())),
          // ),
        ],
      ),
    );
  }

  void handleOption(int index, bool isMen) {
    switch (index) {
      case 0:
        showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => ChooseOptionCameraBottomsheet()).then(
          (value) {
            if (value is ImageSource) {
              serviceLocator<ImagePicker>()
                  .pickImage(source: value)
                  .then((value) async {
                if (value != null) {
                  if (isMen) {
                    if (loveData!.imageMen.isNotEmpty)
                      File(loveData!.imageMen).delete();
                  } else {
                    if (loveData!.imageWoman.isNotEmpty)
                      File(loveData!.imageWoman).delete();
                  }
                  serviceLocator<SharePrefer>()
                      .saveLoveDay(loveData!.copyWith(
                    imageMen: isMen
                        ? await copyImageToCache(await value.readAsBytes(),
                            name: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString())
                        : loveData!.imageMen,
                    imageWoman: isMen
                        ? loveData!.imageWoman
                        : await copyImageToCache(await value.readAsBytes(),
                            name: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString()),
                  ))
                      .then(
                    (value) {
                      getLoveData();
                    },
                  );
                }
              });
            }
          },
        );
        break;
      case 1:
        showDialog(context: context, builder: (context) => ChangedNamePopup())
            .then(
          (value) {
            if (value is String && value.isNotEmpty) {
              serviceLocator<SharePrefer>()
                  .saveLoveDay(loveData!.copyWith(
                nameMen: isMen ? value : loveData!.nameMen,
                nameWoman: isMen ? loveData!.nameWoman : value,
              ))
                  .then(
                (value) {
                  getLoveData();
                },
              );
            }
          },
        );
        break;
      case 2:
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) => ChangedBodBottomsheet()).then(
          (value) {
            if (value is DateTime) {
              serviceLocator<SharePrefer>()
                  .saveLoveDay(loveData!.copyWith(
                dobMen: isMen ? value.toString() : loveData!.nameMen,
                dobWoman: isMen ? loveData!.nameWoman : value.toString(),
              ))
                  .then(
                (value) {
                  getLoveData();
                },
              );
            }
          },
        );
        break;
      case 3:
        if (isMen) {
          if (loveData!.imageMen.isNotEmpty) File(loveData!.imageMen).delete();
        } else {
          if (loveData!.imageWoman.isNotEmpty) {
            File(loveData!.imageWoman).delete();
          }
        }
        serviceLocator<SharePrefer>()
            .saveLoveDay(loveData!.copyWith(
          imageMen: isMen ? '' : loveData!.nameMen,
          imageWoman: isMen ? loveData!.nameWoman : '',
        ))
            .then(
          (value) {
            getLoveData();
          },
        );
        break;
      case 4:
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => ChangedShapeAvatarBottomsheet(
                  assertImage: isMen
                      ? AssetsClass.images.imageMen.path
                      : AssetsClass.images.imageWoman.path,
                )).then(
          (value) {
            if (value is ShapeType) {
              serviceLocator<SharePrefer>().saveShapeType(value).then((value) {
                getLoveData();
              });
            }
          },
        );
        break;
    }
  }
}
