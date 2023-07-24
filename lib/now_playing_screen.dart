import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:volume/volume.dart';
import 'models/song_model.dart';
import 'package:play/home_screen.dart';

class NowPlayingScreen extends StatefulWidget {
  final booksData;
  final int index;

  const NowPlayingScreen(
      {Key? key, required this.booksData, required this.index})
      : super(key: key);

  get position => null;

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen>
    with TickerProviderStateMixin {
  // double? _dragValue;
  late AudioPlayer advancePlayer;

  late AnimationController controller;
  late Animation<double> animation;
  double start = 0;
  double end = 1;
  late AudioManager audioManager;
  int? maxVol, currentVol;
  ShowVolumeUI showVolumeUI = ShowVolumeUI.SHOW;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    advancePlayer = AudioPlayer();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.repeat();
    audioManager = AudioManager.STREAM_MUSIC;
    initAudioStreamType();
    UpdateVolume();
  }

  Future<void> initAudioStreamType() async {
    await Volume.controlVolume(AudioManager.STREAM_MUSIC);
  }

  UpdateVolume() async {
    maxVol = await Volume.getMaxVol;
    currentVol = await Volume.getVol;
    setState(() {});
  }

  setVol(int i) async {
    await Volume.setVol(i, showVolumeUI: showVolumeUI);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.network(
            "https://images.unsplash.com/photo-1520052205864-92d242b3a76b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=869&q=80"),
        Column(children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  // image: DecorationImage(
                  //   image: NetworkImage(
                  //     "https://images.unsplash.com/photo-1520052205864-92d242b3a76b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=869&q=80",
                  //   ),
                  //   fit: BoxFit.cover,
                  // ),
                  ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 35,
                              color: Colors.pink.shade400,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )),
                      TopText()
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.pink.shade400, Colors.blue.shade100],
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 5,
                    width: 50,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 40),
                    // margin: const EdgeInsets.fromLTRB(160, 10, 160, 158),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                        child: Icon(
                          Icons.volume_mute,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(flex: 1, child: volSlider(context)),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 25, 0),
                        child: Icon(
                          Icons.volume_up,
                          size: 40,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  rotatedMusicImage(),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    this.widget.booksData?[this.widget.index]["title"],
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    this.widget.booksData?[this.widget.index]["text"],
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[100]),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ]),
    );
  }

  Widget rotatedMusicImage() {
    return RotationTransition(
      turns: animation,
      child: CircleAvatar(
        radius: 130,
        backgroundImage: AssetImage(
          this.widget.booksData[this.widget.index]["img"],
        ),
      ),
    );
  }

  Widget volSlider(BuildContext context) {
    return (currentVol != null || maxVol != null)
        ? Slider(
            activeColor: Colors.blueAccent.shade700,
            inactiveColor: Colors.white24,
            max: maxVol! / 1.0,
            min: 0,
            value: currentVol! / 1.0,
            onChanged: (value) {
              setState(() {
                setVol(value.toInt());
                UpdateVolume();
              });
            },
          )
        : Container();
  }
}

class TopText extends StatelessWidget {
  const TopText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(45, 15, 0, 15),
          child: Row(
            children: [
              AnimatedTextKit(animatedTexts: [
                TypewriterAnimatedText("Now playing . . . . . . .",
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    speed: Duration(milliseconds: 300)),
              ]),
              Icon(
                Icons.music_note,
                color: Colors.white,
              ),
              Icon(
                Icons.music_note,
                color: Colors.white,
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.pink.shade400, Colors.blue.shade100]),
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
