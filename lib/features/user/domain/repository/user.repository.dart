import 'package:memora_app/features/user/domain/entities/user.entity.dart';

abstract class UserRepository {
  Future<UserEntity> getUser(String uid);
  Future<void> createUser(UserEntity user);
}
