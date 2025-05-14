import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memora_app/core/services/auth.service.dart';
import 'package:mockito/mockito.dart';

import '../../mock.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockFirebaseAuth mockAuth;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;
  late MockUserRepository mockUserRepository;
  late AuthService authService;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();
    mockUserRepository = MockUserRepository();

    authService = AuthService(
      auth: mockAuth,
      userRepository: mockUserRepository,
    );
  });

  /// Test the signup method
  group('signup', () {
    const testUid = '123';
    const testName = 'John Doe';
    const testEmail = 'johndoe@gmail.com';
    const testPassword = 'password123';
    const testBadPassword = 'password';

    setUp(() {
      // Mock the UserCredential instance
      when(mockUserCredential.user).thenReturn(mockUser);
      when(mockUser.uid).thenReturn(testUid);
      when(mockUser.email).thenReturn(testEmail);
      when(mockUser.displayName).thenReturn(testName);
    });
    test('successful and return true', () async {
      // Fake the creation of a new user with success
      when(mockAuth.createUserWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => mockUserCredential);

      // Act
      final isCreated = await authService.signup(
        name: testName,
        email: testEmail,
        password: testPassword,
      );

      // Assert
      expect(isCreated, true);
    });

    test('failed and return false', () async {
      // Fake the creation of a new user with password error
      when(mockAuth.createUserWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenThrow(FirebaseAuthException(code: 'weak-password'));

      // Act
      final isCreated = await authService.signup(
        name: testName,
        email: testEmail,
        password: testBadPassword,
      );

      // Assert
      expect(isCreated, false);
    });
  });

  /// Test the signin method

  /// Test the signout method
}
