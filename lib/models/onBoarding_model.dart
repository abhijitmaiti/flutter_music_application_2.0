class onBoarding {
  final String title;
  final String image;
  onBoarding({
    required this.title,
    required this.image,
  });
  static List<onBoarding> onBoardingContent = [
    onBoarding(
      title: "Welcome To Play Beats",
      image: "assets/splash-01.png",
    ),
    onBoarding(
      title: "Listen Your Favourt Music",
      image: "assets/splash-02.png",
    ),
    onBoarding(
      title: "No Advertisement",
      image: "assets/splash-03.png",
    ),
  ];
}
