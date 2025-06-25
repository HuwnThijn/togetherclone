import 'package:flutter/material.dart';

class FrameCard extends StatelessWidget {
  final String framePath;
  final bool isSelected;
  final VoidCallback onTap;
  final Widget? sampleImage;
  final double size;
  final Color selectedColor;

  const FrameCard({
    super.key,
    required this.framePath,
    required this.isSelected,
    required this.onTap,
    this.sampleImage,
    this.size = 120,
    this.selectedColor = const Color(0xFFFF6B81),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? selectedColor : Colors.transparent,
            width: 3,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: selectedColor.withOpacity(0.3),
                blurRadius: 8,
                spreadRadius: 1,
              ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Sample image (if provided)
            if (sampleImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: SizedBox(
                  width: size - 16,
                  height: size - 16,
                  child: sampleImage!,
                ),
              ),

            // Frame image
            Image.asset(
              framePath,
              width: size,
              height: size,
              fit: BoxFit.contain,
            ),

            // Selected indicator
            if (isSelected)
              Positioned(
                top: 5,
                right: 5,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: selectedColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}