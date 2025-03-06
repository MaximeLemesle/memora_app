import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memora_app/features/user/data/models/user.model.dart';

class UserDataSource {
  final FirebaseFirestore firestore;

  UserDataSource({required this.firestore});

  Future<UserModel> getUser(String uid) async {
    try {
      final doc = await firestore.collection("users").doc(uid).get();

      return UserModel.fromJson(doc.data() as Map<String, dynamic>);
    } catch (e) {
      throw Exception("Error fetching user: $e");
    }
  }

  Future<void> createUser(UserModel user) async {
    try {
      await firestore.collection('users').doc(user.uid).set(user.toJson());
    } catch (e) {
      throw Exception("Error creating user: $e");
    }
  }
}
