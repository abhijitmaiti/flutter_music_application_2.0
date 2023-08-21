import 'package:flutter/material.dart';
import 'package:play/home_screen.dart';
import 'package:play/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/onBoarding_model.dart';

class onBoardingScreen extends StatefulWidget {
  const onBoardingScreen({super.key});

  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  int currentPage = 0;
  PageController _pageController = PageController(initialPage: 0);

  AnimatedContainer dotIndicator(index) {
  return AnimatedContainer( 
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 10),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          color: currentPage == index
              ? Color.fromARGB(255, 254, 111, 1)
              : Colors.white,
          shape: BoxShape.circle),
    );
  }

  Future setOnBoard() async {
    SharedPreferences sps = await SharedPreferences.getInstance();
    onBoard = await sps.setBool('onBoard', true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setOnBoard();
  }

  @override
  Widget build(BuildContext context) {
    List<onBoarding> onBoardingContent = onBoarding.onBoardingContent;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.white])),
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: onBoardingContent.length,
                  itemBuilder: ((context, index) => Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Text(onBoardingContent[index].title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontSize: 27,
                                fontWeight: FontWeight.w300,
                              )),
                          SizedBox(
                            height: 70,
                          ),
                          Container(
                            child: Image.asset(onBoardingContent[index].image),
                          ),
                          SizedBox(
                            height: 70,
                          ),
                          RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: "Hello guys this is my ",
                                    ),
                                    TextSpan(
                                        text: "First App ",
                                        style: TextStyle(color: Colors.orange)),
                                    TextSpan(text: "in play store \nplease"),
                                    TextSpan(
                                        text: "Download",
                                        style: TextStyle(color: Colors.orange)),
                                    TextSpan(text: " and "),
                                    TextSpan(
                                        text: "Share ",
                                        style: TextStyle(color: Colors.orange)),
                                    TextSpan(text: "with your "),
                                    TextSpan(
                                        text: "Friends",
                                        style: TextStyle(color: Colors.orange)),
                                  ])),
                        ],
                      )),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      currentPage == onBoardingContent.length - 1
                          ? ElevatedButton(
                              style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all<Size>(
                                      Size.fromHeight(50)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 254, 111, 1))),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 50,
                                  right: 50,
                                ),
                                child: Text(
                                  "Get Started",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ))
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreen()));
                                  },
                                  child: Text(
                                    "Skip",
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.black),
                                  ),
                                ),
                                Row(
                                  children: List.generate(
                                      onBoardingContent.length,
                                      (index) => dotIndicator(index)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _pageController.nextPage(
                                        duration: Duration(milliseconds: 400),
                                        curve: Curves.easeInOut);
                                  },
                                  child: Text(
                                    "Next",
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
