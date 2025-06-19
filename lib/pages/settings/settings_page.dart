import 'package:flutter/material.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/extentions/messagingservice.dart';
import 'package:lovejourney/cores/servicelocator/service_locator.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';
import 'package:lovejourney/pages/settings/widgets/more_settings_widget.dart';
import 'package:lovejourney/pages/settings/widgets/premium_widget.dart';
import 'package:lovejourney/pages/settings/widgets/settings_widget.dart';
import 'package:lovejourney/pages/settings/widgets/user_start_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    serviceLocator<MessagingService>().subscribe(
      this,
      channel: MessageChannel.themeChanged,
      action: (val) => setState(() {}),
    );
  }

  @override
  void dispose() {
    super.dispose();
    serviceLocator<MessagingService>().unsubscribe(
      this,
      channel: MessageChannel.themeChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: AssetsClass.icons.arrowRight
              .svg(width: 24, color: AppColors.accentDark),
        ),
        title: Text(
          context.l10n.settings,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.accentDark,
              ),
        ),
        actions: [UserStartWidget(), SizedBox(width: 10)],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        spacing: 10,
        children: [
          SettingsWidget(),
          PremiumWidget(),
          MoreSettingsWidget(),
        ],
      ),
    );
  }
}
