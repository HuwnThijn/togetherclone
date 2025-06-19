import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: AssetsClass.icons.arrowRight
              .svg(width: 24, color: AppColors.accentDark),
        ),
        title: Text(
          context.l10n.detailStory,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.accentDark,
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
                  item = value;
                  setState(() {});
                }
              },
            ),
            icon: AssetsClass.icons.edit
                .svg(width: 24, color: AppColors.accentDark),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                if (item.image.isNotEmpty)
                  Container(
                    height: 170,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(Configs.commonRadius),
                      image: DecorationImage(
                        image: FileImage(File(widget.item.image)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(Configs.commonRadius),
                  ),
                  child: Text(
                    item.description,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(Configs.commonRadius),
                  ),
                  child: Text(
                    DateFormat('dd-MM-yyyy').format(
                      DateTime.parse(item.date),
                    ),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                )
              ],
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => ComfromDeleteBottomsheet()).then(
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
            minimumSize: Size(Device.width - 30, Configs.commonHeightButton),
            backgroundColor: Color(0xffFF0000),
          ),
          child: Text(
            context.l10n.delete,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
        SizedBox(height: 20)
      ],
    );
  }
}
