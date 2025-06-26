import 'package:flutter/material.dart';
import 'package:lovejourney/cores/extentions/messagingservice.dart';
import 'package:lovejourney/cores/servicelocator/service_locator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/config.dart';
import 'package:lovejourney/cores/shared.dart';
import 'package:lovejourney/cores/ultils.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';
import 'package:lovejourney/pages/set_date/set_date_page.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  String keySelected = Shared.instance.languageCode.languageCode;


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
            colorFilter:
                ColorFilter.mode(AppColors.accentDark, BlendMode.srcATop),
            image: AssetImage(AssetsClass.images.imageBackgroundLove.path),
            fit: BoxFit.cover),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            AssetsClass.images.imageUndrawDocumentAnalysis
                .image(width: 200, color: AppColors.accentDark),
            SizedBox(height: 10),
            Center(
              child: Text(context.l10n.language,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ),
            Builder(builder: (context) {
              final list = Shared.instance.listLanguage.entries.toList();
              return ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => _buildItem(list[index]),
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemCount: list.length);
            }),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context, createRouter(SetDatePage()));
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  minimumSize:
                      Size(Device.width - 30, Configs.commonHeightButton),
                  backgroundColor: Shared.instance.isMainColor
                      ? AppColors.accentDark
                      : Configs.listColorTheme.first,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    context.l10n.select,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildItem(MapEntry<String, Map<String, String>> entry) {
    return InkWell(
      onTap: () {
        keySelected = entry.key;
        Shared.instance.setLanguage(entry.key);
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.color
                ?.withValues(alpha: .05)),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(
                  width: 2.5,
                  color: keySelected == entry.key
                      ? AppColors.accentDark
                      : Colors.transparent)),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Row(
            spacing: 10,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(entry.value['flag'] ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                  child: Text(
                entry.value['name'] ?? '',
                style: TextStyle(
                  fontSize: 16,
                ),
              )),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: keySelected == entry.key
                        ? AppColors.accentDark
                        : Colors.grey.shade400,
                    width: 0.5,
                  ),
                  color: Colors.white,
                ),
                child: keySelected == entry.key
                    ? Center(
                        child: AssetsClass.icons.circleCheck.svg(
                          width: 24,
                          height: 24,
                        ),
                      )
                    : null,
              )
            ],
          ),
        ),
      ),
      // child: Container(
      //   width: 160,
      //   padding: EdgeInsets.all(15),
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(15),
      //     border: Border.all(
      //         width: 2.5,
      //         color: keySelected == entry.key
      //             ? AppColors.ogrange
      //             : Colors.transparent),
      //     color: Colors.white10,
      //   ),
      //   child: Column(
      //     children: [
      //       Container(
      //         height: 70,
      //         width: 200,
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(Configs.commonRadius),
      //           image: DecorationImage(
      //               image: AssetImage(entry.value['flag'] ?? ''),
      //               fit: BoxFit.cover),
      //         ),
      //       ),
      //       SizedBox(height: 20),
      //       Text(entry.value['name'] ?? '',
      //           style: Theme.of(context).textTheme.titleSmall),
      //     ],
      //   ),
      // ),
    );
  }
}
