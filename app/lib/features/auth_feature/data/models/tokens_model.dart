class Tokens {
  final String access;
  final String refresh;

  Tokens({
    required this.access,
    required this.refresh,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) {
    return Tokens(
      access: json['access'],
      refresh: json['refresh'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access': access,
      'refresh': refresh,
    };
  }
}