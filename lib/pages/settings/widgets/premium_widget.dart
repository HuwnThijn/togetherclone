import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lovejourney/cores/config.dart';
import 'package:lovejourney/cores/ultils.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';
import 'package:lovejourney/pages/subscription/subscription_page.dart';

class PremiumWidget extends StatelessWidget {
  const PremiumWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Fluttertoast.showToast(msg: context.l10n.functionunderdevelopment);
        //Navigator.push(context, createRouter(SubscriptionPage()));
      },
      child: Container(
        height: 105,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Configs.commonRadius),
          image: DecorationImage(
              image: AssetImage(AssetsClass.images.imageBgPremium.path),
              fit: BoxFit.cover),
        ),
        child: Row(
          children: [
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'LoveJourney',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Color(0xffF23141),
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    context.l10n.versionPremium,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Color(0xffF23141),
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    context.l10n.removeAdsandunlockfeatures,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
