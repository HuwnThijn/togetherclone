import 'package:flutter/material.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/servicelocator/service_locator.dart';
import 'package:lovejourney/cores/store/share_prefer.dart';
import 'package:lovejourney/cores/widgets/keyboard_widget.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';

class ComfirmPassBottomsheet extends StatefulWidget {
  const ComfirmPassBottomsheet({super.key});

  @override
  State<ComfirmPassBottomsheet> createState() => _ComfirmPassBottomsheetState();
}

class _ComfirmPassBottomsheetState extends State<ComfirmPassBottomsheet> {
  String errorMessage = '';
  String confirmPasscode = '';

  late final String userPasscode;

  @override
  void initState() {
    super.initState();
    userPasscode = serviceLocator<SharePrefer>().getPassLockApp();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.accentDark,
        appBar: AppBar(
          backgroundColor: AppColors.accentDark,
          elevation: 0,
          leading: SizedBox(),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        AssetsClass.images.imageLock.image(width: 60),
        SizedBox(height: 10),
        Text(
          errorMessage.isEmpty
              ? context.l10n.enterApasscodeof4digits
              : errorMessage,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: errorMessage.isEmpty ? Colors.white : AppColors.errorDark),
        ),
        _buildPasscodeDots(confirmPasscode),
        SizedBox(height: 40),
        KeyBoardWidget(
          onChanged: (val) {
            confirmPasscode += val.toString();
            if (confirmPasscode.length == 4) {
              if (confirmPasscode == userPasscode) {
                Navigator.pop(context, true);
              } else {
                errorMessage = context.l10n.passcodeDoesnotmatch;
              }
            } else {
              setState(() {});
            }
          },
          onDelete: () {
            setState(() {
              if (confirmPasscode.isNotEmpty) {
                confirmPasscode =
                    confirmPasscode.substring(0, confirmPasscode.length - 1);
              }
            });
          },
        ),
      ],
    );
  }

  Widget _buildPasscodeDots(String code) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: List.generate(4, (index) {
        bool filled = index <= code.length;
        return _buildItemCodePass(
            isChoose: filled, isHaveNumber: index < code.length);
      }),
    );
  }

  Widget _buildItemCodePass(
      {bool isChoose = false, bool isHaveNumber = false}) {
    return SizedBox(
      height: 50,
      width: 30,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (isHaveNumber)
            Center(
              child: Text(
                '*',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: errorMessage.isEmpty
                          ? Colors.white
                          : AppColors.errorDark,
                      fontSize: 32,
                    ),
              ),
            ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Divider(
              color: isChoose
                  ? errorMessage.isEmpty
                      ? Colors.white
                      : AppColors.errorDark
                  : Colors.white10,
            ),
          )
        ],
      ),
    );
  }
}
