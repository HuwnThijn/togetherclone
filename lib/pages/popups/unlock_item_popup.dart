import 'package:flutter/material.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/servicelocator/service_locator.dart';
import 'package:lovejourney/cores/shared.dart';
import 'package:lovejourney/cores/store/share_prefer.dart';
import 'package:lovejourney/cores/ultils.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';
import 'package:lovejourney/pages/in_app/in_app_product_page.dart';

class UnlockItemPopup extends StatefulWidget {
  const UnlockItemPopup({super.key, this.itemImage, this.title = ''});

  final Widget? itemImage;
  final String title;

  @override
  State<UnlockItemPopup> createState() => _UnlockItemPopupState();
}

class _UnlockItemPopupState extends State<UnlockItemPopup> {
  bool isSucessfully = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(15),
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            spacing: 15,
            children: [
              widget.itemImage ?? SizedBox(),
              Text(
                !isSucessfully
                    ? '${context.l10n.unlock} ${widget.title}'
                    : '${context.l10n.unlock} ${widget.title} ${context.l10n.failed}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                !isSucessfully
                    ? '${context.l10n.doYouwanttounlock} ${widget.title}'
                    : context.l10n
                        .yourCoinsarenotenoughtounlockpleasegotothestoretobuymorecoins,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          context.l10n.cancel,
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: AppColors.accentDark,
                                  ),
                        )),
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          if (isSucessfully) {
                            Navigator.pop(context);
                            Navigator.push(
                                context, createRouter(InAppProductPage()));
                          } else {
                            int starUser =
                                serviceLocator<SharePrefer>().getStarApp();
                            if (starUser >= Shared.instance.startDefraul) {
                              starUser -= Shared.instance.startDefraul;
                              serviceLocator<SharePrefer>()
                                  .saveStarApp(starUser);
                              Navigator.pop(context, true);
                            } else {
                              setState(() {
                                isSucessfully = true;
                              });
                            }
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.accentDark,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 5,
                          children: [
                            Text(
                              !isSucessfully
                                  ? '${context.l10n.unlock} ${context.l10n.withx.toLowerCase()} ${Shared.instance.startDefraul}'
                                  : context.l10n.gotoShoping,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                            if (!isSucessfully)
                              AssetsClass.images.imageStar.image(width: 12),
                          ],
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
