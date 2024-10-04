import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/screens/home_screen.dart';
import 'package:tic_tac_toe/screens/main_game_screen.dart';
import 'package:tic_tac_toe/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      home: SplashScreen(),
      getPages: [
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(
          name: '/main_game',
          page: () => MainGameScreen(userName: Get.arguments['userName']),
        ),
      ],
    );
  }
}
