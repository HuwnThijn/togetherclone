import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovejourney/cores/config.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/enumlist.dart';
import 'package:lovejourney/cores/models/loveday_model.dart';
import 'package:lovejourney/cores/path_image.dart';
import 'package:lovejourney/cores/servicelocator/service_locator.dart';
import 'package:lovejourney/cores/shared.dart';
import 'package:lovejourney/cores/store/share_prefer.dart';
import 'package:lovejourney/cores/ultils.dart';
import 'package:lovejourney/cores/widgets/custom_indot.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';
import 'package:lovejourney/pages/bottomsheets/changed_bod_bottomsheet.dart';
import 'package:lovejourney/pages/bottomsheets/changed_option_bottomsheet.dart';
import 'package:lovejourney/pages/bottomsheets/changed_shape_avatar_bottomsheet.dart';
import 'package:lovejourney/pages/bottomsheets/choose_option_camera_bottomsheet.dart';
import 'package:lovejourney/pages/homeviews/animation_heart_widget.dart';
import 'package:lovejourney/pages/popups/changed_name_popup.dart';

class CountLoveView extends StatefulWidget {
  const CountLoveView({super.key});

  @override
  State<CountLoveView> createState() => _CountLoveViewState();
}

class _CountLoveViewState extends State<CountLoveView>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final TabController tabController;

  //final stores = serviceLocator<SharePrefer>();

  String frame = '';

  late LoveDayModel loveData;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    getLoveData();
  }

  void getLoveData() async {
    loveData = await serviceLocator<SharePrefer>().getLoveday();
    frame = serviceLocator<SharePrefer>().getFrameUser();
    isLoading = false;
    setState(() {});
  }

  void handleOption(int index, bool isMen) {
    switch (index) {
      case 0:
        showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => ChooseOptionCameraBottomsheet()).then(
          (value) {
            if (value is ImageSource) {
              serviceLocator<ImagePicker>()
                  .pickImage(source: value)
                  .then((value) async {
                if (value != null) {
                  if (isMen) {
                    if (loveData.imageMen.isNotEmpty)
                      File(loveData.imageMen).delete();
                  } else {
                    if (loveData.imageWoman.isNotEmpty)
                      File(loveData.imageWoman).delete();
                  }
                  serviceLocator<SharePrefer>()
                      .saveLoveDay(loveData.copyWith(
                    imageMen: isMen
                        ? await copyImageToCache(await value.readAsBytes(),
                            name: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString())
                        : loveData.imageMen,
                    imageWoman: isMen
                        ? loveData.imageWoman
                        : await copyImageToCache(await value.readAsBytes(),
                            name: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString()),
                  ))
                      .then(
                    (value) {
                      getLoveData();
                    },
                  );
                }
              });
            }
          },
        );
        break;
      case 1:
        showDialog(context: context, builder: (context) => ChangedNamePopup())
            .then(
          (value) {
            if (value is String && value.isNotEmpty) {
              serviceLocator<SharePrefer>()
                  .saveLoveDay(loveData.copyWith(
                nameMen: isMen ? value : loveData.nameMen,
                nameWoman: isMen ? loveData.nameWoman : value,
              ))
                  .then(
                (value) {
                  getLoveData();
                },
              );
            }
          },
        );
        break;
      case 2:
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) => ChangedBodBottomsheet()).then(
          (value) {
            if (value is DateTime) {
              serviceLocator<SharePrefer>()
                  .saveLoveDay(loveData.copyWith(
                dobMen: isMen ? value.toString() : loveData.nameMen,
                dobWoman: isMen ? loveData.nameWoman : value.toString(),
              ))
                  .then(
                (value) {
                  getLoveData();
                },
              );
            }
          },
        );
        break;
      case 3:
        if (isMen) {
          if (loveData.imageMen.isNotEmpty) File(loveData.imageMen).delete();
        } else {
          if (loveData.imageWoman.isNotEmpty) {
            File(loveData.imageWoman).delete();
          }
        }
        serviceLocator<SharePrefer>()
            .saveLoveDay(loveData.copyWith(
          imageMen: isMen ? '' : loveData.nameMen,
          imageWoman: isMen ? loveData.nameWoman : '',
        ))
            .then(
          (value) {
            getLoveData();
          },
        );
        break;
      case 4:
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => ChangedShapeAvatarBottomsheet(
                  assertImage: isMen
                      ? AssetsClass.images.imageMen.path
                      : AssetsClass.images.imageWoman.path,
                )).then(
          (value) {
            if (value is ShapeType) {
              serviceLocator<SharePrefer>().saveShapeType(value).then((value) {
                getLoveData();
              });
            }
          },
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? Column(
            children: [
              SizedBox(
                height: 15.h,
              ),
              SizedBox(
                height: 300,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(PathImage.im_frame_love),
                              fit: BoxFit.fill,
                              colorFilter: Shared.instance.isMainColor
                                  ? ColorFilter.mode(
                                      AppColors.accentDark, BlendMode.srcATop)
                                  : null,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                context.l10n.inlove,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                              ),
                              Builder(builder: (context) {
                                final total =
                                    DateTime.now().millisecondsSinceEpoch -
                                        loveData.loveday!;
                                return Text(
                                  DateTime.fromMillisecondsSinceEpoch(total)
                                      .day
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.copyWith(
                                        color: const Color(0xffFB8500),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 80,
                                      ),
                                );
                              }),
                              Text(
                                context.l10n.days,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          width: 350,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  width: 3,
                                  color: Shared.instance.isMainColor
                                      ? AppColors.accentDark
                                      : Configs.listColorTheme.first)),
                          child: Column(
                            spacing: 15,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Builder(builder: (context) {
                                final total = DateTime.now().difference(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        loveData.loveday ?? 0));
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildItemCalculate(
                                        title: context.l10n.years,
                                        value: '${total.inDays ~/ 365}'),
                                    buildItemCalculate(
                                        title: context.l10n.months,
                                        value: '${(total.inDays % 365) ~/ 30}'),
                                    buildItemCalculate(
                                        title: context.l10n.weeks,
                                        value:
                                            '${((total.inDays % 365) % 30) ~/ 7}'),
                                    buildItemCalculate(
                                        title: context.l10n.days,
                                        value: '${total.inDays}'),
                                  ],
                                );
                              }),
                              Text(
                                context.l10n.theAnniversarystartdate,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Shared.instance.isMainColor
                                            ? AppColors.accentDark
                                            : Colors.white),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 10,
                                children: [
                                  Icon(
                                    CupertinoIcons.heart_fill,
                                    color: Shared.instance.isMainColor
                                        ? AppColors.accentDark
                                        : Colors.redAccent,
                                  ),
                                  Text(
                                    DateFormat('dd/MM/yyyy').format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                        loveData.loveday ?? 0,
                                      ),
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Shared.instance.isMainColor
                                                ? AppColors.accentDark
                                                : Colors.white),
                                  ),
                                  Icon(
                                    CupertinoIcons.heart_fill,
                                    color: Shared.instance.isMainColor
                                        ? AppColors.accentDark
                                        : Colors.redAccent,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: CustomIndotWidget(
                  tabController: tabController,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                // decoration: BoxDecoration(boxShadow: [
                //   BoxShadow(
                //     color:
                //         AppColors.unIndicatorColor(Shared.instance.isDarkMode),
                //     blurRadius: 100,
                //     spreadRadius: 100,
                //   )
                // ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) =>
                                ChangedOptionBottomsheet()).then(
                          (value) {
                            if (value is int) {
                              handleOption(value, true);
                            }
                          },
                        );
                      },
                      child: Column(
                        spacing: 10,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 90,
                                width: 90,
                                decoration: getDecoration(
                                    serviceLocator<SharePrefer>()
                                        .getShapeType()),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: loveData.imageMen.isNotEmpty
                                    ? Image.file(
                                        File(loveData.imageMen),
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      )
                                    : AssetsClass.images.imageMen
                                        .image(width: 100, fit: BoxFit.cover),
                              ),
                              frame.isNotEmpty
                                  ? Positioned(
                                      top: -12,
                                      left: -12,
                                      right: -12,
                                      bottom: -12,
                                      child: Image.asset(
                                        frame,
                                        width: 90,
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                          Text(
                            loveData.nameMen.isNotEmpty
                                ? loveData.nameMen
                                : 'Username 1',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                          ),
                          Text(
                            loveData.dobMen.isNotEmpty
                                ? DateFormat('dd-MM-yyyy')
                                    .format(DateTime.parse(loveData.dobMen))
                                : '??-??-????',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    AnimationHeartWidget(),
                    // Icon(
                    //   CupertinoIcons.heart_fill,
                    //   color: AppColors.accentDark,
                    //   size: 50,
                    // ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) =>
                                ChangedOptionBottomsheet()).then(
                          (value) {
                            if (value is int) {
                              handleOption(value, false);
                            }
                          },
                        );
                      },
                      child: Column(
                        spacing: 10,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 90,
                                width: 90,
                                decoration: getDecoration(
                                    serviceLocator<SharePrefer>()
                                        .getShapeType()),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: loveData.imageWoman.isNotEmpty
                                    ? Image.file(
                                        File(loveData.imageWoman),
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      )
                                    : AssetsClass.images.imageWoman.image(
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              frame.isNotEmpty
                                  ? Positioned(
                                      top: -12,
                                      left: -12,
                                      right: -12,
                                      bottom: -12,
                                      child: Image.asset(
                                        frame,
                                        width: 90,
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                          Text(
                            loveData.nameWoman.isNotEmpty
                                ? loveData.nameWoman
                                : 'Username 2',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                          ),
                          Text(
                            loveData.dobWoman.isNotEmpty
                                ? DateFormat('dd-MM-yyyy')
                                    .format(DateTime.parse(loveData.dobWoman))
                                : '??-??-????',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30)
            ],
          )
        : Center(
            child: CircularProgressIndicator(
              color: AppColors.accentDark,
            ),
          );
  }

  Widget buildItemCalculate({required String title, required String value}) {
    return Column(
      spacing: 5,
      children: [
        Container(
          width: 56,
          height: 50,
          padding: EdgeInsets.only(top: 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      AssetsClass.images.imageBackgroundHeart.path))),
          child: Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: Shared.instance.isMainColor
                    ? AppColors.accentDark
                    : Colors.white),
          ),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: Shared.instance.isMainColor
                  ? AppColors.accentDark
                  : Colors.white),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
