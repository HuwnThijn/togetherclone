import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lovejourney/cores/shared.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/config.dart';
import 'package:lovejourney/cores/models/loveday_model.dart';
import 'package:lovejourney/cores/servicelocator/service_locator.dart';
import 'package:lovejourney/cores/store/share_prefer.dart';
import 'package:lovejourney/cores/ultils.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';
import 'package:lovejourney/pages/home_page.dart';

class SetUpPhotoPage extends StatefulWidget {
  const SetUpPhotoPage({super.key});

  @override
  State<SetUpPhotoPage> createState() => _SetUpPhotoPageState();
}

class _SetUpPhotoPageState extends State<SetUpPhotoPage> {
  String imageMen = '';
  String imageWoman = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AssetsClass.images.imageBackgroundLove.path),
            fit: BoxFit.cover),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            AssetsClass.images.imageUndrawSuperthankyouFlq.image(width: 190),
            Center(
              child: Text(context.l10n.setUpphotos,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 70,
              children: [
                _buildItemImage(
                  imagePath: imageMen.isEmpty
                      ? AssetsClass.images.imageMen.path
                      : imageMen,
                  isAsset: imageMen.isEmpty,
                  onPressed: () {
                    serviceLocator<ImagePicker>()
                        .pickImage(source: ImageSource.gallery)
                        .then((value) {
                      if (value != null) {
                        setState(() {
                          imageMen = value.path;
                        });
                      }
                    });
                  },
                ),
                _buildItemImage(
                  imagePath: imageWoman.isEmpty
                      ? AssetsClass.images.imageWoman.path
                      : imageWoman,
                  isAsset: imageWoman.isEmpty,
                  onPressed: () {
                    serviceLocator<ImagePicker>()
                        .pickImage(source: ImageSource.gallery)
                        .then((value) {
                      if (value != null) {
                        setState(() {
                          imageWoman = value.path;
                        });
                      }
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            TextButton(
                onPressed: () async {
                  final data = await serviceLocator<SharePrefer>().getLoveday();
                  serviceLocator<SharePrefer>()
                      .saveLoveDay(
                    data.copyWith(
                      imageMen: imageMen.isNotEmpty
                          ? await copyImageToCache(
                              File(imageMen).readAsBytesSync(),
                              name: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString())
                          : '',
                      imageWoman: imageWoman.isNotEmpty
                          ? await copyImageToCache(
                              File(imageWoman).readAsBytesSync(),
                              name: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString())
                          : '',
                      isAddPhoto: true,
                    ),
                  )
                      .then((value) {
                    Navigator.pushReplacement(
                        context, createRouter(HomePage(key: Configs.mainKey)));
                  });
                },
                style: TextButton.styleFrom(
                  minimumSize:
                      Size(Device.width - 30, Configs.commonHeightButton),
                  backgroundColor: Shared.instance.isMainColor
                      ? AppColors.accentDark
                      : Configs.listColorTheme.first,
                ),
                child: Text(
                  context.l10n.done,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                      ),
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildItemImage(
      {required String imagePath,
      bool isAsset = true,
      void Function()? onPressed}) {
    return Column(
      spacing: 10,
      children: [
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: isAsset
                ? DecorationImage(
                    image: AssetImage(imagePath), fit: BoxFit.cover)
                : DecorationImage(
                    image: FileImage(File(imagePath)), fit: BoxFit.cover),
          ),
        ),
        InkWell(
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
                color: Color(0xffBC65FF),
                borderRadius: BorderRadius.circular(10)),
            child: Text(context.l10n.addPhoto,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        )
      ],
    );
  }
}
