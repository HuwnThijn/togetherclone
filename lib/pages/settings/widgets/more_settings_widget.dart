import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/pages/settings/widgets/button_setting_widget2.dart';
import 'package:share_plus/share_plus.dart';
import 'package:lovejourney/cores/config.dart';
import 'package:lovejourney/cores/shared.dart';
import 'package:lovejourney/cores/ultils.dart';
import 'package:lovejourney/l10n/l10n.dart';
import 'package:lovejourney/pages/privacypolicy/privacypolicy_page.dart';
import 'package:lovejourney/pages/settings/widgets/button_setting_widget.dart';
import 'package:lovejourney/pages/temr/temrs_of_condition_page.dart';

class MoreSettingsWidget extends StatelessWidget {
  MoreSettingsWidget({super.key});

  final InAppReview inAppReview = InAppReview.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Configs.commonRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.settings.toUpperCase(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.color
                    ?.withValues(alpha: .3)),
          ),
          ButtonSettingWidget2(
            icon: AssetsClass.icons.share.svg(
              width: 20,
              color: AppColors.accentDark,
            ),
            title: context.l10n.shareWithApp,
            onPressed: () {
              if (Platform.isAndroid) {
                Share.share(
                  'https://play.google.com/store/apps/details?id=${Shared.instance.packageInfo.packageName}',
                );
              } else {
                Share.share(
                  'https://apps.apple.com/us/app/${Shared.instance.packageInfo.appName}/id${Shared.instance.packageInfo.appName}',
                );
              }
            },
          ),
          ButtonSettingWidget2(
            title: context.l10n.reviewApp,
            icon: AssetsClass.icons.star.svg(
              width: 20,
              color: AppColors.accentDark,
            ),
            onPressed: () async {
              if (await inAppReview.isAvailable()) {
                inAppReview.requestReview();
              }
            },
          ),
          ButtonSettingWidget2(
            icon: AssetsClass.icons.contact.svg(
              width: 20,
              color: AppColors.accentDark,
            ),
            title: context.l10n.contactUs,
            onPressed: () => launchEmail(email: Configs.emailContact),
          ),
          ButtonSettingWidget2(
            title: context.l10n.termsOfService,
            icon: AssetsClass.icons.term.svg(
              width: 20,
              color: AppColors.accentDark,
            ),
            onPressed: () {
              Navigator.push(context, createRouter(TermsOfConditionsPage()));
            },
          ),
          ButtonSettingWidget2(
            title: context.l10n.privacyPolicy,
            icon: AssetsClass.icons.privacy.svg(
              width: 20,
              color: AppColors.accentDark,
            ),
            onPressed: () {
              Navigator.push(context, createRouter(PrivacyPolicyPage()));
            },
          ),
          ButtonSettingWidget2(
            title: context.l10n.versionApp,
            isLine: false,
            child: Row(
              spacing: 5,
              children: [
                Text(
                  'Ver',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.color
                            ?.withValues(alpha: .5),
                      ),
                ),
                Text(
                  Shared.instance.packageInfo.version,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.color
                            ?.withValues(alpha: .5),
                      ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
