import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:path_provider/path_provider.dart';
import 'package:play/home_screen.dart';
import 'package:play/models/onBoarding_model.dart';
import 'package:play/musicPlayer.dart';
import 'package:play/onBoardingScreen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

bool? onBoard;
Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox('favorite');
  await Hive.openBox('favorite2');
  await Hive.openBox('favorite3');
  await Hive.openBox('favorite4');
  SharedPreferences sp = await SharedPreferences.getInstance();
  onBoard = sp.getBool('onBoard') ?? false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: onBoard == true ? HomeScreen() : onBoardingScreen(),
    );
  }
}
