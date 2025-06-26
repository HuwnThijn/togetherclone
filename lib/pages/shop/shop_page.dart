import 'package:flutter/material.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int cash = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
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
        context.l10n.shopmemory,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      actions: [
        Container(
          height: 24,
          width: 70,
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.white,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                AssetsClass.icons.cash.svg(
                  width: 22,
                  height: 18,
                ),
                const SizedBox(width: 4),
                Text(
                  ': $cash',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}