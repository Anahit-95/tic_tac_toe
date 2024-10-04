import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/components/alert/alert_widget.dart';
import 'package:tic_tac_toe/components/buttons/image_button.dart';
import 'package:tic_tac_toe/components/buttons/play_button.dart';
import 'package:tic_tac_toe/components/inputs/imput_field.dart';
import 'package:tic_tac_toe/components/mixin/state_addition.dart';
import 'package:tic_tac_toe/components/style/constants.dart';
import 'package:tic_tac_toe/components/style/style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with StateAddition {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _node = FocusNode();

  String? _errorText;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final result = Get.arguments?['result'];
      if (result != null) {
        _controller.text = Get.arguments?['userName'];
        _showResultDialog(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            '${assetPath}bg.svg',
            height: height_,
            width: width_,
            fit: BoxFit.cover,
          ),
          SvgPicture.asset(
            '${assetPath}pattern_background.svg',
            height: height_,
            width: width_,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 70 * grw(context),
              left: 24 * grw(context),
              right: 24 * grw(context),
              bottom: 40 * grw(context),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ImageButton(
                            onTap: () {},
                            imagePath: 'profile.png',
                          ),
                          ImageButton(
                            onTap: () {},
                            imagePath: 'settings.png',
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 17 * grw(context), bottom: 60 * grw(context)),
                        child: Image.asset('${assetPath}logo.png'),
                      ),
                      PlayButton(
                        title: 'PLAY',
                        onTap: _onTapPlay,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40 * grw(context)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ImageButton(imagePath: 'rules.png'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onTapPlay() {
    AlertWidget().showGameAlertDialog(
        context: context,
        title: 'WELCOME',
        confirmButtonTitle: 'PLAY',
        onClose: _onClose,
        onConfirm: _onConfirm,
        content: _PlayAlertContent(
          controller: _controller,
          node: _node,
          errorText: _errorText,
        ));
  }

  void _onConfirm() {
    if (_controller.text.isNotEmpty) {
      _errorText = null;
      Navigator.pop(context);
      Get.toNamed('/main_game', arguments: {'userName': _controller.text});
    } else {
      setState(() {
        _errorText = 'Please enter your name';
      });
    }
  }

  void _onClose() {
    _node.unfocus();
    Navigator.pop(context);
  }

  void _showResultDialog(String result) {
    String title;
    String bgPath;
    String buttonText;
    double buttomPadding = 50;
    switch (result) {
      case 'win':
        title = 'YOU\nWin!';
        bgPath = '${assetPath}win_bg.png';
        buttonText = 'PLAY AGAIN';
        buttomPadding = 50;
        break;
      case 'failed':
        title = 'YOU\nFAILED';
        bgPath = '${assetPath}failed_bg.png';
        buttonText = 'REPLAY';
        buttomPadding = 25;
        break;
      case 'draw':
        title = 'DRAW';
        bgPath = '${assetPath}draw_bg.png';
        buttonText = 'REPLAY';
        buttomPadding = 25;
        break;
      default:
        title = '';
        bgPath = '${assetPath}win_bg.png';
        buttonText = 'REPLAY';
    }

    AlertWidget().showResultDialog(
        context: context,
        title: title,
        bgPath: bgPath,
        buttonText: buttonText,
        buttomPadding: buttomPadding,
        onConfirm: _onReplay);
  }

  void _onReplay() {
    Navigator.of(context).pop();
    Get.toNamed('/main_game', arguments: {
      'userName': _controller.text.isNotEmpty ? _controller.text : 'You'
    });
  }
}

class _PlayAlertContent extends StatelessWidget {
  const _PlayAlertContent({
    required this.controller,
    required this.node,
    this.errorText,
  });

  final TextEditingController controller;
  final FocusNode node;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: brownColor,
          height: 2,
          width: 120,
          margin: EdgeInsets.only(bottom: 30 * grw(context)),
        ),
        const Text(
          'Enter YOUR NAME',
          style: h6Style,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
            50 * grw(context),
            33 * grw(context),
            50 * grw(context),
            18 * grw(context),
          ),
          child: InputField(
            controller: controller,
            node: node,
          ),
        ),
        if (errorText != null)
          Text(
            // 'Error comes here',
            errorText ?? '',
            style: bodyStyle.copyWith(color: textColor),
          ),
      ],
    );
  }
}
