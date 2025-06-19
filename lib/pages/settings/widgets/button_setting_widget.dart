import 'package:flutter/material.dart';
import 'package:lovejourney/cores/app_colors.dart';

class ButtonSettingWidget extends StatelessWidget {
  const ButtonSettingWidget(
      {super.key,
      required this.title,
      this.child,
      this.isLine = true,
      this.onPressed,
      this.icon});

  final String title;

  final Widget? child;

  final Widget? icon;

  final bool isLine;

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final childD = Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          child ?? SizedBox(),
          icon ??
              Icon(
                Icons.arrow_right_outlined,
                size: 30,
                color: AppColors.accentDark,
              ),
          SizedBox(width: icon == null ? 5 : 10)
        ],
      ),
    );

    return InkWell(
      onTap: onPressed,
      child: isLine
          ? Column(
              children: [
                childD,
                const Divider(
                  height: 1,
                  thickness: 1,
                ),
              ],
            )
          : childD,
    );
  }
}
