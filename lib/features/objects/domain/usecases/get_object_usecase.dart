import 'package:logiks_crud_app/features/objects/domain/entities/my_object_entity.dart';
import 'package:logiks_crud_app/features/objects/domain/repositories/object_repository.dart';

class GetObjectUseCase {
  final ObjectRepository repository;

  GetObjectUseCase(this.repository);

  Future<MyObjectEntity> call(String id) {
    return repository.getObject(id);
  }
}
