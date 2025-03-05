import 'package:memora_app/features/user/domain/entities/user.entity.dart';
import 'package:memora_app/features/user/domain/repository/user.repository.dart';

class GetUser {
  final UserRepository repository;

  GetUser(this.repository);

  Future<UserEntity> call(String uid) async {
    return await repository.getUser(uid);
  }
}
