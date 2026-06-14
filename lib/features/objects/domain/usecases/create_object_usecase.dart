import 'package:logiks_crud_app/features/objects/domain/entities/my_object_entity.dart';
import 'package:logiks_crud_app/features/objects/domain/repositories/object_repository.dart';

class CreateObjectUseCase {
  final ObjectRepository repository;

  CreateObjectUseCase(this.repository);

  Future<MyObjectEntity> call({
    required String name,
    Map<String, dynamic>? data,
  }) {
    return repository.createObject(name, data);
  }
}
