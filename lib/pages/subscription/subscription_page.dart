import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/models/select_item_model.dart';
import 'package:lovejourney/cores/purchase/in_app_purchase.dart';
import 'package:lovejourney/cores/ultils.dart';

import 'dart:io' show Platform;

import 'package:lovejourney/cores/widgets/list_select_widget.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';
import 'package:lovejourney/pages/privacypolicy/privacypolicy_page.dart';
import 'package:lovejourney/pages/temr/temrs_of_condition_page.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsClass.images.imageBackgroundSubs.path),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: Center(
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(Icons.close_rounded, size: 16, color: Colors.black),
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    final theme = Theme.of(context);
    final heightBody = Device.height - MediaQuery.of(context).padding.top;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: heightBody * .05,
                ),
                Text(
                  'LoveJourney Premium', //context.l10n.versionPremium,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                      color: AppColors.accentDark),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 50,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 10,
                      children: [
                        Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        Text(
                          context.l10n.removeAds,
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        Text(context.l10n.unlockAlltools,
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  context.l10n.chooseYoursubscription,
                  style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600, color: Colors.white),
                ),
                SizedBox(height: 10),
                ListSelectWidget(
                  list: [
                    SelectItemModel(name: 'Weekly', price: 'đ 49.000'),
                    SelectItemModel(name: 'Monthly', price: 'đ 49.000'),
                    SelectItemModel(name: 'Yearly', price: 'đ 49.000')
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                      ),
                      child: Text(
                        context.l10n.recurringPaymentscancelanytime,
                        style: theme.textTheme.titleSmall
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accentDark,
                        minimumSize: Size(double.infinity, 42),
                      ),
                      child: Stack(
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: AssetsClass.images.imageDoubleChe
                                  .image(height: 42)),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                context.l10n.upgradePremium,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    TextButton(
                        onPressed: () => LocalInAppPurchase.inAppPurchase
                                .restorePurchases()
                                .then(
                              (value) {
                                Fluttertoast.showToast(msg: 'Restore success');
                              },
                            ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white10,
                          minimumSize: Size(double.infinity, 42),
                        ),
                        child: Text(
                          context.l10n.restore,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: Colors.white),
                        )),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        context.l10n.recurringPaymentscancelanytimeSub,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withValues(alpha: .5),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 40,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                ),
                onPressed: () => Navigator.push(
                  context,
                  createRouter(TermsOfConditionsPage()),
                ),
                child: Text(
                  context.l10n.termsofConditions,
                  style:
                      theme.textTheme.titleSmall?.copyWith(color: Colors.white),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                ),
                onPressed: () => Navigator.push(
                  context,
                  createRouter(PrivacyPolicyPage()),
                ),
                child: Text(
                  context.l10n.privacyPolicy,
                  style:
                      theme.textTheme.titleSmall?.copyWith(color: Colors.white),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: Platform.isIOS ? 20 : 0),
      ],
    );
  }
}
