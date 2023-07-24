import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:play/models/playlist_model.dart';
import 'package:play/models/song_model.dart';
import 'package:play/models/song_playlist_model.dart';
import 'package:play/musicPlayer.dart';
import 'package:play/playlist/playlistScreen.dart';
import 'package:play/searchScreen.dart';
import 'components/side_menu.dart';
import 'package:page_transition/page_transition.dart';

// import 'my_tabs.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  // late List popularBooks;
  // late List books;
  late ScrollController _scrollController;
  late TabController _tabController;
  ReadData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/popularBooks.json")
        .then((s) {
      setState(() {
        // popularBooks = json.decode(s);
      });
    });
    await DefaultAssetBundle.of(context)
        .loadString("json/books.json")
        .then((s) {
      setState(() {
        // books = json.decode(s);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    ReadData();
  }

  int currentList = 0;
  PageController _pageController = PageController(initialPage: 0);

  AnimatedContainer dotIndication(index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(top: 10),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          color: currentList == index ? Colors.orange : Colors.white,
          shape: BoxShape.circle),
    );
  }

  List<List<Playlist>> playlist = Playlist.playlist;
  String songNumber(index) {
    String str = playlist[index].length.toString();
    return str;
  }

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<List<Playlist>> playlist = Playlist.playlist;
    List<PlaylistDecoration> playlistdecoration =
        PlaylistDecoration.playlistdecoration;
    List<Song> songs = Song.songs;
    return WillPopScope(
      onWillPop: () async {
        final val = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                  backgroundColor: Color.fromARGB(216, 255, 255, 255),
                  title: const Text("Alert"),
                  content: const Text("Do you want to Exit"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text(
                          "No",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )),
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text(
                          "Exit",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ))
                  ]);
            });
        if (val != null) {
          return Future.value(val);
        } else {
          return Future.value(false);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.white])),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          drawer: sideMenu(),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [],
          ),
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Play",
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 32,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: " Beats",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold))
                    ]))),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        "Listen to your favorite Music",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 21.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 0,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: searchScreen(),
                                  type: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 200),
                                  reverseDuration: Duration(milliseconds: 100),
                                  alignment: Alignment.topCenter));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * .07,
                          width: MediaQuery.of(context).size.width * .90,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.search,
                                color: Colors.grey.shade400,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "What do you want to listen to?",
                                style: TextStyle(
                                  color: Colors.grey.shade400,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      // child: Container(
                      //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      //   child: TextField(
                      //     decoration: InputDecoration(
                      //       border: OutlineInputBorder(
                      //         borderSide: BorderSide.none,
                      //         borderRadius: BorderRadius.circular(20),
                      //       ),
                      //       isDense: false,
                      //       filled: true,
                      //       fillColor: Colors.white,
                      //       hintText: "Search",
                      // hintStyle: Theme.of(context)
                      //     .textTheme
                      //     .bodyMedium!
                      //           .copyWith(color: Colors.grey.shade400),
                      //       prefixIcon: Icon(
                      //         Icons.search,
                      //         color: Colors.grey.shade400,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "New Song",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.31,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: songs.length,
                            itemBuilder: (context, i) {
                              return Stack(children: [
                                InkWell(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => musicPlayScreen(
                                    //       imageUrl: songs[i].imgUrl,
                                    //       songName: songs[i].songName,
                                    //     ),
                                    //   ),
                                    // );
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            child: musicPlayer(
                                              songToPlay: songs[i].musicUrl,
                                              songImage: songs[i].imgUrl,
                                              songName: songs[i].songName,
                                              i: i,
                                            ),
                                            type: PageTransitionType.fade,
                                            duration:
                                                Duration(milliseconds: 200),
                                            reverseDuration:
                                                Duration(milliseconds: 100),
                                            alignment: Alignment.topCenter));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 20),
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      image: DecorationImage(
                                        image: AssetImage(songs[i].imgUrl),
                                        fit: BoxFit.cover,
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
                                    margin: EdgeInsets.fromLTRB(25, 0, 0, 35),
                                    height: 70,
                                    // margin: const EdgeInsets.all(10),
                                    width: MediaQuery.of(context).size.width *
                                        0.37,
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
                                                  songs[i].songName,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                Text(
                                                  songs[i].singerName,
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
                                            child: Icon(
                                              Icons.play_circle_fill,
                                              color: Colors.orange,
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
                              ]);
                            })),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "Playlist",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: Container(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.27,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 9,
                                child: PageView.builder(
                                  controller: _pageController,
                                  onPageChanged: (value) {
                                    setState(() {
                                      currentList = value;
                                    });
                                  },
                                  scrollDirection: Axis.vertical,
                                  itemCount: playlistdecoration.length,
                                  itemBuilder: (context, index) => Stack(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 20),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .95,
                                        decoration: BoxDecoration(
                                            color: Colors.black26,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 9,
                                              child: Stack(children: [
                                                Container(
                                                  margin: EdgeInsets.all(20),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .40,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .35,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          playlistdecoration[
                                                                  index]
                                                              .imgUrl),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                        spreadRadius: 3,
                                                        blurRadius: 9,
                                                        offset: Offset(2, 5),
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                      margin: EdgeInsets.only(
                                                          top: 20,
                                                          bottom: 20,
                                                          left: 21),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .33,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              .35,
                                                      // ignore: prefer_const_constructors
                                                      decoration: BoxDecoration(
                                                        color: Colors.orange
                                                            .withOpacity(.6),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  110),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  320),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  110),
                                                          topLeft:
                                                              Radius.circular(
                                                                  320),
                                                        ),
                                                      ),
                                                      child: InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              PageTransition(
                                                                  child: playlistScreen(
                                                                      k: index),
                                                                  type:
                                                                      PageTransitionType
                                                                          .fade,
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          200),
                                                                  reverseDuration:
                                                                      Duration(
                                                                          milliseconds:
                                                                              100),
                                                                  alignment:
                                                                      Alignment
                                                                          .topCenter));
                                                        },
                                                        child: Icon(
                                                          Icons
                                                              .arrow_circle_right,
                                                          size: 50,
                                                          color: Colors.black,
                                                        ),
                                                      )),
                                                )
                                              ]),
                                            ),
                                            Expanded(
                                                flex: 5,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                    left: 10,
                                                    right: 20,
                                                  ),
                                                  child: Expanded(
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            playlistdecoration[
                                                                    index]
                                                                .playlistName,
                                                            style: TextStyle(
                                                                fontSize: 22,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          Text(
                                                            songNumber(index) +
                                                                " Songs",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                        playlistdecoration.length,
                                        (index) => dotIndication(index),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                          // child: ListView.builder(
                          //     scrollDirection: Axis.vertical,
                          //     itemCount: playlistdecoration.length,
                          //     itemBuilder: (context, j) {
                          //       return Row(
                          //         children: [
                          //           Expanded(
                          //             child: Container(
                          //               margin: EdgeInsets.only(bottom: 20),
                          //               width:
                          //                   MediaQuery.of(context).size.width * .95,
                          //               height: MediaQuery.of(context).size.height *
                          //                   .25,
                          //               decoration: BoxDecoration(
                          //                   color: Colors.black26,
                          //                   borderRadius:
                          //                       BorderRadius.circular(30)),
                          //             ),
                          //           )
                          //         ],
                          //       );
                          //       // return Card(
                          //       //   child: ListTile(
                          //       //     leading: Image(
                          //       //         image: AssetImage(
                          //       //             playlistdecoration[j].imgUrl)),
                          //       //     title: Text(playlistdecoration[j].playlistName),
                          //       //     subtitle: Text("Anonomus"),
                          //       //     trailing: IconButton(
                          //       //       onPressed: () {
                          //       //         Navigator.push(
                          //       //           context,
                          //       //           MaterialPageRoute(
                          //       //               builder: (context) =>
                          //       //                   playlistScreen(k: j)),
                          //       //         );
                          //       //       },
                          //       //       icon: Icon(
                          //       //         Icons.play_circle_fill,
                          //       //         color: Colors.orange,
                          //       //       ),
                          //       //     ),
                          //       //   ),
                          //       // );
                          //     })),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
