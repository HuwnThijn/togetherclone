import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/config.dart';
import 'package:lovejourney/cores/servicelocator/service_locator.dart';
import 'package:lovejourney/cores/store/share_prefer.dart';
import 'package:lovejourney/cores/themes_app.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:lovejourney/gen/assets.gen.dart';

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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: AssetsClass.icons.arrowRight
              .svg(width: 24, color: AppColors.accentDark),
        ),
        title: Text(
          'Wallpaper',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.accentDark,
              ),
        ),
      ),
      body: buildBody(),
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
                              Configs.mainKey.currentState!.setState(() {});
                            },
                          );
                        } else {
                          stores.saveBackground(listImage[index]).then(
                            (value) {
                              Navigator.pop(context);
                              Configs.mainKey.currentState!.setState(() {});
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
