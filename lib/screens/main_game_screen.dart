import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/components/alert/alert_widget.dart';
import 'package:tic_tac_toe/components/buttons/image_button.dart';
import 'package:tic_tac_toe/components/enums/enum.dart';
import 'package:tic_tac_toe/components/mixin/state_addition.dart';
import 'package:tic_tac_toe/components/style/constants.dart';
import 'package:tic_tac_toe/components/style/style.dart';
import 'package:tic_tac_toe/controller/robot_play_controller.dart';

class MainGameScreen extends StatefulWidget {
  const MainGameScreen({super.key, required this.userName});

  final String userName;

  @override
  State<MainGameScreen> createState() => _MainGameScreenState();
}

class _MainGameScreenState extends State<MainGameScreen> with StateAddition {
  final RobotPlayController _controller = Get.put(RobotPlayController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AlertWidget().showCenterSnackBar(context, 'Your Turn');
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
          Positioned(
              left: -220,
              top: -190,
              child: Image.asset('${assetPath}tic_tac_logo.png')),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(24 * grw(context),
                    70 * grw(context), 24 * grw(context), 78 * grw(context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImageButton(onTap: () => Get.back(), imagePath: 'home.png'),
                    ImageButton(onTap: () {}, imagePath: 'settings.png'),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(
                      horizontal: 24 * grw(context), vertical: 0),
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 3x3 grid
                    mainAxisSpacing: width_ * 0.02,
                    crossAxisSpacing: width_ * 0.02,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _controller.makeMove(index);
                        checkGameStatus(context);
                      },
                      child: Obx(() => Container(
                            decoration: BoxDecoration(
                                color: whiteColor.withOpacity(.2),
                                borderRadius: BorderRadius.circular(14)),
                            child: Center(
                              child: _controller.board[index] == Player.X
                                  ? Image.asset('${assetPath}tik_big.png')
                                  : _controller.board[index] == Player.O
                                      ? Image.asset('${assetPath}tac_big.png')
                                      : const SizedBox.shrink(),
                            ),
                          )),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: 40 * grw(context),
                    left: 24 * grw(context),
                    right: 24 * grw(context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _PlayersScore(
                        player: Player.X,
                        name: widget.userName,
                        games: 0,
                        wins: 0),
                    const _PlayersScore(
                      player: Player.O,
                      name: 'Bot',
                      games: 0,
                      wins: 0,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void checkGameStatus(BuildContext context) {
    if (_controller.gameStatus.value == GameStatus.win) {
      AlertWidget().showWinMessage(
        context,
        onClose: () => Get.offNamed('/home',
            arguments: {'result': 'win', 'userName': widget.userName}),
      );
    } else if (_controller.gameStatus.value == GameStatus.failed) {
      AlertWidget().showFailedMessage(
        context,
        onClose: () => Get.offNamed('/home',
            arguments: {'result': 'failed', 'userName': widget.userName}),
      );
    } else if (_controller.gameStatus.value == GameStatus.draw) {
      Get.offNamed('/home',
          arguments: {'result': 'draw', 'userName': widget.userName});
    }
  }
}

class _PlayersScore extends StatelessWidget with StateLessAddition {
  const _PlayersScore({
    required this.player,
    required this.name,
    required this.games,
    required this.wins,
  });

  final Player player;
  final String name;
  final int games;
  final int wins;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: width_(context) * 0.4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: player == Player.X
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.end,
            children: [
              player == Player.X
                  ? Image.asset('${assetPath}groupX.png')
                  : Image.asset('${assetPath}groupO.png'),
              Text(
                name,
                style: bodyStyle,
              ),
            ],
          ),
          Container(
            constraints: BoxConstraints(minWidth: width_(context) * 0.4),
            padding: EdgeInsets.fromLTRB(
              6 * grw(context),
              7 * grw(context),
              15 * grw(context),
              7 * grw(context),
            ),
            decoration: BoxDecoration(
              color: whiteColor.withOpacity(.6),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('${assetPath}games.png'),
                    SizedBox(width: 4 * grw(context)),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        '$games',
                        style: bodyStyle.copyWith(color: textColorBrown),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Image.asset('${assetPath}wins.png'),
                    SizedBox(width: 4 * grw(context)),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        '$wins',
                        style: bodyStyle.copyWith(color: textColorBrown),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
