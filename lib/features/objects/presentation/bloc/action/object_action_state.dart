import 'package:equatable/equatable.dart';

abstract class ObjectActionState extends Equatable {
  const ObjectActionState();
  @override
  List<Object?> get props => [];
}

class ObjectActionInitial extends ObjectActionState {}

class ObjectActionLoading extends ObjectActionState {}

class ObjectActionSuccess extends ObjectActionState {
  final String message;
  const ObjectActionSuccess(this.message);
  @override
  List<Object?> get props => [message];
}

class ObjectActionError extends ObjectActionState {
  final String message;
  const ObjectActionError(this.message);
  @override
  List<Object?> get props => [message];
}
