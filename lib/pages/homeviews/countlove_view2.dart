import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/extentions/messagingservice.dart';
import 'package:lovejourney/cores/models/loveday_model.dart';
import 'package:lovejourney/cores/path_image.dart';
import 'package:lovejourney/cores/routes/routes.dart';
import 'package:lovejourney/cores/servicelocator/service_locator.dart';
import 'package:lovejourney/cores/shared.dart';
import 'package:lovejourney/cores/store/share_prefer.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';

class CountLoveView2 extends StatefulWidget {
  const CountLoveView2({super.key});

  @override
  State<CountLoveView2> createState() => _CountLoveViewState();
}

class _CountLoveViewState extends State<CountLoveView2> {
  LoveDayModel? loveData;
  bool isLoading = true;
  String frame = '';
  String backgroundImage = ''; // Optional: background image path

  @override
  void initState() {
    super.initState();
    getLoveData();
    
    // Subscribe to data changes
    serviceLocator<MessagingService>().subscribe(
      this,
      channel: MessageChannel.userDataChanged,
      action: (val) => getLoveData(),
    );
  }

  @override
  void dispose() {
    serviceLocator<MessagingService>()
        .unsubscribe(this, channel: MessageChannel.userDataChanged);
    super.dispose();
  }

  void getLoveData() async {
    setState(() {
      isLoading = true;
    });

    try {
      loveData = await serviceLocator<SharePrefer>().getLoveday();
      frame = serviceLocator<SharePrefer>().getFrameUser();
      
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
    // Calculate days together
    int daysTogether = 0;
    if (loveData?.loveday != null) {
      final startDate = DateTime.fromMillisecondsSinceEpoch(loveData!.loveday!);
      final currentDate = DateTime.now();
      daysTogether = currentDate.difference(startDate).inDays;
    }

    // Format the date for display
    String formattedDate = '';
    if (loveData?.loveday != null) {
      final date = DateTime.fromMillisecondsSinceEpoch(loveData!.loveday!);
      formattedDate = DateFormat('dd/MM/yyyy').format(date);
    }

    return Container(
    width: double.infinity,
    height: double.infinity,
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(color: Colors.white),
    child: Stack(
        children: [
            Positioned(
                left: -79,
                top: -8,
                child: Container(
                    width: 700,
                    height: 510,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: Image.asset(AssetsClass.images.imageHomeDefault.path).image,
                            fit: BoxFit.cover,
                        ),
                    ),
                ),
            ),
            Positioned(
                left: 0,
                top: 0,
                child: Container(
                    width: 393,
                    height: 496,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        //color: Colors.black.withValues(alpha: 26),
                    ),
                    child: Stack(
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
                                context.l10n.beingTogether,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                              ),
                              Builder(builder: (context) {
                                final total =
                                    DateTime.now().difference(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        loveData?.loveday ?? 0));
                                return Text(
                                  '${total.inDays}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.copyWith(
                                        color: const Color.fromRGBO(255, 175, 204, 1),
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
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 0,
                top: 0,
                child: Container(
                    width: 393,
                    height: 54,
                    child: Stack(
                        children: [
                            Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                    width: 140.50,
                                    height: 54,
                                    child: Stack(
                                        children: [
                                            Positioned(
                                                left: 51.92,
                                                top: 18.34,
                                                child: Text(
                                                    '9:41',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 17,
                                                        fontFamily: 'SF Pro',
                                                        fontWeight: FontWeight.w500,
                                                        height: 1.29,
                                                    ),
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 252.50,
                                top: 0,
                                child: Container(
                                    width: 140.50,
                                    height: 54,
                                    child: Stack(
                                        children: [
                                            Positioned(
                                                left: 81,
                                                top: 23,
                                                child: Opacity(
                                                    opacity: 0.35,
                                                    child: Container(
                                                        width: 25,
                                                        height: 13,
                                                        decoration: ShapeDecoration(
                                                            shape: RoundedRectangleBorder(
                                                                side: BorderSide(width: 1),
                                                                borderRadius: BorderRadius.circular(4.30),
                                                            ),
                                                        ),
                                                    ),
                                                ),
                                            ),
                                            Positioned(
                                                left: 83,
                                                top: 25,
                                                child: Container(
                                                    width: 21,
                                                    height: 9,
                                                    decoration: ShapeDecoration(
                                                        color: Colors.black,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(2.50),
                                                        ),
                                                    ),
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 344,
                top: 75,
                child: Container(
                    width: 30,
                    height: 30,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                        color: Colors.black.withValues(alpha: 38),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(200),
                        ),
                        shadows: [
                            BoxShadow(
                                color: Color(0x0C000000),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                            )
                        ],
                    ),
                    child: Stack(
                        children: [
                            Positioned(
                                left: 3,
                                top: 3,
                                child: Container(
                                    width: 24,
                                    height: 24,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    ),
                                    child: Stack(),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 304,
                top: 75,
                child: Container(
                    width: 30,
                    height: 30,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                        color: Colors.black.withValues(alpha: 38),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(200),
                        ),
                        shadows: [
                            BoxShadow(
                                color: Color(0x0C000000),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                            )
                        ],
                    ),
                    child: Stack(
                        children: [
                            Positioned(
                                left: 3,
                                top: 3,
                                child: Container(
                                    width: 24,
                                    height: 24,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    ),
                                    child: Stack(),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 20,
                top: 75,
                child: Container(
                    width: 30,
                    height: 30,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                        color: Colors.black.withValues(alpha: 38),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(200),
                        ),
                        shadows: [
                            BoxShadow(
                                color: Color(0x0C000000),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                            )
                        ],
                    ),
                    child: Stack(
                        children: [
                            Positioned(
                                left: 3,
                                top: 3,
                                child: Container(
                                    width: 24,
                                    height: 24,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(),
                                    child: Stack(),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            Positioned(
                left: -307,
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
                left: 172,
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
                left: 172,
                top: 654,
                child: Container(
                    width: 49,
                    height: 49,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage("https://placehold.co/49x49"),
                            fit: BoxFit.cover,
                        ),
                        boxShadow: [
                            BoxShadow(
                                color: Color(0x0C000000),
                                blurRadius: 2,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                            )
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 71,
                top: 507,
                child: Text(
                    'The day we started loving each other',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: const Color(0xFF5E5E5E),
                        fontSize: 16,
                        fontFamily: 'Inria Sans',
                        fontWeight: FontWeight.w400,
                        height: 1.38,
                    ),
                ),
            ),
            Positioned(
                left: 19,
                top: 540,
                child: Container(
                    width: 39,
                    height: 38.14,
                    padding: const EdgeInsets.all(9.07),
                    decoration: ShapeDecoration(
                        color: Colors.black.withValues(alpha: 5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(181.40),
                        ),
                    ),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 9.07,
                        children: [
                            Text(
                                '1',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: const Color(0xFFFF6B6B),
                                    fontSize: 20,
                                    fontFamily: 'Inria Sans',
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 114,
                top: 540.09,
                child: Container(
                    width: 39,
                    height: 38.14,
                    padding: const EdgeInsets.all(9.07),
                    decoration: ShapeDecoration(
                        color: Colors.black.withValues(alpha: 5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(181.40),
                        ),
                    ),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 9.07,
                        children: [
                            Text(
                                '0',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: const Color(0xFFFF6B6B),
                                    fontSize: 20,
                                    fontFamily: 'Inria Sans',
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 209,
                top: 540.09,
                child: Container(
                    width: 39,
                    height: 38.14,
                    padding: const EdgeInsets.all(9.07),
                    decoration: ShapeDecoration(
                        color: Colors.black.withValues(alpha: 5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(181.40),
                        ),
                    ),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 9.07,
                        children: [
                            Text(
                                '2',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: const Color(0xFFFF6B6B),
                                    fontSize: 20,
                                    fontFamily: 'Inria Sans',
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 293,
                top: 540.09,
                child: Container(
                    width: 39,
                    height: 38.14,
                    padding: const EdgeInsets.all(9.07),
                    decoration: ShapeDecoration(
                        color: Colors.black.withValues(alpha: 5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(181.40),
                        ),
                    ),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 9.07,
                        children: [
                            Text(
                                '2',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: const Color(0xFFFF6B6B),
                                    fontSize: 20,
                                    fontFamily: 'Inria Sans',
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 61,
                top: 540.09,
                child: Container(
                    width: 39,
                    height: 38.14,
                    padding: const EdgeInsets.all(9.07),
                    decoration: ShapeDecoration(
                        color: Colors.black.withValues(alpha: 5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(181.40),
                        ),
                    ),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 9.07,
                        children: [
                            Text(
                                '2',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: const Color(0xFFFF6B6B),
                                    fontSize: 20,
                                    fontFamily: 'Inria Sans',
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 156,
                top: 540.19,
                child: Container(
                    width: 39,
                    height: 38.14,
                    padding: const EdgeInsets.all(9.07),
                    decoration: ShapeDecoration(
                        color: Colors.black.withValues(alpha: 5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(181.40),
                        ),
                    ),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 9.07,
                        children: [
                            Text(
                                '6',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: const Color(0xFFFF6B6B),
                                    fontSize: 20,
                                    fontFamily: 'Inria Sans',
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 251,
                top: 540.19,
                child: Container(
                    width: 39,
                    height: 38.14,
                    padding: const EdgeInsets.all(9.07),
                    decoration: ShapeDecoration(
                        color: Colors.black.withValues(alpha: 5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(181.40),
                        ),
                    ),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 9.07,
                        children: [
                            Text(
                                '0',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: const Color(0xFFFF6B6B),
                                    fontSize: 20,
                                    fontFamily: 'Inria Sans',
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 335,
                top: 540.19,
                child: Container(
                    width: 39,
                    height: 38.14,
                    padding: const EdgeInsets.all(9.07),
                    decoration: ShapeDecoration(
                        color: Colors.black.withValues(alpha: 5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(181.40),
                        ),
                    ),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 9.07,
                        children: [
                            Text(
                                '3',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: const Color(0xFFFF6B6B),
                                    fontSize: 20,
                                    fontFamily: 'Inria Sans',
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 103,
                top: 547.09,
                child: SizedBox(
                    width: 8,
                    height: 22,
                    child: Text(
                        '/',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: const Color(0x7F5E5E5E),
                            fontSize: 20,
                            fontFamily: 'Inria Sans',
                            fontWeight: FontWeight.w400,
                            height: 1,
                        ),
                    ),
                ),
            ),
            Positioned(
                left: 198,
                top: 547.09,
                child: SizedBox(
                    width: 8,
                    height: 22,
                    child: Text(
                        '/',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: const Color(0x7F5E5E5E),
                            fontSize: 20,
                            fontFamily: 'Inria Sans',
                            fontWeight: FontWeight.w400,
                            height: 1,
                        ),
                    ),
                ),
            ),
            Positioned(
                left: 43,
                top: 738,
                child: Text(
                    'Username 1',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: const Color(0xFF5E5E5E),
                        fontSize: 20,
                        fontFamily: 'Inria Sans',
                        fontWeight: FontWeight.w700,
                        height: 1.10,
                    ),
                ),
            ),
            Positioned(
                left: 54,
                top: 764,
                child: Text(
                    'DD/MM/YYYY',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: const Color(0xFF5E5E5E),
                        fontSize: 14,
                        fontFamily: 'Inria Sans',
                        fontWeight: FontWeight.w400,
                        height: 1.57,
                    ),
                ),
            ),
            Positioned(
                left: 257,
                top: 764,
                child: Text(
                    'DD/MM/YYYY',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: const Color(0xFF5E5E5E),
                        fontSize: 14,
                        fontFamily: 'Inria Sans',
                        fontWeight: FontWeight.w400,
                        height: 1.57,
                    ),
                ),
            ),
            Positioned(
                left: 245,
                top: 738,
                child: Text(
                    'Username 2',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: const Color(0xFF5E5E5E),
                        fontSize: 20,
                        fontFamily: 'Inria Sans',
                        fontWeight: FontWeight.w700,
                        height: 1.10,
                    ),
                ),
            ),
        ],
    ),
);
  }

  Widget _buildBackgroundImage() {
    // Use user-provided couple image if available
    if (backgroundImage.isNotEmpty) {
      return Image.file(
        File(backgroundImage),
        fit: BoxFit.cover,
      );
    } 
    
    // Otherwise use default image from assets
    return Image.asset(
      AssetsClass.images.imageHomeDefault.path,
      fit: BoxFit.cover,
    );
  }

  Widget _buildHeartWithDays(int days) {
    return Container(
      width: 160,
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Golden heart outline
          CustomPaint(
            size: const Size(160, 160),
            painter: HeartPainter(
              color: const Color(0xFFFFD700).withOpacity(0.9),
              strokeWidth: 3,
            ),
          ),
          
          // Days count
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                days.toString(),
                style: const TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Text(
                'Days',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateDisplay(String date) {
    if (date.isEmpty) {
      return const SizedBox.shrink();
    }

    // Split the date to display each character separately
    List<String> dateChars = date.split('');

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: dateChars.map((char) {
        // For numbers, use boxes
        if (int.tryParse(char) != null) {
          return Container(
            width: 30,
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                char,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          );
        } 
        // For separators, just show text
        return Container(
          width: 10,
          height: 40,
          child: Center(
            child: Text(
              char,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildUserProfilesRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // User 1 profile
          _buildUserProfile(
            isUser1: true,
            name: loveData?.nameMen ?? 'Username 1',
            dob: loveData?.dobMen ?? 'DD/MM/YYYY',
            avatarPath: loveData?.imageMen ?? '',
          ),
          
          // Heart icon
          Container(
            padding: const EdgeInsets.all(8),
            child: Icon(
              Icons.favorite,
              color: AppColors.accentDark,
              size: 30,
            ),
          ),
          
          // User 2 profile
          _buildUserProfile(
            isUser1: false,
            name: loveData?.nameWoman ?? 'Username 2',
            dob: loveData?.dobWoman ?? 'DD/MM/YYYY',
            avatarPath: loveData?.imageWoman ?? '',
          ),
        ],
      ),
    );
  }

  Widget _buildUserProfile({
    required bool isUser1,
    required String name,
    required String dob,
    required String avatarPath,
  }) {
    return GestureDetector(
      onTap: () => _navigateToUserInfo(isUser1),
      child: Column(
        children: [
          // Avatar
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orange.shade200,
            ),
            child: ClipOval(
              child: avatarPath.isNotEmpty
                  ? Image.file(
                      File(avatarPath),
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    )
                  : isUser1
                      ? AssetsClass.images.imageMen.image(fit: BoxFit.cover)
                      : AssetsClass.images.imageWoman.image(fit: BoxFit.cover),
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Name
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          
          // Date of birth
          Text(
            dob,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToUserInfo(bool isUser1) {
    Navigator.pushNamed(
      context, 
      isUser1 ? Routes.maleInfoPage : Routes.femaleInfoPage,
    );
  }
}

// Heart shape painter
class HeartPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  HeartPainter({
    required this.color,
    this.strokeWidth = 3.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final double width = size.width;
    final double height = size.height;

    final Path path = Path();
    path.moveTo(width / 2, height / 5);
    
    // Left curve
    path.cubicTo(
      width / 4.5, 0, 
      0, height / 3.5, 
      width / 2, height * 0.85
    );
    
    // Right curve
    path.cubicTo(
      width, height / 3.5, 
      width * 0.85, 0, 
      width / 2, height / 5
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}