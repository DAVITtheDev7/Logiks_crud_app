import 'package:equatable/equatable.dart';

class MyObjectEntity extends Equatable {
  final String id;
  final String name;
  final Map<String, dynamic>? data;

  const MyObjectEntity({required this.id, required this.name, this.data});

  @override
  List<Object?> get props => [id, name, data];
}
