import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/extentions/messagingservice.dart';
import 'package:lovejourney/cores/models/loveday_model.dart';
import 'package:lovejourney/cores/servicelocator/service_locator.dart';
import 'package:lovejourney/cores/store/share_prefer.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';
import 'package:lovejourney/pages/popups/changed_date_popup.dart';
import 'package:lovejourney/pages/set_date/widgets/date_picker_input.dart';

class StartDatingPage extends StatefulWidget {
  const StartDatingPage({super.key});

  @override
  State<StartDatingPage> createState() => _StartDatingPageState();
}

class _StartDatingPageState extends State<StartDatingPage> {
  LoveDayModel? loveData;
  DateTime dating = DateTime.now();
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadLoveData();
  }

  void _loadLoveData() async {
    try {
      loveData = await serviceLocator<SharePrefer>().getLoveday();
      if (loveData != null) {
        dating = DateTime.fromMillisecondsSinceEpoch(loveData!.loveday!);
      } else {
        dating = DateTime.now();
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        dating = DateTime.now();
      });
    }
  }

  void getLoveData() async {
    loveData = await serviceLocator<SharePrefer>().getLoveday();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: isLoading ? _buildLoadingWidget() : _buildBody(),
    );
  }

  Widget _buildLoadingWidget() {
    return const Center(
      child: CupertinoActivityIndicator(
        radius: 20,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.accentDark,
      elevation: 0,
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: AssetsClass.icons.arrowRight.svg(
            color: Colors.white,
            width: 24,
            height: 24,
          )),
      title: Text(
        context.l10n.startDating,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        spacing: 20,
        children: [
          DatePickerInput(
            selectedDate: dating,
            onTap: _showDatePickerPopup,
            placeholder: 'DD/MM/YYYY',
          ),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Future<void> _showDatePickerPopup() async {
    final picked = await showDialog<DateTime>(
        context: context,
        barrierDismissible: true,
        builder: (context) => ChangedDatePopup(
              initialDate: dating,
              title: context.l10n.pickaDate,
              maximumDate: DateTime.now(),
            ));
    if (picked != null) {
      setState(() {
        dating = picked;
      });
    }
  }

  Widget _buildSaveButton() {
    final bool hasChanged = loveData?.loveday != null
        ? dating.millisecondsSinceEpoch != loveData!.loveday
        : true;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: hasChanged ? _onSave : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: hasChanged ? AppColors.accentDark : Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          elevation: 0,
        ),
        child: Text(
          context.l10n.save,
          style: TextStyle(
            color: dating != DateTime.now() ? Colors.white : Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _onSave() async {
    try {
      // Giữ nguyên gender nếu có, chỉ update loveday
      final updatedLoveDay = LoveDayModel(
        gender: loveData?.gender ?? '',
        loveday: dating.millisecondsSinceEpoch,
        dobMen: loveData!.dobMen,
        dobWoman: loveData!.dobWoman,
        nameMen: loveData!.nameMen,
        nameWoman: loveData!.nameWoman,
      );

      await serviceLocator<SharePrefer>().saveLoveDay(updatedLoveDay);
      if (mounted) {
        serviceLocator<MessagingService>().send(channel: MessageChannel.lovedayChanged, parameter: true);
        Navigator.pop(context, dating);
      }
    } catch (e) {}
  }
}
