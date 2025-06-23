import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/models/loveday_model.dart';
import 'package:lovejourney/cores/models/male_model.dart';
import 'package:lovejourney/cores/routes/routes.dart';
import 'package:lovejourney/cores/servicelocator/service_locator.dart';
import 'package:lovejourney/cores/store/share_prefer.dart';
import 'package:lovejourney/cores/ultils.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';
import 'package:lovejourney/pages/bottomsheets/choose_option_camera_bottomsheet.dart';
import 'package:lovejourney/pages/home_page.dart';
import 'package:lovejourney/pages/popups/changed_date_popup.dart';
import 'package:lovejourney/pages/set_date/widgets/date_picker_input.dart';

class FemaleInfoPage extends StatefulWidget {
  const FemaleInfoPage({super.key});

  @override
  State<FemaleInfoPage> createState() => _FemaleInfoPageState();
}

class _FemaleInfoPageState extends State<FemaleInfoPage> {
  final TextEditingController _nameController = TextEditingController();
  DateTime? birthday = DateTime.now();
  String? avatar;
  MaleModel? maleData;
  LoveDayModel? loveData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _initializeData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final results = await Future.wait([
        _loadMaleDataAsync(),
        _loadLoveDataAsync(),
      ]);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error initializing data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _loadLoveDataAsync() async {
    try {
      loveData = await serviceLocator<SharePrefer>().getLoveday();
    } catch (e) {
      print('Error loading love data: $e');
    }
  }

  Future<void> _loadMaleDataAsync() async {
    try {
      maleData = await serviceLocator<SharePrefer>().getFemale();

      if (maleData != null) {
        _nameController.text = maleData!.name;
        avatar = maleData!.avatar;
        if (maleData?.birthday != null) {
          birthday = DateTime.fromMillisecondsSinceEpoch(maleData!.birthday);
        } else {
          birthday = null;
        }
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
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
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildBody() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 70,
            ),
            _buildAvatarSection(),
            const SizedBox(
              height: 70,
            ),
            _buildUsernameSection(),
            const SizedBox(
              height: 40,
            ),
            _buildBirthdaySection(),
            const SizedBox(
              height: 20,
            ),
            _buildSaveButton(),
          ],
        ),
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
        '${context.l10n.username} 2',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildAvatarSection() {
    return Stack(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration:
              getDecoration(serviceLocator<SharePrefer>().getShapeType()),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: ClipOval(
            child: loveData!.imageWoman.isNotEmpty
                ? Image.file(
                    File(loveData!.imageWoman),
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  )
                : AssetsClass.images.imageWoman.image(
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
          ),
        ),

        // Edit Icon
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: _showImagePicker,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: AssetsClass.icons.file.svg(
                width: 24,
                height: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showImagePicker() async {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => ChooseOptionCameraBottomsheet()).then(
      (value) {
        if (value is ImageSource) {
          serviceLocator<ImagePicker>()
              .pickImage(source: value)
              .then((value) async {
            if (value != null) {
              if (loveData!.imageWoman.isNotEmpty)
                File(loveData!.imageWoman).delete();
              serviceLocator<SharePrefer>()
                  .saveLoveDay(loveData!.copyWith(
                imageWoman: await copyImageToCache(await value.readAsBytes(),
                    name: DateTime.now().millisecondsSinceEpoch.toString()),
                imageMen: loveData!.imageWoman,
                nameWoman: loveData!.nameWoman,
                dobWoman: loveData!.dobWoman,
                nameMen: _nameController.text.trim().isEmpty
                    ? loveData!.nameMen
                    : _nameController.text.trim(),
                dobMen: loveData!.dobMen,
                gender: loveData!.gender,
                loveday: loveData!.loveday,
              ))
                  .then(
                (value) {
                  _loadLoveDataAsync();
                  setState(() {});
                },
              );
            }
          });
        }
      },
    );
  }

  Widget _buildUsernameSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(
          '${context.l10n.username.toUpperCase()}: ',
          style: TextStyle(color: Colors.grey.shade500, fontSize: 10),
        ),
        TextFormField(
          controller: _nameController,
          cursorColor: AppColors.accentLight,
          canRequestFocus: true,
          onChanged: (value) => setState(() {}),
          decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: Theme.of(context).scaffoldBackgroundColor,
              hintText: loveData!.nameWoman.isNotEmpty
                  ? loveData!.nameWoman
                  : 'Username',
              hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.color
                      ?.withValues(alpha: .3)),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.transparent)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.transparent)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.transparent))),
        )
      ],
    );
  }

  Widget _buildBirthdaySection() {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${context.l10n.birthday.toUpperCase()}:',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 10)),
        DatePickerInput(
          selectedDate: loveData!.dobWoman.isNotEmpty
              ? DateTime.tryParse(loveData!.dobWoman)
              : null,
          onTap: _showDatePickerPopup,
          placeholder: 'DD/MM/YYYY',
        ),
      ],
    );
  }

  Future<void> _showDatePickerPopup() async {
    final picked = await showDialog<DateTime>(
        context: context,
        barrierDismissible: true,
        builder: (context) => ChangedDatePopup(
              initialDate: loveData!.dobWoman.isNotEmpty &&
                      DateTime.tryParse(loveData!.dobWoman) != null
                  ? DateTime.parse(loveData!.dobWoman)
                  : DateTime.now(),
              title: context.l10n.pickaDate,
              maximumDate: DateTime.now(),
            ));
    if (picked != null) {
      setState(() {
        loveData!.dobWoman = picked.toString();
      });
    }
  }

  Widget _buildSaveButton() {
    final bool hasChanged = loveData?.loveday != null
        ? DateTime.tryParse(loveData!.dobWoman)?.millisecondsSinceEpoch !=
            loveData!.loveday
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
            color: DateTime.tryParse(loveData!.dobWoman) != DateTime.now()
                ? Colors.white
                : Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _onSave() async {
    try {
      await serviceLocator<SharePrefer>().saveLoveDay(loveData!.copyWith(
        nameWoman: _nameController.text.trim().isEmpty
            ? loveData!.nameWoman
            : _nameController.text.trim(),
        dobWoman: loveData!.dobWoman,
        imageWoman: loveData!.imageWoman,
        nameMen: loveData!.nameMen,
        dobMen: loveData!.dobMen,
        imageMen: loveData!.imageMen,
        gender: loveData!.gender,
        loveday: loveData!.loveday,
      ));
      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {}
  }
}
