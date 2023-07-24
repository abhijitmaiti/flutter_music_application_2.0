import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
import 'package:play/home_screen.dart';
import 'package:play/splaceScreen/splace_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final splashController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    SplashScreenController.find.startAnimation();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromARGB(255, 55, 54, 54), Colors.black]),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 35),
          child: Stack(
            children: [
              Obx(
                () => AnimatedPositioned(
                  duration: const Duration(milliseconds: 1600),
                  top: splashController.animate.value ? 0 : -30,
                  left: splashController.animate.value ? 0 : -30,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 1600),
                    opacity: splashController.animate.value ? 1 : 0,
                    child: const Image(
                        image: AssetImage("assets/image/BWsplace1.png")),
                  ),
                ),
              ),
              Obx(
                () => AnimatedPositioned(
                  duration: const Duration(milliseconds: 2000),
                  top: 85,
                  left: splashController.animate.value ? 30.0 : -80,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 2000),
                    opacity: splashController.animate.value ? 1 : 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                          child: Text(
                            "Play Beats",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text("Enjoy your ",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 158, 155, 155),
                                  fontSize: 35,
                                  fontWeight: FontWeight.w500)),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                          child: Text("Favourite Music ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Obx(
                () => AnimatedPositioned(
                  duration: const Duration(milliseconds: 2400),
                  bottom: splashController.animate.value ? 100 : 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 2000),
                    opacity: splashController.animate.value ? 1 : 0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
                      child: const Image(
                          image: AssetImage("assets/image/BWsplace2.png")),
                    ),
                  ),
                ),
              ),
              Obx(
                () => AnimatedPositioned(
                  duration: const Duration(milliseconds: 2400),
                  bottom: splashController.animate.value ? 60 : 0,
                  right: 30.0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 2000),
                    opacity: splashController.animate.value ? 1 : 0,
                    child: Container(
                      width: 100.0,
                      height: 99.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.music_note,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
