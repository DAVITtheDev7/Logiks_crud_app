import 'package:equatable/equatable.dart';

abstract class ObjectDetailsEvent extends Equatable {
  const ObjectDetailsEvent();
  @override
  List<Object?> get props => [];
}

class GetSingleObjectEvent extends ObjectDetailsEvent {
  final String id;
  const GetSingleObjectEvent(this.id);
  @override
  List<Object?> get props => [id];
}
