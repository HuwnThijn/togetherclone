import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lovejourney/cores/extentions/messagingservice.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/config.dart';
import 'package:lovejourney/cores/models/love_story_model.dart';
import 'package:lovejourney/cores/servicelocator/service_locator.dart';
import 'package:lovejourney/cores/store/share_prefer.dart';
import 'package:lovejourney/cores/ultils.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';
import 'package:lovejourney/pages/add_story/add_story_page.dart';
import 'package:lovejourney/pages/bottomsheets/comfrom_delete_bottomsheet.dart';

class DetailStoryPage extends StatefulWidget {
  const DetailStoryPage({super.key, required this.item});

  final LoveStoryModel item;

  @override
  State<DetailStoryPage> createState() => _DetailStoryPageState();
}

class _DetailStoryPageState extends State<DetailStoryPage> {
  late LoveStoryModel item;

  @override
  void initState() {
    super.initState();
    item = widget.item;
    serviceLocator<MessagingService>().subscribe(this,
        channel: MessageChannel.memoryPictureChanged, action: (_) => getData());
  }

  @override
  void dispose() {
    super.dispose();
    serviceLocator<MessagingService>()
        .unsubscribe(this, channel: MessageChannel.memoryPictureChanged);
  }

  void getData() async {
    final data = await serviceLocator<SharePrefer>().getLoveStory();

    final updatedData = data.where(
      (s) => s.id == widget.item.id,
    );

    if (updatedData.isNotEmpty && mounted) {
        setState(() {
          item = updatedData.first;
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.accentDark,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon:
              AssetsClass.icons.arrowRight.svg(width: 24, color: Colors.white),
        ),
        title: Text(
          context.l10n.infomationMemory,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
                context,
                createRouter(AddStoryPage(
                  item: item,
                ))).then(
              (value) {
                if (value is LoveStoryModel) {
                  
                  setState(() {
                    item = value;
                  });
                }
              },
            ),
            icon: AssetsClass.icons.edit.svg(width: 24, color: Colors.white),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text(
                    '${context.l10n.photoBackground.toUpperCase()}: ',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 10),
                  ),
                  if (item.image.isNotEmpty)
                    Container(
                      height: 170,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius:
                            BorderRadius.circular(Configs.commonRadius),
                        image: DecorationImage(
                          image: FileImage(File(item.image)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  Text(
                    '${context.l10n.memoryName.toUpperCase()}: ',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 10),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(Configs.commonRadius),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        item.description,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '${context.l10n.memoryDay.toUpperCase()}: ',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 10),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(Configs.commonRadius),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 5),
                        AssetsClass.icons.calenderClock
                            .svg(width: 24, color: Colors.black87),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            DateFormat('dd/MM/yyyy').format(
                              DateTime.parse(item.date),
                            ),
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.titleSmall?.color,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) => ComfromDeleteBottomsheet())
                          .then(
                        (value) {
                          if (value is bool && value) {
                            serviceLocator<SharePrefer>()
                                .removeLoveStory(item.id)
                                .then((value) {
                              Navigator.pop(context, value);
                            });
                          }
                        },
                      );
                    },
                    style: TextButton.styleFrom(
                      minimumSize:
                          Size(Device.width, Configs.commonHeightButton),
                      backgroundColor: Color(0xffFF0000),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15)
                    ),
                    child: Text(
                      context.l10n.delete,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
