import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/config.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';

class MaintenancePopup extends StatelessWidget {
  const MaintenancePopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(Configs.commonPaddingPopup),
          margin: EdgeInsets.symmetric(
            horizontal: Configs.commonPaddingPopup,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Configs.commonRadius),
          ),
          child: Column(
            spacing: 10,
            children: [
              AssetsClass.images.undrawMaintenanceRjtm.image(width: 277),
              Text(
                context.l10n.theAppisundermaintenance,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.displaySmall?.color,
                    ),
              ),
              Text(
                context.l10n.weAreupgradingtoserveyoubetterPleasecomebacklater,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).textTheme.displaySmall?.color,
                    ),
              ),

              TextButton(
                onPressed: () => FlutterExitApp.exitApp(iosForceExit: true),
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.accentDark,
                  minimumSize: Size.fromHeight(
                    Configs.commonHeightButton,
                  ),
                ),
                child: Text(
                  context.l10n.closeApp,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),

              // Text(
              //   context.l10n.systemMaintenancetoserveyoubetterSub,
              //   textAlign: TextAlign.center,
              //   style: Theme.of(context).textTheme.titleSmall?.copyWith(
              //     fontWeight: FontWeight.w400,
              //     color: Theme.of(
              //       context,
              //     ).textTheme.titleSmall?.color?.withValues(alpha: .65),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
