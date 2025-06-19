import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/config.dart';
import 'package:lovejourney/cores/shared.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';

class AlterNewversionPopup extends StatelessWidget {
  const AlterNewversionPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(Configs.commonPaddingPopup),
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(
              Configs.commonRadiusPopup,
            ),
          ),
          child: Column(
            spacing: 10,
            children: [
              AssetsClass.images.imageIconApp.image(width: 87),
              Text(
                context.l10n.newVersionAvailable,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.accentDark,
                    ),
              ),
              HtmlWidget(
                '''<div  ">
                            <p ><span style="background-color: red; color: white; padding: 2px 6px; border-radius: 4px;">NEW</span> New, more beautiful interface</p>
                            <p  >🚀 Faster performance, smoother</p>
                            <p>🐞 Bug fixes & better security</p> </div>''',
                textStyle: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(
                        context,
                      ).textTheme.titleSmall?.color?.withValues(alpha: .65),
                    ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.accentDark,
                  minimumSize: Size.fromHeight(
                    Configs.commonHeightButton,
                  ),
                ),
                child: Text(
                  context.l10n.updateNewVersion,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  backgroundColor: Shared.instance.isDarkMode
                      ? AppColors.buttonGrayDark
                      : AppColors.buttonGrayLight,
                  minimumSize: Size.fromHeight(
                    Configs.commonHeightButton,
                  ),
                ),
                child: Text(
                  context.l10n.remindMeLater,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.primaryDark,
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
