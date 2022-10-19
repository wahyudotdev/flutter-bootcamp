class Profile {
  final String name;
  final String description;
  final String icon;
  final String background;
  final String about;
  Profile({
    required this.name,
    required this.description,
    required this.about,
    this.background = 'assets/images/bg_crocodic.png',
    this.icon = 'assets/images/ic_crocodic.png',
  });
}
