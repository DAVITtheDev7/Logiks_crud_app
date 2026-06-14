import 'package:logiks_crud_app/features/objects/domain/entities/my_object_entity.dart';
import 'package:logiks_crud_app/features/objects/domain/repositories/object_repository.dart';

class UpdateObjectUseCase {
  final ObjectRepository repository;

  UpdateObjectUseCase(this.repository);

  Future<MyObjectEntity> call({
    required String id,
    required String name,
    Map<String, dynamic>? data,
  }) {
    return repository.updateObject(id, name, data);
  }
}
