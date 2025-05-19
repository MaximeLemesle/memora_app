import 'package:firebase_auth/firebase_auth.dart';
import 'package:memora_app/features/user/domain/repository/user.repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  FirebaseAuth,
  User,
  UserCredential,
  UserRepository,
])
void main() {}
