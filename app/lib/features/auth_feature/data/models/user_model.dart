class User {
  final String username;
  final String name;
  final String? thumbnail; // This can be null

  User({
    required this.username,
    required this.name,
    this.thumbnail,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      name: json['name'],
      thumbnail: json['thumbnail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'name': name,
      'thumbnail': thumbnail,
    };
  }
}