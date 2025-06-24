import 'package:flutter/material.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/shared.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';
import 'package:lovejourney/pages/settings/widgets/more_settings_widget.dart';
import 'package:lovejourney/pages/settings/widgets/settings_widget.dart';

class CustomSidebar extends StatefulWidget {
  const CustomSidebar({super.key});

  @override
  State<CustomSidebar> createState() => _CustomSidebarState();
}

class _CustomSidebarState extends State<CustomSidebar> {
  bool shareAppEnabled = true;
  bool notificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.transparent, body: _buildBody());
  }

  Widget _buildBody() {
    return Stack(
      children: [
        // Background blur overlay
        GestureDetector(
          onTap: () => Navigator.pop(context, true),
          child: Container(
            color: Colors.black.withOpacity(0.3),
            width: double.infinity,
            height: double.infinity,
          ),
        ),

        // Sidebar content
        Positioned(
          top: 0,
          right: 0,
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(-2, 0),
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Close button
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context, true),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              //color: Colors.grey,
                              shape: BoxShape.circle,
                            ),
                            child: AssetsClass.icons.circleXmark.svg(
                              width: 30,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const Spacer(),

                        const Spacer(),
                        const SizedBox(width: 36), // Balance for close button
                      ],
                    ),
                  ),

                  // Menu items
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      spacing: 10,
                      children: [
                        SettingsWidget(),
                        MoreSettingsWidget(),                       
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
