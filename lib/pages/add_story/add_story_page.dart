import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
import 'package:lovejourney/pages/bottomsheets/changed_choose_bottomsheet.dart';
import 'package:lovejourney/pages/bottomsheets/choose_option_camera_bottomsheet.dart';

class AddStoryPage extends StatefulWidget {
  const AddStoryPage({super.key, this.item});

  final LoveStoryModel? item;

  @override
  State<AddStoryPage> createState() => _AddStoryPageState();
}

class _AddStoryPageState extends State<AddStoryPage> {
  String pathImage = '';

  final _textContentController = TextEditingController();

  bool get valid =>
      _textContentController.text.isNotEmpty &&
      _textContentController.text.length > 10;

  late DateTime? dating;

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _textContentController.text = widget.item!.description;
      pathImage = widget.item!.image;
      if (widget.item!.date.isNotEmpty) {
        dating = DateTime.parse(widget.item!.date);
      }
    } else {
      dating = null;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _textContentController.dispose();
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
          widget.item != null ? context.l10n.editStory : context.l10n.newMemory,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text(
                    '${context.l10n.username.toUpperCase()}: ',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 10),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 12),
                    height: 170,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(Configs.commonRadius),
                      image: pathImage.isNotEmpty
                          ? DecorationImage(
                              image: FileImage(File(pathImage)),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: pathImage.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 15,
                            children: [
                              AssetsClass.icons.picture.svg(
                                  width: 44,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor),
                              InkWell(
                                onTap: () => showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) =>
                                        ChooseOptionCameraBottomsheet()).then(
                                  (value) {
                                    if (value is ImageSource) {
                                      serviceLocator<ImagePicker>()
                                          .pickImage(source: value)
                                          .then((value) {
                                        if (value != null) {
                                          setState(() {
                                            pathImage = value.path;
                                          });
                                        }
                                      });
                                    }
                                  },
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: Color(0xffBC65FF),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AssetsClass.icons.file2.svg(
                                          width: 16,
                                          color: Colors.white),
                                      SizedBox(width: 8),
                                      Text(context.l10n.upload,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    pathImage = '';
                                    File(pathImage).delete();
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.all(7),
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).cardColor,
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    size: 16,
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.color,
                                  ),
                                ),
                              )
                            ],
                          ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(Configs.commonRadius),
                    ),
                    child: TextFormField(
                      cursorColor: AppColors.accentDark,
                      maxLines: 16,
                      onChanged: (value) => setState(() {}),
                      controller: _textContentController,
                      decoration: InputDecoration(
                        hintText: context.l10n.enterThecontentofyourstory,
                        hintStyle:
                            Theme.of(context).textTheme.titleSmall?.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.color
                                      ?.withValues(alpha: .3),
                                ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(15),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => ChangedChooseBottomsheet(
                        title: context.l10n.pickaDate,
                      ),
                    ).then(
                      (value) {
                        if (value != null) {
                          setState(() {
                            dating = value;
                          });
                        }
                      },
                    ),
                    style: TextButton.styleFrom(
                      minimumSize:
                          Size(double.infinity, Configs.commonHeightButton),
                      backgroundColor: Theme.of(context).cardColor,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Configs.commonRadius),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          dating == null
                              ? context.l10n.pickaDate
                              : DateFormat('dd-MM-yyyy').format(dating!),
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        Icon(
                          Icons.arrow_drop_down_sharp,
                          color: AppColors.accentDark,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            if (valid) {
              if (widget.item != null) {
                final newStory = widget.item!.copyWith(
                  description: _textContentController.text,
                  image: pathImage.isNotEmpty
                      ? await copyImageToCache(
                          File(pathImage).readAsBytesSync(),
                          name:
                              DateTime.now().millisecondsSinceEpoch.toString())
                      : '',
                  date: dating != null ? dating.toString() : '',
                );
                serviceLocator<SharePrefer>().updateLoveStory(newStory).then(
                  (value) {
                    Navigator.pop(context, newStory);
                  },
                );
              } else {
                serviceLocator<SharePrefer>()
                    .saveLoveStory(
                  LoveStoryModel(
                      id: getRandomString(),
                      description: _textContentController.text,
                      image: pathImage.isNotEmpty
                          ? await copyImageToCache(
                              File(pathImage).readAsBytesSync(),
                              name: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString())
                          : '',
                      date: dating != null ? dating.toString() : ''),
                )
                    .then(
                  (value) {
                    Navigator.pop(context, true);
                  },
                );
              }
            }
          },
          style: TextButton.styleFrom(
            minimumSize: Size(Device.width - 30, Configs.commonHeightButton),
            backgroundColor: valid
                ? AppColors.accentDark
                : AppColors.accentDark.withValues(alpha: .3),
          ),
          child: Text(
              widget.item != null ? context.l10n.update : context.l10n.save,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white)),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
