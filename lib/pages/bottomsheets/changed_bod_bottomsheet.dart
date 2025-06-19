import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/l10n/l10n.dart';

class ChangedBodBottomsheet extends StatefulWidget {
  const ChangedBodBottomsheet({super.key});

  @override
  State<ChangedBodBottomsheet> createState() => _ChangedBodBottomsheetState();
}

class _ChangedBodBottomsheetState extends State<ChangedBodBottomsheet> {
  DateTime? dating;

  @override
  void initState() {
    super.initState();
    dating = DateTime.now().add(Duration(days: -(365 * 12)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(context.l10n.changeDOB,
                  style: Theme.of(context).textTheme.titleMedium),
              SizedBox(
                height: 200,
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle:
                          Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  child: CupertinoDatePicker(
                    initialDateTime:
                        DateTime.now().add(Duration(days: -(365 * 12))),
                    mode: CupertinoDatePickerMode.date,
                    maximumDate:
                        DateTime.now().add(Duration(days: -(365 * 12))),
                    use24hFormat: true,
                    showDayOfWeek: true,
                    onDateTimeChanged: (DateTime newDate) {
                      dating = newDate;
                    },
                  ),
                ),
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
                        onPressed: () => Navigator.pop(context, dating),
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.accentDark,
                        ),
                        child: Text(
                          context.l10n.save,
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
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
