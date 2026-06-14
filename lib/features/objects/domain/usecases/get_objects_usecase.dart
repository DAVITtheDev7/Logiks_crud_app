import 'package:logiks_crud_app/features/objects/domain/entities/my_object_entity.dart';
import 'package:logiks_crud_app/features/objects/domain/repositories/object_repository.dart';

class GetObjectsUseCase {
  final ObjectRepository repository;

  GetObjectsUseCase(this.repository);

  Future<List<MyObjectEntity>> call() {
    return repository.getObjects();
  }
}
