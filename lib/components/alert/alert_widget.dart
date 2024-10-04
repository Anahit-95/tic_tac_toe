import 'package:flutter/material.dart';
import 'package:tic_tac_toe/components/buttons/image_button.dart';
import 'package:tic_tac_toe/components/buttons/play_button.dart';
import 'package:tic_tac_toe/components/buttons/replay_button.dart';
import 'package:tic_tac_toe/components/style/constants.dart';
import 'package:tic_tac_toe/components/style/style.dart';

class AlertWidget {
  Future<void> showGameAlertDialog(
      {required BuildContext context,
      required String title,
      Widget? content,
      String? confirmButtonTitle,
      VoidCallback? onClose,
      VoidCallback? onConfirm}) {
    return showDialog(
        context: context,
        builder: (context) {
          return Material(
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20 * grw(context)),
              alignment: Alignment.center,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                // Makes the content scrollable if it overflows
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: ImageButton(
                          onTap: () {
                            onClose != null
                                ? onClose.call()
                                : Navigator.pop(context);
                          },
                          imagePath: 'closer.png',
                        )),
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 40 * grw(context)),
                          child: Image.asset(
                            '${assetPath}small_modal_body.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 18 * grw(context), bottom: 100),
                                child: Text(
                                  title,
                                  style: h4Style,
                                ),
                              ),
                              if (content != null) content,
                            ],
                          ),
                        ),
                        if (confirmButtonTitle != null && onConfirm != null)
                          Positioned(
                              bottom: 0,
                              left: MediaQuery.of(context).size.width * 0.16,
                              child: PlayButton(
                                  onTap: () => onConfirm.call(), title: 'PLAY'))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void showCenterSnackBar(BuildContext context, String message) {
    showDialog(
        barrierColor: whiteColor.withOpacity(.1),
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 1), () {
            if (context.mounted) {
              Navigator.of(context, rootNavigator: true).pop();
            }
          });
          return Align(
            alignment: Alignment.center,
            child: Container(
              height: 87 * grw(context),
              alignment: Alignment.center,
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(horizontal: 60 * grw(context)),
              padding: EdgeInsets.symmetric(vertical: 23 * grw(context)),
              decoration: BoxDecoration(
                  color: purpleColor, borderRadius: BorderRadius.circular(54)),
              child: Material(
                color: Colors.transparent,
                child: Text(
                  message,
                  style: h3Style,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        });
  }

  void showFailedMessage(BuildContext context, {VoidCallback? onClose}) {
    showDialog(
      context: context,
      builder: (context) {
        Future.delayed(const Duration(seconds: 1), () {
          if (context.mounted) {
            Navigator.of(context, rootNavigator: true).pop();
            onClose?.call();
          }
        });
        return Align(
          alignment: Alignment.center,
          child: Image.asset('${assetPath}rednew.png'),
        );
      },
    );
  }

  void showWinMessage(BuildContext context, {VoidCallback? onClose}) {
    showDialog(
      context: context,
      builder: (context) {
        Future.delayed(const Duration(seconds: 1), () {
          if (context.mounted) {
            Navigator.of(context, rootNavigator: true).pop();
            onClose?.call();
          }
        });
        return Align(
          alignment: Alignment.center,
          child: Image.asset('${assetPath}greennew.png'),
        );
      },
    );
  }

  void showResultDialog(
      {required BuildContext context,
      required String title,
      required String bgPath,
      required String buttonText,
      required VoidCallback onConfirm,
      double buttomPadding = 25}) {
    showDialog(
        context: context,
        builder: (context) {
          return Material(
            color: Colors.transparent,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: Stack(
                        children: [
                          Image.asset('${assetPath}closer_bg.png'),
                          ImageButton(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            imagePath: 'closer.png',
                          ),
                        ],
                      )),
                  Stack(
                    children: [
                      Image.asset(bgPath),
                      Positioned(
                          left: 0,
                          right: 0,
                          top: 55,
                          child: Text(
                            title,
                            style: h2Style,
                            textAlign: TextAlign.center,
                          )),
                      Positioned(
                          left: 0,
                          right: 0,
                          bottom: buttomPadding,
                          child: ReplayButton(
                              onTap: onConfirm, title: buttonText)),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
