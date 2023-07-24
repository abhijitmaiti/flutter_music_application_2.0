import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_transition/page_transition.dart';
import 'package:play/models/song_model.dart';
import 'package:play/models/song_playlist_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:play/musicPlayer.dart';
import 'package:play/playlist/musicPlayerForPlaylist.dart';

class favoriteScreen extends StatefulWidget {
  const favoriteScreen({super.key});

  @override
  State<favoriteScreen> createState() => _favoriteScreenState();
}

class _favoriteScreenState extends State<favoriteScreen> {
  List posts = List.from(Hive.box('favorite').values);
  List posts2 = List.from(Hive.box('favorite2').values);
  List posts3 = List.from(Hive.box('favorite3').values);
  List posts4 = List.from(Hive.box('favorite4').values);
  List<Song> songs = Song.songs;
  List<List<Playlist>> playlist = Playlist.playlist;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.white])),
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 435,
                      ),
                      width: 200,
                      child: ListView.builder(
                          itemCount: posts3.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                        right: 20,
                                        left: 10),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            AssetImage(posts4.elementAt(index)),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 9,
                                          offset: Offset(1, 5),
                                        )
                                      ],
                                    ),
                                    width: MediaQuery.of(context).size.width *
                                        0.47,
                                    height: MediaQuery.of(context).size.height *
                                        .30,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: InkWell(
                                    onTap: () {
                                      final sName = posts3[index];
                                      for (int i = 0;
                                          i < playlist.length;
                                          i++) {
                                        for (int j = 0;
                                            j < playlist[i].length;
                                            j++) {
                                          if (sName ==
                                              playlist[i][j].songName) {
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    child:
                                                        musicPlayerForPlaylist(
                                                      songToPlay: playlist[i][j]
                                                          .musicUrl,
                                                      songImage:
                                                          playlist[i][j].imgUrl,
                                                      songName: playlist[i][j]
                                                          .songName,
                                                      i: j,
                                                      j: i,
                                                      id: playlist[i][j].id,
                                                    ),
                                                    type:
                                                        PageTransitionType.fade,
                                                    duration: Duration(
                                                        milliseconds: 200),
                                                    reverseDuration: Duration(
                                                        milliseconds: 100),
                                                    alignment:
                                                        Alignment.topCenter));
                                            break;
                                          }
                                        }
                                      }
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.fromLTRB(18, 185, 0, 0),
                                      height: 70,
                                      width: MediaQuery.of(context).size.width *
                                          0.39,
                                      // ignore: sort_child_properties_last
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            flex: 8,
                                            child: Container(
                                              margin: EdgeInsets.only(left: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    posts3[index],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  Text(
                                                    "Unknown",
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(right: 15),
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.3),
                                                    spreadRadius: 1,
                                                    blurRadius: 4,
                                                    offset: Offset(1, 3),
                                                  ),
                                                ],
                                                shape: BoxShape.circle,
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  //music palyer screen
                                                },
                                                child: Icon(
                                                  Icons.play_circle_fill,
                                                  color: Colors.orange,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.white.withOpacity(.7),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    )),
                Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.only(top: 480),
                      width: 200,
                      child: ListView.builder(
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20, right: 10),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage(posts2.elementAt(index)),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 9,
                                        offset: Offset(2, 5),
                                      )
                                    ],
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.47,
                                  height:
                                      MediaQuery.of(context).size.height * .30,
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: InkWell(
                                    onTap: () {
                                      final sName = posts[index];
                                      for (int i = 0; i < songs.length; i++) {
                                        if (sName == songs[i].songName) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => musicPlayer(
                                                songToPlay: songs[i].musicUrl,
                                                songImage: songs[i].imgUrl,
                                                songName: songs[i].songName,
                                                i: i,
                                              ),
                                            ),
                                          );
                                          break;
                                        }
                                      }
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.fromLTRB(29, 178, 0, 32),
                                      height: 70,
                                      width: MediaQuery.of(context).size.width *
                                          0.39,

                                      // ignore: sort_child_properties_last

                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            flex: 8,
                                            child: Container(
                                              margin: EdgeInsets.only(left: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    posts[index],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  Text(
                                                    "Anonomus",
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(right: 15),
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.3),
                                                    spreadRadius: 1,
                                                    blurRadius: 4,
                                                    offset: Offset(1, 3),
                                                  ),
                                                ],
                                                shape: BoxShape.circle,
                                              ),
                                              child: InkWell(
                                                onTap: () {},
                                                child: Icon(
                                                  Icons.play_circle_fill,
                                                  color: Colors.orange,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.white.withOpacity(.7),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }),
                    )),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30, left: 10),
                    child: Container(
                      child: FloatingActionButton(
                          backgroundColor: Colors.orange,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    children: [
                      Container(
                          height: 500,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/favoriteImage.jpg"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(320),
                                bottomRight: Radius.circular(5),
                              ))),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 45),
                          child: Container(
                            height: MediaQuery.of(context).size.height * .10,
                            width: MediaQuery.of(context).size.width * .60,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.6),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                                bottomLeft: Radius.circular(300),
                                bottomRight: Radius.circular(30),
                              ),
                            ),
                            child: Center(
                                child: Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 20, right: 0),
                                child: Text(
                                  "Favorite Song",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: '',
                                    color: Colors.black,
                                    // shadows: [
                                    //   Shadow(
                                    //       blurRadius: 10,
                                    //       color: Colors.black,
                                    //       offset: Offset(0, 3))
                                    // ],
                                  ),
                                ),
                              ),
                            )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
