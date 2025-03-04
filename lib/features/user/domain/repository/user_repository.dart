import 'package:memora_app/features/user/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> getUser(String uid);
  Future<void> createUser(UserEntity user);
}
