import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/config.dart';
import 'package:lovejourney/cores/extentions/messagingservice.dart';
import 'package:lovejourney/cores/models/loveday_model.dart';
import 'package:lovejourney/cores/path_image.dart';
import 'package:lovejourney/cores/routes/routes.dart';
import 'package:lovejourney/cores/servicelocator/service_locator.dart';
import 'package:lovejourney/cores/shared.dart';
import 'package:lovejourney/cores/store/share_prefer.dart';
import 'package:lovejourney/cores/ultils.dart';
import 'package:lovejourney/cores/widgets/custom_indot.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';
import 'package:lovejourney/pages/homeviews/animation_heart_widget.dart';
import 'package:lovejourney/pages/homeviews/widgets/user_profile_widget.dart';
import 'package:lovejourney/pages/love_story/love_story_page.dart';
import 'package:lovejourney/pages/settings/sidebar_setting.dart';

class CountLoveView2 extends StatefulWidget {
  const CountLoveView2({super.key});

  @override
  State<CountLoveView2> createState() => _CountLoveView2State();
}

class _CountLoveView2State extends State<CountLoveView2>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final TabController tabController;
  late LoveDayModel loveData;
  bool isLoading = true;
  String frame = '';
  String backGround = '';
  String backgroundImage = ''; // Optional: background image path

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    getLoveData();
    serviceLocator<MessagingService>().subscribe(
      this,
      channel: MessageChannel.lovedayChanged,
      action: (_) => getLoveData(),
    );
    serviceLocator<MessagingService>().subscribe(this,
        channel: MessageChannel.userDataChanged, action: (_) => getLoveData());
    serviceLocator<MessagingService>().subscribe(this,
        channel: MessageChannel.themeChanged, action: (_) => getLoveData());
  }

  @override
  void dispose() {
    serviceLocator<MessagingService>()
        .unsubscribe(this, channel: MessageChannel.lovedayChanged);
    serviceLocator<MessagingService>()
        .unsubscribe(this, channel: MessageChannel.userDataChanged);
    serviceLocator<MessagingService>()
        .unsubscribe(this, channel: MessageChannel.themeChanged);
    super.dispose();
  }

  void getLoveData() async {
    setState(() {
      isLoading = true;
    });

    try {
      loveData = await serviceLocator<SharePrefer>().getLoveday();
      frame = serviceLocator<SharePrefer>().getFrameUser();
      backGround = serviceLocator<SharePrefer>().getBackground();

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error loading love data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return _buildLoveContent();
  }

  Widget _buildLoveContent() {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .6,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            image: backGround.isNotEmpty
                ? DecorationImage(
                    image: MemoryImage(base64Decode(backGround)),
                    fit: BoxFit.cover)
                : DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(AssetsClass.backrounds.backround1.path)),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 10,
                top: 120,
                child: Container(
                  width: 393,
                  height: 496,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      //color: Colors.black.withValues(alpha: 26),
                      ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
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
                                          image: AssetImage(
                                              PathImage.im_frame_love),
                                          fit: BoxFit.fill,
                                          colorFilter:
                                              Shared.instance.isMainColor
                                                  ? ColorFilter.mode(
                                                      AppColors.accentDark,
                                                      BlendMode.srcATop)
                                                  : null,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            context.l10n.beingTogether,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                          ),
                                          Builder(builder: (context) {
                                            final total = DateTime.now()
                                                .difference(DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        loveData.loveday ?? 0));
                                            return Text(
                                              '${total.inDays}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayLarge
                                                  ?.copyWith(
                                                    color: const Color.fromRGBO(
                                                        255, 175, 204, 1),
                                                    fontWeight: FontWeight.bold,
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
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      width: 350,
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          color: AppColors.accentDark
                                              .withValues(alpha: .1),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              width: 3,
                                              color: Shared.instance.isMainColor
                                                  ? AppColors.accentDark
                                                  : Configs
                                                      .listColorTheme.first)),
                                      child: Column(
                                        spacing: 15,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Builder(builder: (context) {
                                            final total = DateTime.now()
                                                .difference(DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        loveData.loveday ?? 0));
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                buildItemCalculate(
                                                    title: context.l10n.years,
                                                    value:
                                                        '${total.inDays ~/ 365}'),
                                                buildItemCalculate(
                                                    title: context.l10n.months,
                                                    value:
                                                        '${(total.inDays % 365) ~/ 30}'),
                                                buildItemCalculate(
                                                    title: context.l10n.weeks,
                                                    value:
                                                        '${((total.inDays % 365) % 30) ~/ 7}'),
                                                buildItemCalculate(
                                                    title: context.l10n.days,
                                                    value:
                                                        '${((total.inDays % 365) % 30) % 7}'),
                                              ],
                                            );
                                          }),
                                          Text(
                                            context
                                                .l10n.theAnniversarystartdate,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            spacing: 10,
                                            children: [
                                              Icon(
                                                CupertinoIcons.heart_fill,
                                                color:
                                                    Shared.instance.isMainColor
                                                        ? AppColors.accentDark
                                                        : Colors.redAccent,
                                              ),
                                              Text(
                                                DateFormat('dd/MM/yyyy').format(
                                                  DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                    loveData.loveday ?? 0,
                                                  ),
                                                ),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white),
                                              ),
                                              Icon(
                                                CupertinoIcons.heart_fill,
                                                color:
                                                    Shared.instance.isMainColor
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
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 350,
                top: 55,
                child: SizedBox(
                    width: 55,
                    height: 55,
                    child: IconButton(
                      icon: AssetsClass.icons.settings.svg(
                        width: 55,
                        color: AppColors.accentDark,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const CustomSidebar(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.ease;
                              var tween = Tween(begin: begin, end: end).chain(
                                CurveTween(curve: curve),
                              );
                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                            transitionDuration:
                                const Duration(milliseconds: 300),
                            opaque: false,
                          ),
                        );
                      },
                    )),
              ),
              Positioned(
                left: 304,
                top: 55,
                child: Container(
                  width: 55,
                  height: 55,
                  child: Stack(
                    children: [
                      Positioned(
                        child: SizedBox(
                          width: 55,
                          height: 55,
                          child: IconButton(
                              onPressed: () => Navigator.push(
                                  context, createRouter(LoveStoryPage())),
                              icon: AssetsClass.icons.calendarHeart.svg(
                                  width: 40,
                                  color: AppColors.accentDark)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 55,
                child: SizedBox(
                  width: 55,
                  height: 55,
                  child: Stack(
                    children: [
                      Positioned(
                        child: Container(
                          width: 60,
                          height: 60,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                          child: IconButton(
                              onPressed: () {
                                Fluttertoast.showToast(
                                    msg: context.l10n.functionunderdevelopment);
                              },
                              icon: AssetsClass.images.imageBestSeller.image(
                                  width: 40, color: AppColors.accentDark)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: -297,
                top: 413,
                child: Container(
                  width: 530,
                  height: 257,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 182,
                top: 413,
                child: Container(
                  width: 530,
                  height: 257,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: OvalBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * .4,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            spacing: 80,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                spacing: 12,
                children: [
                  Text(
                    context.l10n.theDayWeStartedLovingEachOther,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF5E5E5E),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.38,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      buildDateDisplay(DateFormat('dd/MM/yyyy').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            loveData.loveday ?? 0),
                      )),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 50,
                children: [
                  UserProfileWidget(
                      imagePath: loveData.imageMen,
                      shapeType: serviceLocator<SharePrefer>().getShapeType(),
                      username: loveData.nameMen,
                      dateOfBirth: loveData.dobMen,
                      framePath: frame,
                      defaultUsername: 'Username 1',
                      defaultImage: AssetsClass.images.imageMen.image(
                        width: 100,
                        fit: BoxFit.cover,
                      )),
                  AnimationHeartWidget(),
                  UserProfileWidget(
                      imagePath: loveData.imageWoman,
                      shapeType: serviceLocator<SharePrefer>().getShapeType(),
                      username: loveData.nameWoman,
                      dateOfBirth: loveData.dobWoman,
                      framePath: frame,
                      defaultUsername: 'Username 2',
                      defaultImage: AssetsClass.images.imageWoman.image(
                        width: 100,
                        fit: BoxFit.cover,
                      )),
                ],
              ),
            ],
          ),
        )
      ],
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
          child: Text(value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  )),
        ),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ],
    );
  }

  Widget buildDateDisplay(String dateString) {
    // Tách chuỗi ngày thành từng ký tự
    List<String> characters = dateString.split('');

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: characters.map((char) {
        // Kiểm tra nếu là số thì hiển thị trong ô tròn
        if (RegExp(r'[0-9]').hasMatch(char)) {
          return Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Center(
              child: Text(
                char,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accentDark,
                ),
              ),
            ),
          );
        } else {
          // Nếu là dấu "/" thì hiển thị bình thường
          return Container(
            width: 20,
            alignment: Alignment.center,
            child: Text(
              char,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey[500],
              ),
            ),
          );
        }
      }).toList(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
