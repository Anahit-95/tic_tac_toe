import 'package:flutter/material.dart';
import 'package:tic_tac_toe/components/style/constants.dart';

class ImageButton extends StatelessWidget {
  const ImageButton({
    required this.imagePath,
    this.onTap,
    super.key,
  });

  final VoidCallback? onTap;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap, child: Image.asset('$assetPath$imagePath'));
  }
}
