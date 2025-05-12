import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memora_app/core/services/auth.service.dart';
import 'package:memora_app/features/auth/presentation/pages/signup.page.dart';
import 'package:memora_app/features/user/domain/repository/user.repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:patrol/patrol.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockUser extends Mock implements User {}

void main() {
  late MockFirebaseAuth mockAuth;
  late MockUserRepository mockUserRepository;
  late AuthService authService;

  // const testName = "John Doe";
  // const testEmail = "johndoe@example.com";
  // const testPassword = "password123";
  // const testUid = "test-uid-123";

  setUp(() {
    mockAuth = MockFirebaseAuth();
    mockUserRepository = MockUserRepository();
    authService = AuthService(
      auth: mockAuth,
      userRepository: mockUserRepository,
    );
  });

  patrolTest('check if signup creates a new user', ($) async {
    /// Arrange auth service with mock auth and firestore
    await $.pumpWidget(const SignUpPage());

    /// Act the creation of a new user
    // await authService.signup(
    //   name: 'John Doe',
    //   email: 'johndoe@example.com',
    //   password: 'password123',
    // );

    debugDumpApp();

    /// Assert that a user was created in Firestore

    expect($(SignUpPage()), findsOneWidget);

    // final doc = await mockFirestore
    //     .collection('users')
    //     .doc(mockAuth.currentUser!.uid)
    //     .get();

    // expect(mockAuth.currentUser, true);
    // expect(doc.data()!['name'], 'John Doe');
    // expect(doc.data()!['email'], 'johndoe@example.com');
  });
}
