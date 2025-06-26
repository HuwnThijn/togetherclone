import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/config.dart';
import 'package:lovejourney/cores/extentions/messagingservice.dart';
import 'package:lovejourney/cores/models/frame_model.dart';
import 'package:lovejourney/cores/servicelocator/service_locator.dart';
import 'package:lovejourney/cores/store/share_prefer.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';
import 'package:lovejourney/pages/frame/widget/frame_card.dart';

class FramePage extends StatefulWidget {
  const FramePage({super.key});

  @override
  State<FramePage> createState() => _FramePageState();
}

class _FramePageState extends State<FramePage> {
  final stores = serviceLocator<SharePrefer>();
  late List<String> list = [];
  int selectedFrameIndex = -1;
  String currentFrame = '';

  @override
  void initState() {
    super.initState();
  }

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
    return FutureBuilder<List<String>>(
        future: stores.getListAlbum(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            list = snapshot.data ?? [];
            list.addAll(Configs.listFrame);
            return list.isNotEmpty
                ? GridView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 120,
                    ),
                    itemBuilder: (_, index) => GestureDetector(
                      onTap: () async {
                        if (list[index].contains('assets/frames')) {
                          setState(() {
                            selectedFrameIndex = index;
                          });
                          final bytes = await rootBundle.load(list[index]);
                          stores
                              .saveFrame(
                                  base64Encode(bytes.buffer.asUint8List()))
                              .then(
                            (value) {
                              //Navigator.pop(context);
                              serviceLocator<MessagingService>().send(
                                  channel: MessageChannel.frameChanged,
                                  parameter: true);
                            },
                          );
                        } else {
                          setState(() {
                            selectedFrameIndex = index;
                          });
                          stores.saveFrame(list[index]).then(
                            (value) {
                              //Navigator.pop(context);
                              serviceLocator<MessagingService>().send(
                                  channel: MessageChannel.frameChanged,
                                  parameter: true);
                            },
                          );
                        }
                      },
                      child: AnimatedContainer(
                          height: 120,
                          width: 120,
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Row(
                            children: [
                              Container(
                                width: 110,
                                padding: const EdgeInsets.all(10),
                                height: double.infinity,
                                child: _buildFrameImage(list[index]),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "${context.l10n.frameFlower} ${index + 1}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: 24,
                                height: 24,
                                margin: const EdgeInsets.only(right: 20),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: selectedFrameIndex == index
                                        ? AppColors.accentDark
                                        : Colors.grey.shade400,
                                    width: 0.5,
                                  ),
                                  color: Colors.white,
                                ),
                                child: selectedFrameIndex == index
                                    ? Center(
                                        child:
                                            AssetsClass.icons.circleCheck.svg(
                                          width: 24,
                                          height: 24,
                                        ),
                                      )
                                    : null,
                              )
                            ],
                          )),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    itemCount: list.length,
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

  Widget _buildFrameImage(String frameData) {
    try {
      // Kiểm tra xem có phải base64 string không
      if (_isBase64String(frameData)) {
        // Decode base64 và hiển thị bằng Image.memory
        return Image.memory(
          base64Decode(frameData),
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) {
            return _buildErrorWidget();
          },
        );
      }
      // Nếu là đường dẫn assets
      else if (frameData.startsWith('assets/')) {
        return Image.asset(
          frameData,
          fit: BoxFit.fitWidth,
          errorBuilder: (context, error, stackTrace) {
            return _buildErrorWidget();
          },
        );
      }
      // Nếu là đường dẫn file
      else {
        return Image.file(
          File(frameData),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildErrorWidget();
          },
        );
      }
    } catch (e) {
      debugPrint('Error loading frame image: $e');
      return _buildErrorWidget();
    }
  }

// Helper method để kiểm tra base64
  bool _isBase64String(String str) {
    try {
      // Kiểm tra độ dài và ký tự hợp lệ
      if (str.length < 10 || str.contains('/') || str.contains('assets')) {
        return false;
      }
      // Thử decode để kiểm tra
      base64Decode(str);
      return true;
    } catch (e) {
      return false;
    }
  }

// Widget hiển thị khi có lỗi
  Widget _buildErrorWidget() {
    return Container(
      color: Colors.grey.shade300,
      child: const Icon(
        Icons.broken_image,
        color: Colors.grey,
        size: 48,
      ),
    );
  }
}
