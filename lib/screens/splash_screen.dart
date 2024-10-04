import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/components/mixin/state_addition.dart';
import 'package:tic_tac_toe/components/style/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with StateAddition, SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Get.offNamed('/home');
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
          Center(
            child: Image.asset('${assetPath}logo.png'),
          )
        ],
      ),
    );
  }
}
