import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovejourney/cores/shared.dart';
import 'package:lovejourney/pages/gender/widgets/button_gender_widget.dart';
import 'package:lovejourney/pages/home_page.dart';
import 'package:lovejourney/pages/popups/changed_date_popup.dart';
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
  String? gender;

  @override
  void initState() {
    super.initState();
    dating = DateTime.now();
    gender = null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(),
    );
  }

  Future<void> _showDatePickerPopup() async {
    final picked = await showDialog<DateTime>(
        context: context,
        barrierDismissible: true,
        builder: (context) => ChangedDatePopup(
              initialDate: dating,
              title: context.l10n.pickaDate,
              maximumDate: DateTime.now(),
            ));
    if (picked != null) {
      setState(() {
        dating = picked;
      });
    }
  }

  Widget _buildBody() {
    return Column(
      children: [
        Stack(
          children: [
            Image.asset(
              AssetsClass.backrounds.backround0.path,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: [
                    Colors.white,
                    Color(0xFFFFFFFF),
                    Color(0xCCFFFFFF),
                    Colors.transparent
                  ],
                  stops: [.0, .1, .45, 1.0],
                )),
              ),
            )
          ],
        ),
        Transform.translate(
          offset: const Offset(0, -30),
          child: Expanded(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  Center(
                    child: Text(context.l10n.setTheAnniversarystartdate,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold)),
                  ),
                  // SizedBox(
                  //   height: 200,
                  //   child: CupertinoTheme(
                  //     data: CupertinoThemeData(
                  //       textTheme: CupertinoTextThemeData(
                  //         dateTimePickerTextStyle:
                  //             Theme.of(context).textTheme.titleSmall,
                  //       ),
                  //     ),
                  //     child: CupertinoDatePicker(
                  //       initialDateTime: dating,
                  //       mode: CupertinoDatePickerMode.date,
                  //       maximumDate: DateTime.now(),
                  //       use24hFormat: true,
                  //       showDayOfWeek: true,
                  //       onDateTimeChanged: (DateTime newDate) {
                  //         dating = newDate;
                  //       },
                  //     ),
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: _showDatePickerPopup,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.grey.withOpacity(0.5)),
                      ),
                      child: Row(
                        children: [
                          AssetsClass.icons.calenderClock.svg(
                            width: 24,
                            height: 24,
                            color: dating == null ? Colors.grey : Colors.black,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              dating == null
                                  ? 'DD/MM/YYYY'
                                  : "${dating.day.toString().padLeft(2, '0')}/${dating.month.toString().padLeft(2, '0')}/${dating.year}",
                              style: TextStyle(
                                color:
                                    dating == null ? Colors.grey : Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          AssetsClass.icons.arrowDown.svg(
                            width: 8,
                            height: 8,
                            color: dating == null ? Colors.grey : Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Center(
                    child: Text(context.l10n.yourGender,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Column(
                    spacing: 10,
                    children: [
                      ButtonGenderWidget(
                          icon: AssetsClass.icons.genderMale
                              .svg(width: 24, height: 24),
                          label: context.l10n.male,
                          value: 'male',
                          color: Colors.black87,
                          selectedColor: AppColors.accentDark,
                          selected: gender == "male",
                          onTap: (value) {
                            setState(() {
                              gender = value;
                            });
                          }),
                      ButtonGenderWidget(
                          icon: AssetsClass.icons.genderFemale
                              .svg(width: 24, height: 24),
                          label: context.l10n.female,
                          value: 'female',
                          color: Colors.black87,
                          selectedColor: AppColors.accentDark,
                          selected: gender == "female",
                          onTap: (value) {
                            setState(() {
                              gender = value;
                            });
                          }),
                    ],
                  ),
                  TextButton(
                      onPressed: (gender != null)
                          ? () {
                              serviceLocator<SharePrefer>()
                                  .saveLoveDay(LoveDayModel(
                                gender: gender ?? '',
                                loveday: dating!.millisecondsSinceEpoch,
                              ))
                                  .then((value) {
                                Navigator.pushReplacement(
                                    context, createRouter(HomePage()));
                              });
                            }
                          : null,
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        minimumSize:
                            Size(Device.width - 30, Configs.commonHeightButton),
                        backgroundColor: gender != null
                            ? (Shared.instance.isMainColor
                                ? AppColors.accentDark
                                : Configs.listColorTheme.first)
                            : Colors.grey.shade300,
                      ),
                      child: Text(
                        context.l10n.confirm,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _genderOption({
    required Widget icon,
    required String label,
    required String value,
    required Color color,
    required Color selectedColor,
    required bool selected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          gender = value;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? selectedColor : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: selectedColor.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? selectedColor : Colors.grey.shade400,
                  width: .5,
                ),
                color: Colors.white,
              ),
              child: selected
                  ? Center(
                      child: AssetsClass.icons.circleCheck.svg(
                        width: 24,
                        height: 24,
                        //color: selectedColor,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
  
}
