import 'package:flutter/material.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/enumlist.dart';
import 'package:lovejourney/cores/servicelocator/service_locator.dart';
import 'package:lovejourney/cores/shared.dart';
import 'package:lovejourney/cores/store/share_prefer.dart';
import 'package:lovejourney/cores/ultils.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';
import 'package:lovejourney/pages/popups/unlock_item_popup.dart';
import 'package:lovejourney/pages/settings/widgets/user_start_widget.dart';

class ChangedShapeAvatarBottomsheet extends StatefulWidget {
  const ChangedShapeAvatarBottomsheet({super.key, required this.assertImage});

  final String assertImage;

  @override
  State<ChangedShapeAvatarBottomsheet> createState() =>
      _ChangedShapeAvatarBottomsheetState();
}

class _ChangedShapeAvatarBottomsheetState
    extends State<ChangedShapeAvatarBottomsheet> {
  late ShapeType keySelected;

  final List<String> listUnlock = [];

  @override
  void initState() {
    super.initState();
    keySelected = serviceLocator<SharePrefer>().getShapeType();
    listUnlock.addAll(serviceLocator<SharePrefer>().getListShapePurchase());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: InkWell(onTap: () => Navigator.of(context).pop())),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Text(context.l10n.changeShapeAvatar,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium),
                      ),
                      Positioned(
                        right: 0,
                        child: UserStartWidget(),
                      )
                    ],
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: ShapeType.values.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 90,
                      crossAxisCount: 4),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      if (listUnlock.contains(ShapeType.values[index].name)) {
                        setState(() {
                          keySelected = ShapeType.values[index];
                        });
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => UnlockItemPopup(
                                  itemImage: AssetsClass.images.imageStar
                                      .image(width: 66),
                                ));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: keySelected == ShapeType.values[index]
                                ? AppColors.accentDark
                                : Colors.transparent,
                            width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Stack(
                        children: [
                          if (keySelected == ShapeType.values[index])
                            Positioned(
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: AppColors.accentDark,
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              margin: EdgeInsets.only(bottom: 5),
                              decoration:
                                  getDecoration(ShapeType.values[index]),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Image.asset(
                                widget.assertImage,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          ),
                          if (!listUnlock
                              .contains(ShapeType.values[index].name))
                            Positioned(
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Color(0xff1D99FF),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 3),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    spacing: 5,
                                    children: [
                                      Text(
                                        '${Shared.instance.startDefraul}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                      AssetsClass.images.imageStar
                                          .image(width: 14)
                                    ],
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
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
                          onPressed: () => Navigator.pop(context, keySelected),
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
            ),
          ),
        ),
      ],
    );
  }
}
