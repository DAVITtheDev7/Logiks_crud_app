import 'package:equatable/equatable.dart';

abstract class ObjectListEvent extends Equatable {
  const ObjectListEvent();
  @override
  List<Object?> get props => [];
}

class LoadObjectsEvent extends ObjectListEvent {}
