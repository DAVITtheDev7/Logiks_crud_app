import 'package:logiks_crud_app/features/objects/domain/repositories/object_repository.dart';

class DeleteObjectUseCase {
  final ObjectRepository repository;

  DeleteObjectUseCase(this.repository);

  Future<void> call(String id) {
    return repository.deleteObject(id);
  }
}
