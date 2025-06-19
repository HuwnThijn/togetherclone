import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/l10n/l10n.dart';

class ChangedNamePopup extends StatefulWidget {
  const ChangedNamePopup({super.key, this.nameUser = ''});

  final String nameUser;

  @override
  State<ChangedNamePopup> createState() => _ChangedNamePopupState();
}

class _ChangedNamePopupState extends State<ChangedNamePopup> {
  final _textName = TextEditingController();

  bool get valid => _textName.text.isNotEmpty && _textName.text.length > 3;

  @override
  void initState() {
    super.initState();
    _textName.text = widget.nameUser;
  }

  @override
  void dispose() {
    super.dispose();
    _textName.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: InkWell(
        onTap: () => Navigator.pop(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                spacing: 10,
                children: [
                  Text(context.l10n.changeUsername,
                      style: Theme.of(context).textTheme.titleMedium),
                  TextFormField(
                    controller: _textName,
                    cursorColor: AppColors.accentLight,
                    canRequestFocus: true,
                    onChanged: (value) => setState(() {}),
                    decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: Theme.of(context).scaffoldBackgroundColor,
                        hintText: widget.nameUser.isNotEmpty
                            ? widget.nameUser
                            : 'Username',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.color
                                    ?.withValues(alpha: .3)),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(color: Colors.transparent)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(color: Colors.transparent))),
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              context.l10n.cancel,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    color: AppColors.accentDark,
                                  ),
                            )),
                      ),
                      Expanded(
                        child: TextButton(
                            onPressed: () =>
                                Navigator.pop(context, _textName.text),
                            style: TextButton.styleFrom(
                              backgroundColor: valid
                                  ? AppColors.accentDark
                                  : AppColors.accentDark.withValues(alpha: .3),
                            ),
                            child: Text(
                              context.l10n.save,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
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
              height: 10.h,
            )
          ],
        ),
      ),
    );
  }
}
