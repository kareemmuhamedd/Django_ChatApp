import 'package:app/features/auth_feature/data/models/tokens_model.dart';
import 'package:app/features/auth_feature/data/models/user_model.dart';

class ResponseUserModel {
  final User user;
  final Tokens tokens;

  ResponseUserModel({
    required this.user,
    required this.tokens,
  });

  factory ResponseUserModel.fromJson(Map<String, dynamic> json) {
    return ResponseUserModel(
      user: User.fromJson(json['user']),
      tokens: Tokens.fromJson(json['tokens']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'tokens': tokens.toJson(),
    };
  }
}