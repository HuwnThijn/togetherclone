import 'package:flutter/material.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/config.dart';
import 'package:lovejourney/cores/servicelocator/service_locator.dart';
import 'package:lovejourney/cores/store/share_prefer.dart';

class AnimationHeartWidget extends StatefulWidget {
  const AnimationHeartWidget({super.key});

  @override
  State<AnimationHeartWidget> createState() => _AnimationHeartWidgetState();
}

class _AnimationHeartWidgetState extends State<AnimationHeartWidget>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _shakeController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 2).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _shakeAnimation = Tween<double>(begin: 0, end: 5).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );

    _scaleController.repeat(reverse: true);
    _shakeController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataColor = serviceLocator<SharePrefer>().getMainColorString();
    return AnimatedBuilder(
        animation: Listenable.merge([_scaleAnimation, _shakeAnimation]),
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(_shakeAnimation.value, 0),
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Icon(
                Icons.favorite,
                color:
                    dataColor.isEmpty ? Colors.redAccent : AppColors.accentDark,
                size: 50,
              ),
            ),
          );
        });
  }
}
