import 'package:flutter/material.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/config.dart';
import 'package:lovejourney/l10n/l10n.dart';

class ComfromDeleteBottomsheet extends StatefulWidget {
  const ComfromDeleteBottomsheet({super.key});

  @override
  State<ComfromDeleteBottomsheet> createState() =>
      _ComfromDeleteBottomsheetState();
}

class _ComfromDeleteBottomsheetState extends State<ComfromDeleteBottomsheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 15),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Configs.commonRadius),
          ),
          child: Column(
            spacing: 5,
            children: [
              Text(
                context.l10n.detailStory,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                context.l10n.areYousureyouwanttodeletestory,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
              SizedBox(height: 5),
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
                                    color: Color(0xffFF0000),
                                  ),
                        )),
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xffFF0000),
                        ),
                        child: Text(
                          context.l10n.delete,
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
        SizedBox(height: 20)
      ],
    );
  }
}
