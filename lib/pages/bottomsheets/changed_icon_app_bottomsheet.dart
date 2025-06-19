import 'package:flutter/material.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/config.dart';
import 'package:lovejourney/cores/servicelocator/service_locator.dart';
import 'package:lovejourney/cores/shared.dart';
import 'package:lovejourney/cores/store/share_prefer.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';
import 'package:lovejourney/pages/popups/unlock_item_popup.dart';
import 'package:lovejourney/pages/settings/widgets/user_start_widget.dart';

class ChangedIconAppBottomsheet extends StatefulWidget {
  const ChangedIconAppBottomsheet({super.key});

  @override
  State<ChangedIconAppBottomsheet> createState() =>
      _ChangedIconAppBottomsheetState();
}

class _ChangedIconAppBottomsheetState extends State<ChangedIconAppBottomsheet> {
  String idAppIcon = '';

  final List<String> idUnlock = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    idAppIcon = Shared.instance.iconApp.id;
    idUnlock.addAll(serviceLocator<SharePrefer>().getListIconUnlock());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.all(15),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Configs.commonRadius),
                topRight: Radius.circular(Configs.commonRadius),
              )),
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Text(
                            context.l10n.changeIconApp,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: UserStartWidget(),
                        ),
                      ],
                    ),
                  ),
                  GridView.builder(
                    itemCount: Configs.listIcon.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        crossAxisCount: 4),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        if (idUnlock.contains(Configs.listIcon[index].id)) {
                          setState(() {
                            idAppIcon = Configs.listIcon[index].id;
                          });
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => UnlockItemPopup(
                                    title: Configs.listIcon[index].id,
                                    itemImage: Image.asset(
                                      Configs.listIcon[index].path,
                                      width: 70,
                                      height: 70,
                                    ),
                                  )).then(
                            (value) {
                              if (value is bool && value) {
                                idUnlock.add(Configs.listIcon[index].id);
                                serviceLocator<SharePrefer>()
                                    .saveListIconUnlock(idUnlock)
                                    .then(
                                  (value) {
                                    setState(() {});
                                  },
                                );
                              }
                            },
                          );
                        }
                      },
                      child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              border: idAppIcon == Configs.listIcon[index].id
                                  ? Border.all(
                                      width: 2, color: AppColors.accentDark)
                                  : null,
                              image: DecorationImage(
                                image: AssetImage(Configs.listIcon[index].path),
                              ),
                              borderRadius:
                                  BorderRadius.circular(Configs.commonRadius)),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Stack(
                            children: [
                              if (idAppIcon == Configs.listIcon[index].id)
                                Positioned.fill(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            color: AppColors.accentDark,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(3))),
                                        child: Icon(
                                          Icons.check,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              if (!idUnlock
                                  .contains(Configs.listIcon[index].id))
                                Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      color: Colors.black.withValues(alpha: .3),
                                      child: Row(
                                        spacing: 5,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          AssetsClass.images.imageStar
                                              .image(width: 12),
                                          Text(
                                            '${Shared.instance.startDefraul}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                  color: Colors.white,
                                                ),
                                          )
                                        ],
                                      ),
                                    ))
                            ],
                          )),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              context.l10n.cancel,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    color: AppColors.accentDark,
                                  ),
                            )),
                      ),
                      Expanded(
                        child: TextButton(
                            onPressed: () => Navigator.pop(context, idAppIcon),
                            style: TextButton.styleFrom(
                              backgroundColor: AppColors.accentDark,
                            ),
                            child: Text(
                              context.l10n.change,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    color: Colors.white,
                                  ),
                            )),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
