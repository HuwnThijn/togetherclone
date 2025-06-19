import 'package:flutter/material.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/models/purchasable_product_model.dart';
import 'package:lovejourney/cores/purchase/in_app_purchase.dart';
import 'package:lovejourney/cores/servicelocator/service_locator.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';
import 'package:lovejourney/pages/settings/widgets/user_start_widget.dart';

class InAppProductPage extends StatefulWidget {
  const InAppProductPage({super.key});

  @override
  State<InAppProductPage> createState() => _InAppProductPageState();
}

class _InAppProductPageState extends State<InAppProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: AssetsClass.icons.arrowRight
              .svg(width: 24, color: AppColors.accentDark),
        ),
        elevation: 0,
        title: Text(
          context.l10n.shopstar,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.accentDark,
              ),
        ),
        actions: [
          UserStartWidget(
            isAddStart: false,
          ),
          SizedBox(width: 10)
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: LocalInAppPurchase.listProduct.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 150,
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10),
      itemBuilder: (context, index) =>
          _buildItem(LocalInAppPurchase.listProduct[index]),
    );
  }

  Widget _buildItem(PurchasableProduct item) {
    return InkWell(
      onTap: () {
        serviceLocator<LocalInAppPurchase>().buy(item);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xff3996FF).withValues(alpha: .1),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  AssetsClass.images.imageStar1.image(),
                  Text(
                    '+${item.coin} Diamonds',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Color(0xff3996FF)),
                  ),
                ],
              ),
            ),
            ColoredBox(
              color: Color(0xff3996FF),
              child: SizedBox(
                width: double.infinity,
                height: 30,
                child: Center(
                  child: Text(item.price,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
