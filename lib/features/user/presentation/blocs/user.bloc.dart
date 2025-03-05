import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memora_app/features/user/domain/entities/user_entity.dart';
import 'package:memora_app/features/user/domain/usecases/get_user.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserEntity user;
  UserLoaded(this.user);
}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}

class UserBloc extends Cubit<UserState> {
  final GetUser getUser;

  UserBloc(this.getUser) : super(UserInitial());

  Future<void> fetchUser(String uid) async {
    emit(UserLoading());
    try {
      final user = await getUser(uid);
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError("Error: $e"));
    }
  }
}
