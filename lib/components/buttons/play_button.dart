import 'package:flutter/material.dart';
import 'package:tic_tac_toe/components/style/constants.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({
    required this.onTap,
    required this.title,
    super.key,
  });
  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Image.asset(
            '${assetPath}button_bg.png',
            width: 216,
            fit: BoxFit.contain,
          ),
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Text(
              title,
              style: h4Style,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
