import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';

class ChangedDatePopup extends StatefulWidget {
  const ChangedDatePopup({super.key,
    required this.initialDate,
    this.title = '',
    this.maximumDate,
    this.minimumDate,});

  final DateTime initialDate;
  final String title;
  final DateTime? maximumDate;
  final DateTime? minimumDate;

  @override
  State<ChangedDatePopup> createState() => _ChangedDatePopupState();
}

class _ChangedDatePopupState extends State<ChangedDatePopup> {
  late DateTime tempDate;

  @override
  void initState() {
    super.initState();
    tempDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Spacer(),
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: AssetsClass.icons.circleXmark.svg(
                    width: 24,
                    height: 24,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
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
                  initialDateTime: tempDate,
                  mode: CupertinoDatePickerMode.date,
                  maximumDate: widget.maximumDate ?? DateTime.now(),
                  minimumDate: widget.minimumDate,
                  use24hFormat: true,
                  showDayOfWeek: true,
                  onDateTimeChanged: (DateTime newDate) {
                    tempDate = newDate;
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(context, tempDate),
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.accentDark,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  context.l10n.select,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
