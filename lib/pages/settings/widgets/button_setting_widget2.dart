import 'package:flutter/material.dart';
import 'package:lovejourney/cores/app_colors.dart';

class ButtonSettingWidget2 extends StatelessWidget {
  const ButtonSettingWidget2(
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
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          icon ?? SizedBox(),
          SizedBox(width: 9,),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          child ?? SizedBox(),

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