import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/config.dart';
import 'package:lovejourney/cores/extentions/messagingservice.dart';
import 'package:lovejourney/cores/models/love_story_model.dart';
import 'package:lovejourney/cores/servicelocator/service_locator.dart';
import 'package:lovejourney/cores/store/share_prefer.dart';
import 'package:lovejourney/cores/ultils.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';
import 'package:lovejourney/pages/add_story/add_story_page.dart';
import 'package:lovejourney/pages/detail_story/detail_story_page.dart';
import 'package:lovejourney/pages/love_story/widgets/memory_card.dart';

class LoveStoryPage extends StatefulWidget {
  const LoveStoryPage({super.key});

  @override
  State<LoveStoryPage> createState() => _LoveStoryPageState();
}

class _LoveStoryPageState extends State<LoveStoryPage> {
  final List<LoveStoryModel> list = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getdata();
    serviceLocator<MessagingService>().subscribe(
      this,
      channel: MessageChannel.memoryPictureChanged,
      action: (_) => getdata(),
    );
  }

  @override
  void dispose() {
    serviceLocator<MessagingService>().unsubscribe(
      this,
      channel: MessageChannel.memoryPictureChanged,
    );
    super.dispose();
  }

  void getdata() {
    serviceLocator<SharePrefer>().getLoveStory().then(
      (value) {
        list.clear();
        list.addAll(value);
        isLoading = false;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.accentDark,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: AssetsClass.icons.arrowRight
              .svg(width: 24, color: Colors.white),
        ),
        title: Text(
          context.l10n.memoriesMoment,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.push(context, createRouter(AddStoryPage())).then(
              (value) {
                if (value is bool && value) {
                  getdata();
                }
              },
            ),
            icon: AssetsClass.icons.rectangleHistoryCirclePlus
                .svg(width: 24, color: Colors.white),
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: AppColors.accentDark,
              ),
            )
          : list.isNotEmpty
              ? _buildBody()
              : _buildListEmpty(),
    );
  }

  Widget _buildBody() {
    return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 15),
        itemBuilder: (context, index) => _buildItem(list[index]),
        separatorBuilder: (context, index) => SizedBox(),
        itemCount: list.length);
  }

  Widget _buildItem(LoveStoryModel item) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        createRouter(DetailStoryPage(
          item: item,
        )),
      ).then(
        (value) {
          if (value is bool && value) {
            getdata();
          }
        },
      ),
      child: Padding(padding: const EdgeInsets.symmetric(vertical: 10),
        child: MemoryCard(
          title: item.description,
          date: DateTime.parse(item.date),
          imagePath: item.image,
        ),
      ),
    );
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
}
