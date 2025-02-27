import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String name;
  final String email;
  final String? avatarUrl;

  const UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    this.avatarUrl,
  });

  @override
  List<Object> get props => [
        uid,
        name,
        email,
        avatarUrl ?? '',
      ];
}
