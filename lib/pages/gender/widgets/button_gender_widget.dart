import 'package:flutter/material.dart';
import 'package:lovejourney/gen/assets.gen.dart';

class ButtonGenderWidget extends StatelessWidget {
  const ButtonGenderWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.selectedColor,
    required this.selected,
    required this.onTap,
    this.showCheckIcon = true,
    this.animationDuration = const Duration(milliseconds: 200),
    this.borderRadius = 16.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  });

  final Widget icon;
  final String label;
  final String value;
  final Color color;
  final Color selectedColor;
  final bool selected;
  final ValueChanged<String> onTap;
  final bool showCheckIcon;
  final Duration animationDuration;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(value),
      child: AnimatedContainer(
        duration: animationDuration,
        padding: padding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: selected ? selectedColor : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: selectedColor.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            if (showCheckIcon) _buildCheckIcon(),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckIcon() {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? selectedColor : Colors.grey.shade400,
          width: 0.5,
        ),
        color: Colors.white,
      ),
      child: selected
          ? Center(
              child: AssetsClass.icons.circleCheck.svg(
                width: 24,
                height: 24,
              ),
            )
          : null,
    );
  }
}