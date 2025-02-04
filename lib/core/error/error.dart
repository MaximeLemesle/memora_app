import 'package:equatable/equatable.dart';

class Error extends Equatable {
  final String message;

  const Error({this.message = ''});

  @override
  List<Object> get props => [message];
}
