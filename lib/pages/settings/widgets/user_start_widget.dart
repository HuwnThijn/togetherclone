import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/extentions/messagingservice.dart';
import 'package:lovejourney/cores/purchase/in_app_purchase.dart';
import 'package:lovejourney/cores/servicelocator/service_locator.dart';
import 'package:lovejourney/cores/store/share_prefer.dart';
import 'package:lovejourney/cores/ultils.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';
import 'package:lovejourney/pages/in_app/in_app_product_page.dart';

class UserStartWidget extends StatefulWidget {
  const UserStartWidget({super.key, this.isAddStart = true});

  final bool isAddStart;

  @override
  State<UserStartWidget> createState() => _UserStartWidgetState();
}

class _UserStartWidgetState extends State<UserStartWidget> {
  @override
  void initState() {
    super.initState();

    serviceLocator<MessagingService>().subscribe(
      this,
      channel: MessageChannel.startUserChanged,
      action: (val) => setState(() {}),
    );
  }

  @override
  void dispose() {
    super.dispose();

    serviceLocator<MessagingService>()
        .unsubscribe(this, channel: MessageChannel.startUserChanged);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.isAddStart) {
          //if (LocalInAppPurchase.listProduct.isNotEmpty) {
          Navigator.push(context, createRouter(InAppProductPage()));
          // } else {
          //   Fluttertoast.showToast(msg: context.l10n.functionunderdevelopment);
          // }
        }
      },
      child: Stack(
        children: [
          Container(
            padding: widget.isAddStart
                ? EdgeInsets.only(right: 20, left: 10, bottom: 2, top: 2)
                : EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            margin: widget.isAddStart ? EdgeInsets.only(top: 5) : null,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              spacing: 10,
              children: [
                AssetsClass.images.imageStar.image(width: 16),
                Text(
                  serviceLocator<SharePrefer>().getStarApp().toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          if (widget.isAddStart)
            Positioned(
                top: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff3996FF),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add_rounded,
                    size: 14,
                    color: Colors.white,
                  ),
                ))
        ],
      ),
    );
  }
}
