import 'package:memora_app/features/user/data/models/user_model.dart';

abstract class UserRepository {
  Future<UserModel> getUser(String uid);
}
