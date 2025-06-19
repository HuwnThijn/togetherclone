import 'package:flutter/material.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/servicelocator/service_locator.dart';
import 'package:lovejourney/cores/store/share_prefer.dart';
import 'package:lovejourney/cores/widgets/keyboard_widget.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LockAppPage extends StatefulWidget {
  const LockAppPage({super.key});

  @override
  State<LockAppPage> createState() => _LockAppPageState();
}

class _LockAppPageState extends State<LockAppPage> {
  String passcode = '';
  String confirmPasscode = '';
  bool isConfirmStage = false;
  String errorMessage = '';

  void _onKeyPress(int value) {
    setState(() {
      if (!isConfirmStage) {
        if (passcode.length < 4) {
          passcode += value.toString();
        }
        if (passcode.length == 4) {
          isConfirmStage = true;
          errorMessage = '';
        }
      } else {
        if (confirmPasscode.length < 4) {
          confirmPasscode += value.toString();
        }
        if (confirmPasscode.length == 4) {
          if (confirmPasscode == passcode) {
            serviceLocator<SharePrefer>().savePassLockApp(passcode).then(
              (value) {
                Navigator.pop(context);
              },
            );
          } else {
            errorMessage = context.l10n.passcodeDoesnotmatch;
          }
        }
      }
    });
  }

  void _onDelete() {
    errorMessage = '';
    setState(() {
      if (!isConfirmStage) {
        if (passcode.isNotEmpty) {
          passcode = passcode.substring(0, passcode.length - 1);
        }
      } else {
        if (confirmPasscode.isNotEmpty) {
          confirmPasscode =
              confirmPasscode.substring(0, confirmPasscode.length - 1);
        } else {
          isConfirmStage = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AssetsClass.images.imageBackgroundLock.path),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: AssetsClass.icons.circleXmark.svg(),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        SizedBox(height: 5.h),
        AssetsClass.images.imageIconApp.image(width: 60),
        SizedBox(height: 10),
        Text(
          errorMessage.isEmpty
              ? !isConfirmStage
                  ? context.l10n.enterApasscodeof4digits
                  : context.l10n.reEnternewpasscode
              : errorMessage,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: errorMessage.isEmpty ? Colors.white : AppColors.errorDark),
        ),
        _buildPasscodeDots(!isConfirmStage ? passcode : confirmPasscode),
        SizedBox(height: 40),
        KeyBoardWidget(
          onChanged: _onKeyPress,
          onDelete: _onDelete,
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
