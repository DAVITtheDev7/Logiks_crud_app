import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logiks_crud_app/core/errors/error_parser.dart';
import 'package:logiks_crud_app/features/objects/domain/usecases/create_object_usecase.dart';
import 'package:logiks_crud_app/features/objects/domain/usecases/delete_object_usecase.dart';
import 'package:logiks_crud_app/features/objects/domain/usecases/partially_update_object_usecase.dart';
import 'package:logiks_crud_app/features/objects/domain/usecases/update_object_usecase.dart';

import 'object_action_event.dart';
import 'object_action_state.dart';

class ObjectActionBloc extends Bloc<ObjectActionEvent, ObjectActionState> {
  final CreateObjectUseCase createObjectUseCase;
  final UpdateObjectUseCase updateObjectUseCase;
  final PartiallyUpdateObjectUseCase partiallyUpdateObjectUseCase;
  final DeleteObjectUseCase deleteObjectUseCase;

  ObjectActionBloc({
    required this.createObjectUseCase,
    required this.updateObjectUseCase,
    required this.partiallyUpdateObjectUseCase,
    required this.deleteObjectUseCase,
  }) : super(ObjectActionInitial()) {
    on<CreateObjectEvent>(_onCreateObject);
    on<UpdateObjectEvent>(_onUpdateObject);
    on<PartiallyUpdateObjectEvent>(_onPartiallyUpdateObject);
    on<DeleteObjectEvent>(_onDeleteObject);
  }

  // Create
  Future<void> _onCreateObject(
    CreateObjectEvent event,
    Emitter<ObjectActionState> emit,
  ) async {
    emit(ObjectActionLoading());

    try {
      await createObjectUseCase(name: event.name, data: event.data);

      emit(const ObjectActionSuccess('Object created successfully!'));
    } catch (e) {
      emit(ObjectActionError(ErrorParser.parse(e.toString())));
    }
  }

  // Full update
  Future<void> _onUpdateObject(
    UpdateObjectEvent event,
    Emitter<ObjectActionState> emit,
  ) async {
    emit(ObjectActionLoading());

    try {
      await updateObjectUseCase(
        id: event.id,
        name: event.name,
        data: event.data,
      );

      emit(const ObjectActionSuccess('Object updated successfully!'));
    } catch (e) {
      emit(
        ObjectActionError(ErrorParser.parse(e.toString(), contextId: event.id)),
      );
    }
  }

  // Partially Update
  Future<void> _onPartiallyUpdateObject(
    PartiallyUpdateObjectEvent event,
    Emitter<ObjectActionState> emit,
  ) async {
    emit(ObjectActionLoading());

    try {
      await partiallyUpdateObjectUseCase(
        id: event.id,
        name: event.name,
        data: event.data,
      );

      emit(const ObjectActionSuccess('Object partially updated!'));
    } catch (e) {
      emit(
        ObjectActionError(ErrorParser.parse(e.toString(), contextId: event.id)),
      );
    }
  }

  // Delete
  Future<void> _onDeleteObject(
    DeleteObjectEvent event,
    Emitter<ObjectActionState> emit,
  ) async {
    emit(ObjectActionLoading());

    try {
      await deleteObjectUseCase(event.id);

      emit(const ObjectActionSuccess('Object deleted successfully!'));
    } catch (e) {
      emit(
        ObjectActionError(ErrorParser.parse(e.toString(), contextId: event.id)),
      );
    }
  }
}
