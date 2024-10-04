import 'package:flutter/material.dart';
import 'package:tic_tac_toe/components/style/constants.dart';

class ReplayButton extends StatelessWidget {
  const ReplayButton({super.key, required this.onTap, required this.title});
  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset('${assetPath}but_shape.png'),
          Text(
            title,
            style: h5Style,
          ),
        ],
      ),
    );
  }
}
