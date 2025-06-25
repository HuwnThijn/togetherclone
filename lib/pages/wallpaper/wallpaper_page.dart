import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/config.dart';
import 'package:lovejourney/cores/extentions/messagingservice.dart';
import 'package:lovejourney/cores/servicelocator/service_locator.dart';
import 'package:lovejourney/cores/store/share_prefer.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';
import 'package:lovejourney/pages/bottomsheets/choose_option_camera_bottomsheet.dart';

class WallpaperPage extends StatefulWidget {
  const WallpaperPage({super.key});

  @override
  State<WallpaperPage> createState() => _WallpaperPageState();
}

class _WallpaperPageState extends State<WallpaperPage> {
  late List<String> listImage;

  final stores = serviceLocator<SharePrefer>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: buildBody(),
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
        context.l10n.background,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const ChooseOptionCameraBottomsheet(),
                ).then((value) async {
                  if (value != null) {
                    final ImagePicker picker = ImagePicker();
                    XFile? image;
                    image = await picker.pickImage(source: value);

                    if (image != null) {
                      try {
                        final bytes = await image.readAsBytes();

                        final base64Image = base64Encode(bytes);

                        await stores.saveBackground(base64Image);

                        serviceLocator<MessagingService>().send(
                            channel: MessageChannel.themeChanged,
                            parameter: true);

                        setState(() {});
                      } catch (e) {}
                    }
                  }
                });
              },
              icon: AssetsClass.icons.file2.svg(
                color: Colors.white,
                width: 24,
                height: 24,
              )),
        )
      ],
      centerTitle: true,
    );
  }

  Widget buildBody() {
    return FutureBuilder<List<String>>(
        future: stores.getListAlbum(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            listImage = snapshot.data ?? [];
            listImage.addAll(Configs.listImageBG);
            return listImage.isNotEmpty
                ? GridView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 200,
                    ),
                    itemBuilder: (_, index) => GestureDetector(
                      onTap: () async {
                        if (listImage[index].contains('assets/backrounds')) {
                          final bytes = await rootBundle.load(listImage[index]);
                          stores
                              .saveBackground(
                                  base64Encode(bytes.buffer.asUint8List()))
                              .then(
                            (value) {
                              Navigator.pop(context);
                              serviceLocator<MessagingService>().send(
                                  channel: MessageChannel.themeChanged,
                                  parameter: true);
                            },
                          );
                        } else {
                          stores.saveBackground(listImage[index]).then(
                            (value) {
                              Navigator.pop(context);
                              serviceLocator<MessagingService>().send(
                                  channel: MessageChannel.themeChanged,
                                  parameter: true);
                            },
                          );
                        }
                      },
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.accentDark,
                          borderRadius: BorderRadius.circular(20),
                          // image: DecorationImage(
                          //   image: listImage[index].contains('assets/backrounds') ? AssetImage(listImage[index]) : MemoryImage(
                          //     base64Decode(listImage[index]),
                          //   ),
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: listImage[index].contains('assets/backrounds')
                            ? Image.asset(
                                listImage[index],
                                fit: BoxFit.cover,
                              )
                            : Image.memory(base64Decode(listImage[index]),
                                fit: BoxFit.cover),
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    itemCount: listImage.length,
                  )
                : Center(
                    child: Text(
                      'Sorry albums empty!',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Colors.black87,
                          ),
                    ),
                  );
          }
          return Center(
            child: CupertinoActivityIndicator(
              color: AppColors.accentDark,
            ),
          );
        });
  }
}
