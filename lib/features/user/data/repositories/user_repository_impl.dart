import 'package:memora_app/features/user/data/data-sources/user_remote_data_source.dart';
import 'package:memora_app/features/user/data/models/user_model.dart';
import 'package:memora_app/features/user/domain/entities/user_entity.dart';
import 'package:memora_app/features/user/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity> getUser(String uid) async {
    final UserModel userModel = await remoteDataSource.getUser(uid);

    return userModel.toEntity();
  }

  @override
  Future<void> createUser(UserEntity user) async {
    final UserModel userModel = UserModel.fromEntity(user);

    await remoteDataSource.createUser(userModel);
  }
}
