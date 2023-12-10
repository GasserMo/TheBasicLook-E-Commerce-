import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? token;
  final String? role;
  final String? userId;

  const UserModel({this.token, this.role, this.userId});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        token: json['token'] as String?,
        role: json['role'] as String?,
        userId: json['userId'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'token': token,
        'role': role,
        'userId': userId,
      };

  @override
  List<Object?> get props => [token, role, userId];
}
