import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lovejourney/cores/enumlist.dart';
import 'package:lovejourney/cores/ultils.dart';

class UserProfileWidget extends StatelessWidget {
  final String imagePath;
  final String username;
  final String dateOfBirth;
  final String framePath;
  final ShapeType shapeType;
  final double size;
  final VoidCallback? onTap;
  final String defaultUsername;
  final Widget defaultImage;

  const UserProfileWidget({
    super.key,
    required this.imagePath,
    required this.username,
    required this.dateOfBirth,
    this.framePath = '',
    required this.shapeType,
    this.size = 90,
    this.onTap,
    this.defaultUsername = 'Username',
    required this.defaultImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Avatar with frame
        SizedBox(
          width: size + 40,
          height: size + 40,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Profile image with shape decoration
              Container(
                height: size,
                width: size,
                decoration: getDecoration(shapeType),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: imagePath.isNotEmpty
                    ? Image.file(
                        File(imagePath),
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : defaultImage,
              ),
              
              // Optional frame overlay
              if (framePath.isNotEmpty)
                SizedBox(
                  height: size + 30,
                  width: size + 30,
                  child: buildFrameImage(framePath)
                ),
            ],
          ),
        ),
        
        const SizedBox(height: 5),
        
        // Username
        Text(
          username.isNotEmpty ? username : defaultUsername,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black87),
        ),
        
        const SizedBox(height: 5),
        
        // Date of birth
        Text(
          _formatDate(dateOfBirth),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.black54),
        )
      ],
    );
  }

  // Format date method
  String _formatDate(String dateString) {
    if (dateString.isEmpty) return 'DD/MM/YYYY';
    
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return 'DD/MM/YYYY';
    }
  }

  Widget buildFrameImage(String frameData) {
  if (frameData.isEmpty) {
    return Image.asset('assets/frames/frame1.png'); // Frame mặc định
  }
  
  if (frameData.startsWith('assets/')) {
    return Image.asset(frameData);
  } 
  
  try {
    return Image.memory(base64Decode(frameData));
  } catch (e) {
    return Image.asset('assets/frames/frame1.png'); // Frame mặc định
  }
}
}