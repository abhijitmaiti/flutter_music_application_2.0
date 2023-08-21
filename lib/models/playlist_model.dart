class PlaylistDecoration {
  final String playlistName;
  final String singerName;
  final String imgUrl;

  PlaylistDecoration({
    required this.playlistName,
    required this.singerName,
    required this.imgUrl,
  });
  static List<PlaylistDecoration> playlistdecoration = [
    PlaylistDecoration(
      playlistName: "English Song",
      singerName: "Looney_Toonz",
      imgUrl: "assets/image/playlist-01.jpg",
    ),
    PlaylistDecoration(
      playlistName: "Slowed Reverb Song",
      singerName: "Isabel LaRosa",
      imgUrl: "assets/image/playlist-02.jpg",
    ),
    PlaylistDecoration(
      playlistName: "BollyWood-2023",
      singerName: "FILV",
      imgUrl: "assets/image/playlist-03.jpg",
    ),
    PlaylistDecoration(
      playlistName: "Top Hit Song",
      singerName: "Hippie",
      imgUrl: "assets/image/playlist-04.jpg",
    ),
    PlaylistDecoration(
      playlistName: "Bengali Song",
      singerName: "Alan Walker",
      imgUrl: "assets/image/playlist-05.jpg",
    ),
    // PlaylistDecoration(
    //   playlistName: "Unknown",
    //   singerName: "Hippie",
    //   imgUrl: "assets/image/playlist-06.jpg",
    // ),
    // PlaylistDecoration(
    //   playlistName: "Unknown",
    //   singerName: "Elley Duhe",
    //   imgUrl: "assets/image/playlist-07.jpg",
    // ),
  ];
}
