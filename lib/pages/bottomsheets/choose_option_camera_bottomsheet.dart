import 'package:flutter/material.dart';
import 'package:lovejourney/cores/shared.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';

class ChooseOptionCameraBottomsheet extends StatefulWidget {
  const ChooseOptionCameraBottomsheet({super.key});

  @override
  State<ChooseOptionCameraBottomsheet> createState() =>
      _ChooseOptionCameraBottomsheetState();
}

class _ChooseOptionCameraBottomsheetState
    extends State<ChooseOptionCameraBottomsheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              _buildOption(
                  AssetsClass.icons.camera.svg(
                      width: 24,
                      color: Shared.instance.isMainColor
                          ? AppColors.accentDark
                          : null),
                  title: context.l10n.camera,
                  onTap: () => Navigator.pop(context, ImageSource.camera)),
              Padding(
                padding: const EdgeInsets.only(left: 43),
                child: Divider(height: 1),
              ),
              _buildOption(
                  AssetsClass.icons.picture.svg(
                      width: 24,
                      color: Shared.instance.isMainColor
                          ? AppColors.accentDark
                          : null),
                  title: context.l10n.gallery,
                  onTap: () => Navigator.pop(context, ImageSource.gallery)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOption(Widget icon, {required String title, Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          spacing: 10,
          children: [
            SizedBox(width: 5),
            icon,
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
