import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:play/models/song_playlist_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class musicPlayerForPlaylist extends StatefulWidget {
  final String songToPlay;
  final String songName;
  final String songImage;
  final int i;
  final int j;
  final int id;
  musicPlayerForPlaylist({
    required this.songToPlay,
    required this.songName,
    required this.songImage,
    required this.i,
    required this.j,
    required this.id,
  });

  @override
  _musicPlayerForPlaylistState createState() => _musicPlayerForPlaylistState();
}

class _musicPlayerForPlaylistState extends State<musicPlayerForPlaylist> {
  bool playing = false;
  IconData playBtn = Icons.play_arrow;

  late AudioPlayer _player;
  late AudioCache cache;

  Duration position = new Duration();
  Duration musicLength = new Duration();

  Widget slider() {
    return Container(
      width: 270.0,
      child: Slider.adaptive(
          activeColor: Color.fromARGB(255, 253, 254, 255),
          inactiveColor: Color.fromARGB(163, 154, 153, 153),
          thumbColor: Color.fromARGB(255, 159, 158, 158),
          value: position.inSeconds.toDouble(),
          max: musicLength.inSeconds.toDouble(),
          onChanged: (value) {
            seekToSec(value.toInt());
          }),
    );
  }

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

  int get currentSongIndex => widget.i;
  List<List<Playlist>> playlist = Playlist.playlist;

  String currentSongName = '';
  String currentSongImage = '';
  int currentSongIndex1 = 1;
  int postionIndex1 = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int positionIndex = widget.j;
    int currentSongIndex = widget.i;
    postionIndex1 = positionIndex;
    currentSongIndex1 = currentSongIndex;
    currentSongName = playlist[postionIndex1][currentSongIndex1].songName;
    currentSongImage = playlist[postionIndex1][currentSongIndex1].imgUrl;

    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);

    _player.durationHandler = (d) {
      setState(() {
        musicLength = d;
      });
    };

    _player.positionHandler = (p) {
      setState(() {
        position = p;
      });
    };
  }

  String play() {
    String currentSong = playlist[postionIndex1][currentSongIndex1].musicUrl;
    String songName = playlist[postionIndex1][currentSongIndex1].songName;
    String songImage = playlist[postionIndex1][currentSongIndex1].imgUrl;
    setState(() {
      currentSongName = songName;
      currentSongImage = songImage;
    });

    print("Now playing: $currentSong");
    print("Now playing: $songName");
    print("Now Playing: $songImage");
    return currentSong;
  }

  String nextSong() {
    setState(() {
      currentSongIndex1++;

      if (currentSongIndex1 >= playlist[postionIndex1].length) {
        print("End of playlist reached.");
        currentSongIndex1 = 0;
      }
    });
    play();

    return playlist[postionIndex1][currentSongIndex1].musicUrl;
  }

  String previousSong() {
    setState(() {
      currentSongIndex1--;

      if (currentSongIndex1 <= 0) {
        print("End of playlist reached.");
        currentSongIndex1 = 0;
        print(currentSongIndex1);
      }
    });
    play();

    return playlist[postionIndex1][currentSongIndex1].musicUrl;
  }

  @override
  Widget build(BuildContext context) {
    int count = widget.i;
    int user_id = widget.id;
    return WillPopScope(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(currentSongImage),
                  opacity: 0.6,
                  fit: BoxFit.cover)),
          child: Padding(
            padding: EdgeInsets.only(
              top: 48.0,
            ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () {
                                _player.stop();
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back_ios),
                              iconSize: 35,
                            ),
                            Text(
                              "Play Beats",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: ValueListenableBuilder(
                            valueListenable: Hive.box('favorite4').listenable(),
                            builder: (BuildContext context, box2, child) {
                              return ValueListenableBuilder(
                                valueListenable:
                                    Hive.box('favorite3').listenable(),
                                builder: (context, box, child) {
                                  final isFavorites =
                                      box.get(widget.id) != null;
                                  return IconButton(
                                      onPressed: () async {
                                        ScaffoldMessenger.of(context)
                                            .clearSnackBars();
                                        if (isFavorites) {
                                          await box.delete(widget.id);
                                          await box2.delete(widget.id);
                                          const snackBar = SnackBar(
                                            content:
                                                Text("Remove Successfully"),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        } else {
                                          await box.put(
                                              widget.id,
                                              playlist[postionIndex1]
                                                      [currentSongIndex1]
                                                  .songName);
                                          await box2.put(
                                              widget.id,
                                              playlist[postionIndex1]
                                                      [currentSongIndex1]
                                                  .imgUrl);

                                          const snackBar = SnackBar(
                                            content: Text("Added Successfully"),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      },
                                      icon: isFavorites
                                          ? Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                              size: 30,
                                            )
                                          : Icon(
                                              Icons.favorite_border,
                                              size: 30,
                                            ));
                                },
                              );
                            }),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 60.0),
                    child: Text(
                      "Listen to your favorite Music",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 21.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  Center(
                    child: Container(
                      width: 280.0,
                      height: 280.0,
                      decoration: BoxDecoration(
                        // ignore: prefer_const_constructors
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(80),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(80),
                        ),

                        image: DecorationImage(
                          image: AssetImage(currentSongImage),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 6,
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  Center(
                    child: Text(
                      currentSongName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.black,
                            Colors.black12,
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.0),
                          topRight: Radius.circular(50.0),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 500.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "${position.inMinutes}:${position.inSeconds.remainder(60)}",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                                Expanded(flex: 7, child: slider()),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "${musicLength.inMinutes}:${musicLength.inSeconds.remainder(60)}",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                iconSize: 70.0,
                                color: Colors.white,
                                onPressed: () {
                                  //play previous song
                                  cache.play(previousSong());
                                },
                                icon: Icon(
                                  Icons.skip_previous,
                                ),
                              ),
                              IconButton(
                                iconSize: 90.0,
                                color: Colors.white,
                                onPressed: () {
                                  if (!playing) {
                                    cache.play(play());
                                    setState(() {
                                      playBtn = Icons.pause;
                                      playing = true;
                                    });
                                  } else {
                                    _player.pause();

                                    setState(
                                      () {
                                        playBtn = Icons.play_arrow;
                                        playing = false;
                                      },
                                    );
                                  }
                                },
                                icon: Icon(
                                  playBtn,
                                ),
                              ),
                              IconButton(
                                iconSize: 70.0,
                                color: Colors.white,
                                onPressed: () {
                                  cache.play(nextSong());
                                },
                                icon: Icon(
                                  Icons.skip_next,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
