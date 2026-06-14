import 'package:logiks_crud_app/features/objects/domain/entities/my_object_entity.dart';

class MyObjectModel extends MyObjectEntity {
  const MyObjectModel({required super.id, required super.name, super.data});

  factory MyObjectModel.fromJson(Map<String, dynamic> json) {
    return MyObjectModel(
      id: json['id'].toString(),
      name: json['name'] as String,
      data: json['data'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, if (data != null) 'data': data};
  }
}
