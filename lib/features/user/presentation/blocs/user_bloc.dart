import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:memora_app/features/user/domain/entities/user_entity.dart';
import 'package:memora_app/features/user/domain/repository/user_repository.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadUserEvent extends UserEvent {
  final String uid;

  LoadUserEvent(this.uid);
}

abstract class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

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

// ⚡ BLOC
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(UserInitial()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final user = await userRepository.getUser(event.uid);
        emit(UserLoaded(user as UserEntity));
      } catch (e) {
        emit(UserError("Failed to load user"));
      }
    });
  }
}
