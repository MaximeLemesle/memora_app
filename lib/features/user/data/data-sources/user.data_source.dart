import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memora_app/features/user/data/models/user.model.dart';

class UserDataSource {
  final FirebaseFirestore firestore;

  UserDataSource({required this.firestore});

  Future<UserModel> getUser(String uid) async {
    final doc = await firestore.collection("users").doc(uid).get();
    if (!doc.exists) {
      throw Exception("User not found");
    }
    return UserModel.fromJson(doc.data() as Map<String, dynamic>);
  }

  Future<void> createUser(UserModel user) async {
    await firestore.collection('users').doc(user.uid).set(user.toJson());
  }
}
