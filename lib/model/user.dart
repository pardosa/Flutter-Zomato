class User {
  final String name;
  final String foodieLevel;
  final int foodieLevelNum;
  final String foodieColor;
  final String profileImage;

  User({
    this.name,
    this.foodieLevel,
    this.foodieLevelNum,
    this.foodieColor,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      foodieLevel: json['foodie_level'],
      foodieLevelNum: json['foodie_level_num'],
      foodieColor: json['foodie_color'],
      profileImage: json['profile_image'],
    );
  }
}
