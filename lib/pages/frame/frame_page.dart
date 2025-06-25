import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/extentions/messagingservice.dart';
import 'package:lovejourney/cores/models/frame_model.dart';
import 'package:lovejourney/cores/servicelocator/service_locator.dart';
import 'package:lovejourney/cores/store/share_prefer.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';
import 'package:lovejourney/pages/bottomsheets/choose_option_camera_bottomsheet.dart';
import 'package:lovejourney/pages/frame/widget/frame_card.dart';

class FramePage extends StatefulWidget {
  const FramePage({super.key});

  @override
  State<FramePage> createState() => _FramePageState();
}

class _FramePageState extends State<FramePage> {
  final stores = serviceLocator<SharePrefer>();
  final List<FrameModel> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.accentDark,
      elevation: 0,
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: AssetsClass.icons.arrowRight.svg(
            color: Colors.white,
            width: 24,
            height: 24,
          )),
      title: Text(
        context.l10n.frame,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 15),
        itemBuilder: (context, index) => _buildItem(list[index]),
        separatorBuilder: (context, index) => SizedBox(),
        itemCount: list.length);
  }

  Widget _buildListEmpty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        Center(
          child: AssetsClass.images.imageListStoryEmpty.image(height: 146),
        ),
        Text(context.l10n.youDonthaveanymemoriesyet,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.color
                      ?.withValues(alpha: .2),
                )),
      ],
    );
  }

  Widget _buildItem(FrameModel item) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        // child: FrameCard(
        //   framePath: item.path,
        //   isSelected: selectedFrameIndex == index,
        //   onTap: () {
        //     setState(() {
        //       selectedFrameIndex = index;
        //     });
        //   },
        //   sampleImage: Image.asset(
        //     'assets/images/sample_avatar.png',
        //     fit: BoxFit.cover,
        //   ),
        // ),
      ),
    );
  }
}
