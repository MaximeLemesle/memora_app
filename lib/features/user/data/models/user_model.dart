import 'package:equatable/equatable.dart';
import 'package:memora_app/features/user/domain/entities/user_entity.dart';

class UserModel extends Equatable {
  final String uid;
  final String name;
  final String email;
  final String? avatarUrl;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.avatarUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String? ?? (throw Exception('UID is required')),
      name: map['name'] as String? ?? (throw Exception('Name is required')),
      email: map['email'] as String? ?? (throw Exception('Email is required')),
      avatarUrl: map['avatarUrl'] as String? ?? '',
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      uid: uid,
      name: name,
      email: email,
      avatarUrl: avatarUrl,
    );
  }

  @override
  List<Object?> get props => [
        uid,
        name,
        email,
        avatarUrl,
      ];
}
