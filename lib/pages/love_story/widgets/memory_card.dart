import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lovejourney/l10n/l10n.dart';

class MemoryCard extends StatelessWidget {
  const MemoryCard({
    super.key,
    required this.title,
    required this.date,
    required this.imagePath,
  });

  final String title;
  final DateTime date;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final int daysLeft = -date.difference(DateTime.now()).inDays;

    return Container(
      height: 150,
      width: double.infinity,
      //margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Vùng text bên trái
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 22, top: 30, bottom: 18, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    (daysLeft == 1)
                        ? '1 ${context.l10n.dayLeft}'
                        : '$daysLeft ${context.l10n.daysLeft}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Hình ảnh bên phải, bo góc phải, có hiệu ứng mờ chuyển dần
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              height: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(
                    File(imagePath),
                    fit: BoxFit.cover,
                  ),
                  // Gradient mờ từ trái sang phải
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3, 
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.white,
                            Color(0xFFFFFFFF),
                            Color(0xCCFFFFFF),
                            Colors.transparent,
                          ],
                          stops: [.0, .1, .45, 1.0],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
