import 'package:logiks_crud_app/features/objects/domain/entities/my_object_entity.dart';

abstract class ObjectRepository {
  Future<List<MyObjectEntity>> getObjects();
  Future<MyObjectEntity> getObject(String id);
  Future<MyObjectEntity> createObject(String name, Map<String, dynamic>? data);

  Future<MyObjectEntity> updateObject(
    String id,
    String name,
    Map<String, dynamic>? data,
  );
  Future<MyObjectEntity> partiallyUpdateObject(
    String id,
    Map<String, dynamic> data,
  );

  Future<void> deleteObject(String id);
}
