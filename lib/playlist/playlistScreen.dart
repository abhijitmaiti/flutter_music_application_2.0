import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:play/models/playlist_model.dart';
import 'package:play/models/song_playlist_model.dart';
import 'package:play/musicPlayer.dart';
import 'package:play/playlist/musicPlayerForPlaylist.dart';

class playlistScreen extends StatefulWidget {
  final int k;
  playlistScreen({required this.k});
  @override
  State<playlistScreen> createState() => _playlistScreenState();
}

class _playlistScreenState extends State<playlistScreen> {
  @override
  Widget build(BuildContext context) {
    List<List<Playlist>> playlist = Playlist.playlist;
    List<PlaylistDecoration> playlistdecoration =
        PlaylistDecoration.playlistdecoration;
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
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.only(left: 0, right: 0),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  playlistdecoration[widget.k].imgUrl),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(300),
                              bottomRight: Radius.circular(5)),
                          color: Colors.white,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 30, left: 20),
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
                                  playlistdecoration[widget.k].playlistName,
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
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Row(
                  children: [
                    Text(
                      "Songs",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: playlist[widget.k].length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    // music player screen
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            child: musicPlayerForPlaylist(
                                              songToPlay: playlist[widget.k]
                                                      [index]
                                                  .musicUrl,
                                              songImage: playlist[widget.k]
                                                      [index]
                                                  .imgUrl,
                                              songName: playlist[widget.k]
                                                      [index]
                                                  .songName,
                                              i: index,
                                              j: widget.k,
                                              id: playlist[widget.k][index].id,
                                            ),
                                            type: PageTransitionType.fade,
                                            duration:
                                                Duration(milliseconds: 200),
                                            reverseDuration:
                                                Duration(milliseconds: 100),
                                            alignment: Alignment.topCenter));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    width: MediaQuery.of(context).size.width *
                                        0.47,
                                    height: MediaQuery.of(context).size.height *
                                        .30,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            playlist[widget.k][index].imgUrl),
                                        fit: BoxFit.cover,
                                      ),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 9,
                                          offset: Offset(2, 5),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(25, 0, 0, 45),
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
                                                  playlist[widget.k][index]
                                                      .songName,
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
                                            margin: EdgeInsets.only(right: 15),
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
                              ],
                            );
                          })),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
