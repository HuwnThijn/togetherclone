import 'package:flutter/material.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/models/loveday_model.dart';
import 'package:lovejourney/cores/servicelocator/service_locator.dart';
import 'package:lovejourney/cores/shared.dart';
import 'package:lovejourney/cores/store/share_prefer.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';
import 'package:lovejourney/pages/gender/widgets/button_gender_widget.dart';
import 'package:lovejourney/pages/home_page.dart';

class ChangedGenderPage extends StatefulWidget {
  const ChangedGenderPage({super.key});

  @override
  State<ChangedGenderPage> createState() => _ChangedGenderPageState();
}

class _ChangedGenderPageState extends State<ChangedGenderPage> {
  String? gender;
  LoveDayModel? loveData;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadCurrentGender();
  }

  Future<void> _loadCurrentGender() async {
    try {
      final loveDay = await serviceLocator<SharePrefer>().getLoveday();
      setState(() {
        loveData = loveDay;
        gender = loveDay.gender.isNotEmpty ? loveDay.gender : null;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        gender = null;
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _buildBody(),
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
        context.l10n.yourGender,
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
          // Male option
          ButtonGenderWidget(
            icon: AssetsClass.icons.genderMale.svg(
              width: 24,
            ),
            label: context.l10n.male,
            value: "male",
            color: Colors.black87,
            selectedColor: AppColors.accentDark,
            selected: gender == "male",
            onTap: (value) {
              setState(() {
                gender = value;
              });
            },
          ),

          // Female option
          ButtonGenderWidget(
            icon: AssetsClass.icons.genderFemale.svg(
              width: 24,
            ),
            label: context.l10n.female,
            value: "female",
            color: Colors.black87,
            selectedColor: AppColors.accentDark,
            selected: gender == "female",
            onTap: (value) {
              setState(() {
                gender = value;
              });
            },
          ),

          // Save button
          _buildSaveButton(),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: gender != null ? _onSave : null,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              gender != null ? AppColors.accentDark : Colors.grey.shade300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          elevation: 0,
        ),
        child: Text(
          context.l10n.save,
          style: TextStyle(
            color: gender != null ? Colors.white : Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _onSave() async {
    try {
      final updatedLoveDay = LoveDayModel(
        gender: gender ?? '',
        loveday: loveData?.loveday,
        dobMen: loveData!.dobMen,
        dobWoman: loveData!.dobWoman,
        nameMen: loveData!.nameMen,
        nameWoman: loveData!.nameWoman,
      );

      await serviceLocator<SharePrefer>().saveLoveDay(updatedLoveDay);
      // Return với gender đã chọn
      Navigator.pop(context, gender);
    } catch (e) {}
  }
}
