import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_transition/page_transition.dart';
import 'package:play/models/song_model.dart';
import 'package:play/models/song_playlist_model.dart';
import 'package:play/models/srearch_model.dart';
import 'package:play/musicPlayer.dart';
import 'package:play/playlist/musicPlayerForPlaylist.dart';
import 'package:play/musicPlayer.dart';

class searchScreen extends StatefulWidget {
  const searchScreen({super.key});

  @override
  State<searchScreen> createState() => _searchScreenState();
}

List<SearchSong> searchSong = SearchSong.searchSong;

class _searchScreenState extends State<searchScreen> {
  final Controller = TextEditingController();
  List<SearchSong> filterSong = searchSong;
  List<List<Playlist>> playlist = Playlist.playlist;
  List<Song> songs = Song.songs;
  void searchBox(String value) {
    final suggestion = searchSong.where((listOfSong) {
      final searchSong = listOfSong.songName.toLowerCase();
      final input = value.toLowerCase();
      return searchSong.contains(input);
    }).toList();
    setState(() => filterSong = suggestion);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black,
                Colors.white,
              ],
            ),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 0,
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 60, 10, 0),
                  child: TextField(
                    controller: Controller,
                    onChanged: searchBox,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      isDense: false,
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "What do you want to listen to?",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black38),
                      prefixIcon: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 9,
                child: ListView.builder(
                    itemCount: filterSong.length,
                    itemBuilder: (context, index) {
                      final listOfSong = filterSong[index];
                      return Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                bottom: 10, left: 10, right: 10),
                            width: MediaQuery.of(context).size.width * .95,
                            height: MediaQuery.of(context).size.height * .10,
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Stack(children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          right: 0,
                                          left: 10,
                                          top: 10,
                                          bottom: 10),
                                      width: MediaQuery.of(context).size.width *
                                          .20,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        image: DecorationImage(
                                          image: AssetImage(listOfSong.imgUrl),
                                          fit: BoxFit.cover,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            spreadRadius: 3,
                                            blurRadius: 9,
                                            offset: Offset(2, 5),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ]),
                                ),
                                Expanded(
                                  flex: 10,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 5, right: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          listOfSong.songName,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          " Unknown",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.orange),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: IconButton(
                                      onPressed: () {
                                        if (listOfSong.id.isNegative) {
                                          for (int i = 0;
                                              i < songs.length;
                                              i++) {
                                            if (listOfSong.id == songs[i].id) {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      child: musicPlayer(
                                                        songToPlay:
                                                            songs[i].musicUrl,
                                                        songImage:
                                                            songs[i].imgUrl,
                                                        songName:
                                                            songs[i].songName,
                                                        i: i,
                                                      ),
                                                      type: PageTransitionType
                                                          .fade,
                                                      duration: Duration(
                                                          milliseconds: 200),
                                                      reverseDuration: Duration(
                                                          milliseconds: 100),
                                                      alignment:
                                                          Alignment.topCenter));
                                              break;
                                            }
                                          }
                                        } else {
                                          for (int i = 0;
                                              i < playlist.length;
                                              i++) {
                                            for (int j = 0;
                                                j < playlist[i].length;
                                                j++) {
                                              if (listOfSong.id ==
                                                  playlist[i][j].id) {
                                                Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        child: musicPlayerForPlaylist(
                                                            songToPlay:
                                                                playlist[i][j]
                                                                    .musicUrl,
                                                            songName:
                                                                playlist[i][j]
                                                                    .songName,
                                                            songImage:
                                                                playlist[i][j]
                                                                    .imgUrl,
                                                            i: j,
                                                            j: i,
                                                            id: playlist[i][j]
                                                                .id),
                                                        type: PageTransitionType
                                                            .fade,
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
                                        }
                                      },
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.orange,
                                      )),
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
