import 'package:logiks_crud_app/features/objects/data/models/my_object_model.dart';

abstract class ObjectRemoteDataSource {
  // GET (List)
  Future<List<MyObjectModel>> getObjects();

  // GET (Single)
  Future<MyObjectModel> getObject(String id);

  // POST
  Future<MyObjectModel> createObject(String name, Map<String, dynamic>? data);

  // PUT
  Future<MyObjectModel> updateObject(
    String id,
    String name,
    Map<String, dynamic>? data,
  );

  // PATCH
  Future<MyObjectModel> partiallyUpdateObject(
    String id,
    Map<String, dynamic> data,
  );

  // DELETE
  Future<void> deleteObject(String id);
}
