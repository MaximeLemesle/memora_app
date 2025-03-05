import 'package:memora_app/features/user/data/data-sources/user.data_source.dart';
import 'package:memora_app/features/user/data/models/user.model.dart';
import 'package:memora_app/features/user/domain/entities/user.entity.dart';
import 'package:memora_app/features/user/domain/repository/user.repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource dataSource;

  UserRepositoryImpl({required this.dataSource});

  @override
  Future<UserEntity> getUser(String uid) async {
    final UserModel userModel = await dataSource.getUser(uid);

    return userModel.toEntity();
  }

  @override
  Future<void> createUser(UserEntity user) async {
    final UserModel userModel = UserModel.fromEntity(user);

    await dataSource.createUser(userModel);
  }
}
