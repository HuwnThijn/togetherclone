import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/extentions/messagingservice.dart';
import 'package:lovejourney/cores/models/loveday_model.dart';
import 'package:lovejourney/cores/models/male_model.dart';
import 'package:lovejourney/cores/routes/routes.dart';
import 'package:lovejourney/cores/servicelocator/service_locator.dart';
import 'package:lovejourney/cores/store/share_prefer.dart';
import 'package:lovejourney/cores/ultils.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';
import 'package:lovejourney/pages/bottomsheets/choose_option_camera_bottomsheet.dart';
import 'package:lovejourney/pages/popups/changed_date_popup.dart';
import 'package:lovejourney/pages/set_date/widgets/date_picker_input.dart';

class MaleInfoPage extends StatefulWidget {
  const MaleInfoPage({super.key});

  @override
  State<MaleInfoPage> createState() => _MaleInfoPageState();
}

class _MaleInfoPageState extends State<MaleInfoPage> {
  final TextEditingController _nameController = TextEditingController();
  DateTime? birthday = DateTime.now();
  String? avatar;
  MaleModel? maleData;
  LoveDayModel? loveData;
  bool isLoading = true;
  String frame = '';

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
    loveData = await serviceLocator<SharePrefer>().getLoveday();
    frame = serviceLocator<SharePrefer>().getFrameUser();
    isLoading = false;
    setState(() {});
  }

  Future<void> _loadMaleDataAsync() async {
    try {
      maleData = await serviceLocator<SharePrefer>().getMale();

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
        '${context.l10n.username} 1',
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
            child: loveData!.imageMen.isNotEmpty
                ? Image.file(
                    File(loveData!.imageMen),
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  )
                : AssetsClass.images.imageMen.image(
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
    showDialog(
        context: context,
        builder: (context) => ChooseOptionCameraBottomsheet()).then(
      (value) {
        if (value is ImageSource) {
          serviceLocator<ImagePicker>()
              .pickImage(source: value)
              .then((value) async {
            if (value != null) {
              if (loveData!.imageMen.isNotEmpty) {
                File(loveData!.imageMen).delete();
              }
              serviceLocator<SharePrefer>()
                  .saveLoveDay(loveData!.copyWith(
                imageMen: await copyImageToCache(await value.readAsBytes(),
                    name: DateTime.now().millisecondsSinceEpoch.toString()),
                imageWoman: loveData!.imageWoman,
                nameWoman: loveData!.nameWoman,
                dobWoman: loveData!.dobWoman,
                nameMen: loveData!.nameMen,
                dobMen: loveData!.dobMen,
                gender: loveData!.gender,
                loveday: loveData!.loveday,
              ))
                  .then(
                (value) {
                  serviceLocator<MessagingService>().send(
                      channel: MessageChannel.userDataChanged, parameter: true);
                  _loadLoveDataAsync();
                  //setState(() {});
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
              hintText:
                  loveData!.nameMen.isNotEmpty ? loveData!.nameMen : 'Username',
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
          selectedDate: loveData!.dobMen.isNotEmpty
              ? DateTime.tryParse(loveData!.dobMen)
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
              initialDate: loveData!.dobMen.isNotEmpty &&
                      DateTime.tryParse(loveData!.dobMen) != null
                  ? DateTime.parse(loveData!.dobMen)
                  : DateTime.now(),
              title: context.l10n.pickaDate,
              maximumDate: DateTime.now(),
            ));
    if (picked != null) {
      setState(() {
        loveData!.dobMen = picked.toString();
      });
    }
  }

  Widget _buildSaveButton() {
    bool hasUsername = _nameController.text.trim().isNotEmpty ||
        (loveData?.nameMen != null && loveData!.nameMen.isNotEmpty);
    bool hasBirthday = loveData?.dobMen != null &&
        loveData!.dobMen.isNotEmpty &&
        DateTime.tryParse(loveData!.dobMen) != null;
    bool canSave = hasUsername && hasBirthday;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: canSave ? _onSave : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: canSave ? AppColors.accentDark : Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          elevation: 0,
        ),
        child: Text(
          context.l10n.save,
          style: TextStyle(
            color: DateTime.tryParse(loveData!.dobMen) != DateTime.now()
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
        nameWoman: loveData!.nameWoman,
        dobWoman: loveData!.dobWoman,
        imageWoman: loveData!.imageWoman,
        nameMen: _nameController.text.trim().isEmpty
            ? loveData!.nameMen
            : _nameController.text.trim(),
        dobMen: loveData!.dobMen,
        imageMen: loveData!.imageMen,
        gender: loveData!.gender,
        loveday: loveData!.loveday,
      ));
      if (mounted) {
        serviceLocator<MessagingService>()
            .send(channel: MessageChannel.userDataChanged, parameter: true);
        Navigator.popUntil(
          context,
          ModalRoute.withName(Routes.homePage),
        );
      }
    } catch (e) {}
  }
}
