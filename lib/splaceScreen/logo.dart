import 'package:flutter/material.dart';

class logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.pink.shade400, Colors.blue.shade100]),
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 150,
                  width: 150,
                  child: Image(image: AssetImage("assets/image/logo.png"))),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text(
                  "Play Tune",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
