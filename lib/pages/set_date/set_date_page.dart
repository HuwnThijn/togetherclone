import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovejourney/cores/shared.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/config.dart';
import 'package:lovejourney/cores/models/loveday_model.dart';
import 'package:lovejourney/cores/servicelocator/service_locator.dart';
import 'package:lovejourney/cores/store/share_prefer.dart';
import 'package:lovejourney/cores/ultils.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';
import 'package:lovejourney/pages/set_up_photo/set_up_photo_page.dart';

class SetDatePage extends StatefulWidget {
  const SetDatePage({super.key});

  @override
  State<SetDatePage> createState() => _SetDatePageState();
}

class _SetDatePageState extends State<SetDatePage> {
  late DateTime dating;

  @override
  void initState() {
    super.initState();
    dating = DateTime.now();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AssetsClass.images.imageBackgroundLove.path),
            fit: BoxFit.cover),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            AssetsClass.images.imageUndrawFriendsXscy.image(width: 190),
            SizedBox(height: 10),
            Center(
              child: Text(context.l10n.setTheAnniversarystartdate,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ),
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
            TextButton(
                onPressed: () {
                  serviceLocator<SharePrefer>()
                      .saveLoveDay(LoveDayModel(
                    gender: '',
                    loveday: dating!.millisecondsSinceEpoch,
                  ))
                      .then((value) {
                    Navigator.pushReplacement(
                        context, createRouter(SetUpPhotoPage()));
                  });
                },
                style: TextButton.styleFrom(
                  minimumSize:
                      Size(Device.width - 30, Configs.commonHeightButton),
                  backgroundColor: Shared.instance.isMainColor
                      ? AppColors.accentDark
                      : Configs.listColorTheme.first,
                ),
                child: Text(
                  context.l10n.select,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                      ),
                ))
          ],
        ),
      ),
    );
  }
}
