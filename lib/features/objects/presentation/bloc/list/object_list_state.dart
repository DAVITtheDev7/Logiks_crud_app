import 'package:equatable/equatable.dart';
import 'package:logiks_crud_app/features/objects/domain/entities/my_object_entity.dart';

abstract class ObjectListState extends Equatable {
  const ObjectListState();
  @override
  List<Object?> get props => [];
}

class ObjectListInitial extends ObjectListState {}

class ObjectListLoading extends ObjectListState {}

class ObjectListLoaded extends ObjectListState {
  final List<MyObjectEntity> objects;
  const ObjectListLoaded(this.objects);
  @override
  List<Object?> get props => [objects];
}

class ObjectListError extends ObjectListState {
  final String message;
  const ObjectListError(this.message);
  @override
  List<Object?> get props => [message];
}
