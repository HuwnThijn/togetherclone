import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/l10n/l10n.dart';

class ChangedChooseBottomsheet extends StatefulWidget {
  const ChangedChooseBottomsheet(
      {super.key, this.title = ' ', this.initialDate});

  final String title;

  final DateTime? initialDate;

  @override
  State<ChangedChooseBottomsheet> createState() =>
      _ChangedChooseBottomsheetState();
}

class _ChangedChooseBottomsheetState extends State<ChangedChooseBottomsheet> {
  DateTime? dating;

  @override
  void initState() {
    super.initState();
    dating = widget.initialDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          // margin: EdgeInsets.symmetric(horizontal: 15),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Text(widget.title,
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
                    initialDateTime: dating,
                    mode: CupertinoDatePickerMode.date,
                    maximumDate: DateTime.now(),
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
      ],
    );
  }
}
