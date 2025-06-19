import 'package:flutter/material.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/config.dart';
import 'package:lovejourney/l10n/l10n.dart';

class ChangedThemeBottomsheet extends StatefulWidget {
  const ChangedThemeBottomsheet({super.key});

  @override
  State<ChangedThemeBottomsheet> createState() =>
      _ChangedThemeBottomsheetState();
}

class _ChangedThemeBottomsheetState extends State<ChangedThemeBottomsheet> {
  late Color selectedColor;

  @override
  void initState() {
    super.initState();
    selectedColor = AppColors.accentDark;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.all(15),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            // borderRadius: BorderRadius.circular(Configs.commonRadius),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            spacing: 15,
            children: [
              Text(
                context.l10n.changeTheme,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Wrap(
                spacing: 5,
                runSpacing: 5,
                children: Configs.listColorTheme
                    .map(
                      (e) => InkWell(
                        onTap: () => setState(() {
                          selectedColor = e;
                        }),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: e, borderRadius: BorderRadius.circular(5)),
                          child: selectedColor == e
                              ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ),
                    )
                    .toList(),
              ),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          context.l10n.cancel,
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: AppColors.accentDark,
                                  ),
                        )),
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () => Navigator.pop(context, selectedColor),
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.accentDark,
                        ),
                        child: Text(
                          context.l10n.change,
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: Colors.white,
                                  ),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
