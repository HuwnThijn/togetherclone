import 'package:flutter/material.dart';

class SavedPopup extends StatelessWidget {
  const SavedPopup({super.key, required this.imagePath, this.title});

  final String? title;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          Text(
            title ?? '',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.black87,
                ),
          ),
        ],
      ),
    );
  }
}
