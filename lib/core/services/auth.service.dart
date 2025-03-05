import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:memora_app/features/user/data/data-sources/user.data_source.dart';
import 'package:memora_app/features/user/data/repositories/user.repository_impl.dart';
import 'package:memora_app/features/user/domain/entities/user.entity.dart';
import 'package:memora_app/features/user/domain/repository/user.repository.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserRepository userRepository;

  AuthService()
      : userRepository = UserRepositoryImpl(
          remoteDataSource:
              UserRemoteDataSource(firestore: FirebaseFirestore.instance),
        );

  /// Sign Up a new user
  Future<void> signup({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await userRepository.createUser(
          UserEntity(uid: user.uid, name: name, email: user.email!),
        );
      }

      await Future.delayed(const Duration(seconds: 1));

      if (!context.mounted) return;
      Navigator.pushReplacementNamed(context, '/home_page');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'Le mot de passe est trop faible.';
      } else if (e.code == 'email-already-in-use') {
        message = 'Un compte existe déjà avec cet email.';
      } else {
        message = 'Erreur inconnue: ${e.message}';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } catch (e) {
      debugPrint("Error in signup: $e");
    }
  }

  /// Sign In an existing user
  Future<void> signin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      await Future.delayed(const Duration(seconds: 1));
      if (!context.mounted) return;
      Navigator.pushReplacementNamed(context, '/home_page');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'invalid-credential') {
        message = 'Adresse mail ou mot de passe incorrect.';
      } else {
        message = 'Erreur inconnue: ${e.message}';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } catch (e) {
      debugPrint("Error in signin: $e");
    }
  }

  /// Sign Out the current user
  Future<void> signout({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut();
    await Future.delayed(Duration(seconds: 1));
    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, '/landing_page');
  }
}
