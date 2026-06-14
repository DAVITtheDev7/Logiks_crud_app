import 'package:logiks_crud_app/features/objects/data/datasources/object_remote_data_source.dart';
import 'package:logiks_crud_app/features/objects/domain/entities/my_object_entity.dart';
import 'package:logiks_crud_app/features/objects/domain/repositories/object_repository.dart';

class ObjectRepositoryImpl implements ObjectRepository {
  final ObjectRemoteDataSource remoteDataSource;

  ObjectRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<MyObjectEntity>> getObjects() async {
    return await remoteDataSource.getObjects();
  }

  @override
  Future<MyObjectEntity> getObject(String id) async {
    return await remoteDataSource.getObject(id);
  }

  @override
  Future<MyObjectEntity> createObject(
    String name,
    Map<String, dynamic>? data,
  ) async {
    return await remoteDataSource.createObject(name, data);
  }

  @override
  Future<MyObjectEntity> updateObject(
    String id,
    String name,
    Map<String, dynamic>? data,
  ) async {
    return await remoteDataSource.updateObject(id, name, data);
  }

  @override
  Future<MyObjectEntity> partiallyUpdateObject({
    required String id,
    String? name,
    Map<String, dynamic>? data,
  }) async {
    return remoteDataSource.partiallyUpdateObject(
      id: id,
      name: name,
      data: data,
    );
  }

  @override
  Future<void> deleteObject(String id) async {
    return await remoteDataSource.deleteObject(id);
  }
}
