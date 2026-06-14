import 'package:equatable/equatable.dart';
import 'package:logiks_crud_app/features/objects/domain/entities/my_object_entity.dart';

abstract class ObjectDetailsState extends Equatable {
  const ObjectDetailsState();
  @override
  List<Object?> get props => [];
}

class ObjectDetailsInitial extends ObjectDetailsState {}

class ObjectDetailsLoading extends ObjectDetailsState {}

class ObjectDetailsLoaded extends ObjectDetailsState {
  final MyObjectEntity object;
  const ObjectDetailsLoaded(this.object);
  @override
  List<Object?> get props => [object];
}

class ObjectDetailsError extends ObjectDetailsState {
  final String message;
  const ObjectDetailsError(this.message);
  @override
  List<Object?> get props => [message];
}
