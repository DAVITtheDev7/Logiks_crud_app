import 'package:equatable/equatable.dart';

abstract class ObjectActionEvent extends Equatable {
  const ObjectActionEvent();
  @override
  List<Object?> get props => [];
}

class CreateObjectEvent extends ObjectActionEvent {
  final String name;
  final Map<String, dynamic>? data;
  const CreateObjectEvent({required this.name, this.data});
}

class UpdateObjectEvent extends ObjectActionEvent {
  final String id;
  final String name;
  final Map<String, dynamic>? data;
  const UpdateObjectEvent({required this.id, required this.name, this.data});
}

class PartiallyUpdateObjectEvent extends ObjectActionEvent {
  final String id;
  final Map<String, dynamic> data;

  const PartiallyUpdateObjectEvent({required this.id, required this.data});

  @override
  List<Object?> get props => [id, data];
}

class DeleteObjectEvent extends ObjectActionEvent {
  final String id;
  const DeleteObjectEvent(this.id);
}
