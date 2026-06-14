import 'package:logiks_crud_app/features/objects/domain/entities/my_object_entity.dart';
import 'package:logiks_crud_app/features/objects/domain/repositories/object_repository.dart';

class PartiallyUpdateObjectUseCase {
  final ObjectRepository repository;

  PartiallyUpdateObjectUseCase(this.repository);

  Future<MyObjectEntity> call({
    required String id,
    required Map<String, dynamic> data,
  }) {
    return repository.partiallyUpdateObject(id, data);
  }
}
