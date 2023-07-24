class Song {
  //negative id
  final int id;
  final String songName;
  final String singerName;
  final String imgUrl;
  final String musicUrl;
  Song({
    required this.id,
    required this.songName,
    required this.singerName,
    required this.imgUrl,
    required this.musicUrl,
  });
  static List<Song> songs = [
    Song(
        id: -1,
        songName: "Looking For..",
        singerName: "Looney_Toonz",
        imgUrl: "assets/image/1-image.jpg",
        musicUrl: "Looking For Spmeone.mp3"),
    Song(
        id: -2,
        songName: "I'm Yours",
        singerName: "Isabel LaRosa",
        imgUrl: "assets/image/2-image.jpg",
        musicUrl: "im yours.mp3"),
    Song(
        id: -3,
        songName: "Clandestina",
        singerName: "FILV",
        imgUrl: "assets/image/3-image.jpg",
        musicUrl: "Clandestina.mp3"),
    Song(
        id: -4,
        songName: "Devil Eyes",
        singerName: "Hippie",
        imgUrl: "assets/image/4-image.jpg",
        musicUrl: "Devil Eyes.mp3"),
    Song(
        id: -5,
        songName: "Faded",
        singerName: "Alan Walker",
        imgUrl: "assets/image/5-image.jpg",
        musicUrl: "Faded.mp3"),
    Song(
        id: -6,
        songName: "Big Boy",
        singerName: "Hippie",
        imgUrl: "assets/image/6-image.jpeg",
        musicUrl: "BigBoy.mp3"),
    Song(
        id: -7,
        songName: "Middle of night... ",
        singerName: "Elley Duhe",
        imgUrl: "assets/image/7-image.jpeg",
        musicUrl: "middle of the night.mp3"),
  ];
}
