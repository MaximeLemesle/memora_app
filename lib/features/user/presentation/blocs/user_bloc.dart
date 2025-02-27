import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Modèle d'utilisateur
class User {
  final String uid;
  final String name;
  final String email;

  User({required this.uid, required this.name, required this.email});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }
}

// Événements du bloc
abstract class UserEvent {}

class SaveUserEvent extends UserEvent {
  final User user;

  SaveUserEvent(this.user);
}

// États du bloc
abstract class UserState {}

class UserInitial extends UserState {}

class UserSaved extends UserState {}

class UserError extends UserState {
  final String message;

  UserError(this.message);
}

// Bloc pour gérer l'enregistrement de l'utilisateur
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());

  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is SaveUserEvent) {
      try {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(event.user.uid)
            .set(event.user.toMap());
        yield UserSaved();
      } catch (e) {
        yield UserError("Erreur lors de l'enregistrement de l'utilisateur: $e");
      }
    }
  }
}
