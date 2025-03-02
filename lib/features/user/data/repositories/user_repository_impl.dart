import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memora_app/features/user/data/models/user_model.dart';
import 'package:memora_app/features/user/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore firestore;

  UserRepositoryImpl({required this.firestore});

  @override
  Future<UserModel> getUser(String uid) async {
    final doc = await firestore.collection("users").doc(uid).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data()!);
    }
    throw Exception("User not found");
  }
}
