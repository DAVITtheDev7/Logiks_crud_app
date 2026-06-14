import 'package:dio/dio.dart';
import 'package:logiks_crud_app/core/network/api_endpoints.dart';
import 'package:logiks_crud_app/features/objects/data/datasources/object_remote_data_source.dart';
import 'package:logiks_crud_app/features/objects/data/models/my_object_model.dart';

class ObjectRemoteDataSourceImpl implements ObjectRemoteDataSource {
  final Dio dio;

  ObjectRemoteDataSourceImpl({required this.dio});

  // GET (List)
  @override
  Future<List<MyObjectModel>> getObjects() async {
    final response = await dio.get(ApiEndpoints.objects);
    final dataList = response.data as List;
    return dataList.map((json) => MyObjectModel.fromJson(json)).toList();
  }

  // GET (Single)
  @override
  Future<MyObjectModel> getObject(String id) async {
    final response = await dio.get(ApiEndpoints.objectDetails(id));
    return MyObjectModel.fromJson(response.data);
  }

  // POST
  @override
  Future<MyObjectModel> createObject(
    String name,
    Map<String, dynamic>? data,
  ) async {
    final response = await dio.post(
      ApiEndpoints.objects,
      data: {'name': name, if (data != null) 'data': data},
    );
    return MyObjectModel.fromJson(response.data);
  }

  // PUT
  @override
  Future<MyObjectModel> updateObject(
    String id,
    String name,
    Map<String, dynamic>? data,
  ) async {
    final response = await dio.put(
      ApiEndpoints.objectDetails(id),
      data: {'name': name, if (data != null) 'data': data},
    );
    return MyObjectModel.fromJson(response.data);
  }

  // PATCH
  @override
  Future<MyObjectModel> partiallyUpdateObject(
    String id,
    Map<String, dynamic> data,
  ) async {
    final response = await dio.patch(
      ApiEndpoints.objectDetails(id),
      data: data,
    );
    return MyObjectModel.fromJson(response.data);
  }

  // DELETE
  @override
  Future<void> deleteObject(String id) async {
    await dio.delete(ApiEndpoints.objectDetails(id));
  }
}
