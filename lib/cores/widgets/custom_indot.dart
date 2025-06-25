import 'package:flutter/material.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/shared.dart';

class CustomIndotWidget extends StatefulWidget {
  const CustomIndotWidget({super.key, required this.tabController});

  final TabController tabController;

  @override
  State<CustomIndotWidget> createState() => _CustomIndotWidgetState();
}

class _CustomIndotWidgetState extends State<CustomIndotWidget> {
  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    widget.tabController.removeListener(_handleTabChange);
    super.dispose();
  }

  void _handleTabChange() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: List.generate(
        widget.tabController.length,
        (index) => Container(
          height: 13,
          width: 13,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.tabController.index == index
                  ? Colors.white
                  : AppColors.unIndicatorColor(Shared.instance.isDarkMode)
                      .withValues(alpha: .3)),
        ),
      ),
    );
  }
}
