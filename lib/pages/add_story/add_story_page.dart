import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lovejourney/cores/extentions/messagingservice.dart';
import 'package:lovejourney/cores/models/loveday_model.dart';
import 'package:lovejourney/pages/popups/changed_date_popup.dart';
import 'package:lovejourney/pages/popups/saved_popup.dart';
import 'package:lovejourney/pages/set_date/widgets/date_picker_input.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/config.dart';
import 'package:lovejourney/cores/models/love_story_model.dart';
import 'package:lovejourney/cores/servicelocator/service_locator.dart';
import 'package:lovejourney/cores/store/share_prefer.dart';
import 'package:lovejourney/cores/ultils.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';
import 'package:lovejourney/pages/bottomsheets/choose_option_camera_bottomsheet.dart';

class AddStoryPage extends StatefulWidget {
  const AddStoryPage({super.key, this.item});

  final LoveStoryModel? item;

  @override
  State<AddStoryPage> createState() => _AddStoryPageState();
}

class _AddStoryPageState extends State<AddStoryPage> {
  String? pathImage = '';

  LoveDayModel? loveData;

  final _textContentController = TextEditingController();

  bool get valid =>
      _textContentController.text.isNotEmpty &&
      _textContentController.text.length > 5;

  late DateTime? dating;

  @override
  void initState(){
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
    getLoveData();
  }
  void getLoveData() async {
    loveData = await serviceLocator<SharePrefer>().getLoveday();
    setState(() {});
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
          widget.item != null
              ? context.l10n.editMemory
              : context.l10n.newMemory,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
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
                      '${context.l10n.photoBackground.toUpperCase()}: ',
                      style:
                          TextStyle(color: Colors.grey.shade500, fontSize: 10),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 12),
                      height: 170,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius:
                            BorderRadius.circular(Configs.commonRadius),
                        image: pathImage!.isNotEmpty
                            ? DecorationImage(
                                image: FileImage(File(pathImage!)),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: pathImage!.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 15,
                              children: [
                                AssetsClass.icons.picture.svg(
                                    width: 44,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                InkWell(
                                  onTap: () => showDialog(
                                      context: context,
                                      builder: (context) =>
                                          ChooseOptionCameraBottomsheet()).then(
                                    (value) {
                                      if (value is ImageSource) {
                                        serviceLocator<ImagePicker>()
                                            .pickImage(source: value)
                                            .then((value) {
                                          if (value != null) {
                                            if (pathImage!.isNotEmpty) {
                                              try {
                                                File(pathImage!).delete();
                                              } catch (e) {}
                                            }
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
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        AssetsClass.icons.file2.svg(
                                            width: 16, color: Colors.white),
                                        SizedBox(width: 8),
                                        Text(context.l10n.upload,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall
                                                ?.copyWith(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
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
                                    // if (pathImage!.isNotEmpty) {
                                    //     try {
                                    //       File(pathImage!).delete();
                                    //     } catch (e) {}
                                    //   }
                                    setState(() {
                                      pathImage = '';
                                    });
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(right: 10, bottom: 15),
                                    //padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      //color: Theme.of(context).cardColor,
                                    ),
                                    child: AssetsClass.icons.circleXmark.svg(
                                      width: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${context.l10n.memoryName.toUpperCase()}: ',
                      style:
                          TextStyle(color: Colors.grey.shade500, fontSize: 10),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius:
                            BorderRadius.circular(Configs.commonRadius),
                      ),
                      child: TextFormField(
                        cursorColor: AppColors.accentDark,
                        onChanged: (value) => setState(() {}),
                        controller: _textContentController,
                        decoration: InputDecoration(
                          hintText: context.l10n.enterName,
                          hintStyle:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.color
                                        ?.withValues(alpha: .2),
                                  ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15),
                        ),
                      ),
                    ),
                    Text(
                      '${context.l10n.memoryDay.toUpperCase()}: ',
                      style:
                          TextStyle(color: Colors.grey.shade500, fontSize: 10),
                    ),
                    DatePickerInput(
                      selectedDate: dating,
                      onTap: _showDatePickerPopup,
                      placeholder: 'DD/MM/YYYY',

                    ),
                    TextButton(
                      onPressed: () async {
                        if (valid) {
                          if (widget.item != null) {
                            final newStory = widget.item!.copyWith(
                              description: _textContentController.text,
                              image: pathImage!.isNotEmpty
                                  ? await copyImageToCache(
                                      File(pathImage!).readAsBytesSync(),
                                      name: DateTime.now()
                                          .millisecondsSinceEpoch
                                          .toString())
                                  : '',
                              date: dating != null ? dating.toString() : '',
                            );

                            serviceLocator<SharePrefer>()
                                .updateLoveStory(newStory)
                                .then(
                              (value) {
                                Navigator.pop(context, newStory);
                                serviceLocator<MessagingService>().send(
                                    channel:
                                        MessageChannel.memoryPictureChanged,
                                    parameter: true);
                              },
                            );
                            
                          } else {
                            serviceLocator<SharePrefer>()
                                .saveLoveStory(
                              LoveStoryModel(
                                  id: getRandomString(),
                                  description: _textContentController.text,
                                  image: pathImage!.isNotEmpty
                                      ? await copyImageToCache(
                                          File(pathImage!).readAsBytesSync(),
                                          name: DateTime.now()
                                              .millisecondsSinceEpoch
                                              .toString())
                                      : '',
                                  date:
                                      dating != null ? dating.toString() : ''),
                            )
                                .then(
                              (value) {
                                Navigator.pop(context, true);
                                serviceLocator<MessagingService>().send(
                                    channel:
                                        MessageChannel.memoryPictureChanged,
                                    parameter: true);
                              },
                            );
                          }
                        }
                      },
                      style: TextButton.styleFrom(
                        minimumSize:
                            Size(Device.width, Configs.commonHeightButton),
                        backgroundColor: valid
                            ? AppColors.accentDark
                            : AppColors.accentDark.withValues(alpha: .3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        widget.item != null
                            ? context.l10n.save
                            : context.l10n.create,
                        style: TextStyle(
                          color: dating != DateTime.now()
                              ? Colors.white
                              : Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Future<void> _showDatePickerPopup() async {
    final picked = await showDialog<DateTime>(
        context: context,
        barrierDismissible: true,
        builder: (context) => ChangedDatePopup(
              initialDate: DateTime.now(),
              title: context.l10n.pickaDate,
              maximumDate: DateTime.now(),
              minimumDate: loveData != null && loveData!.loveday != null
                  ? DateTime.fromMillisecondsSinceEpoch(loveData!.loveday!)
                  : null,
            ));
    if (picked != null) {
      setState(() {
        dating = picked;
      });
    }
  }

//   Future<void> _showSuccessPopup() async {
//   await showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (context) => Dialog(
//       backgroundColor: Colors.transparent,
//       child: SavedPopup(
//         imagePath: AssetsClass.images.saved.path, // Hoặc icon success
//         title: context.l10n.save,
//       ),
//     ),
//   );
  
//   // Tự động đóng popup sau 2 giây
//   await Future.delayed(const Duration(seconds: 2));
//   if (mounted) {
//     Navigator.of(context).pop(); // Đóng popup
//   }
// }
}
