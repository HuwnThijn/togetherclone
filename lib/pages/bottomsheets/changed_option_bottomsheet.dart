import 'package:flutter/material.dart';
import 'package:lovejourney/cores/shared.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/config.dart';
import 'package:lovejourney/l10n/l10n.dart';

class ChangedOptionBottomsheet extends StatefulWidget {
  const ChangedOptionBottomsheet({super.key});

  @override
  State<ChangedOptionBottomsheet> createState() =>
      _ChangedOptionBottomsheetState();
}

class _ChangedOptionBottomsheetState extends State<ChangedOptionBottomsheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      spacing: 10,
      children: [
        Container(
          padding: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            children: [
              buildItem(
                  child: AssetsClass.icons.circleUser.svg(
                    color: Shared.instance.isMainColor
                        ? AppColors.accentDark
                        : null,
                  ),
                  context.l10n.changeAvatar,
                  () => Navigator.pop(context, 0)),
              buildDivider(),
              buildItem(
                  child: AssetsClass.icons.messageText.svg(
                    color: Shared.instance.isMainColor
                        ? AppColors.accentDark
                        : null,
                  ),
                  context.l10n.changeUsername,
                  () => Navigator.pop(context, 1)),
              buildDivider(),
              buildItem(
                  child: AssetsClass.icons.resources.svg(
                    color: Shared.instance.isMainColor
                        ? AppColors.accentDark
                        : null,
                  ),
                  context.l10n.changeDOB,
                  () => Navigator.pop(context, 2)),
              buildDivider(),
              buildItem(
                  child: AssetsClass.icons.calenderClock.svg(
                    color: Shared.instance.isMainColor
                        ? AppColors.accentDark
                        : null,
                  ),
                  context.l10n.changeShapeAvatar,
                  () => Navigator.pop(context, 4)),
              buildDivider(),
              buildItem(
                  child: AssetsClass.icons.trash.svg(),
                  context.l10n.deleteAvatar,
                  () => Navigator.pop(context, 3),
                  color: Color(0xffFF2222)),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildItem(String title, Function() onTap,
      {Color? color, Widget? child}) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        height: Configs.commonHeightButton,
        child: Row(
          spacing: 10,
          children: [
            SizedBox(),
            child ?? SizedBox(),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.w500, color: color),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDivider() {
    return Container(
      height: 1,
      color: Theme.of(context).dividerColor,
    );
  }
}
