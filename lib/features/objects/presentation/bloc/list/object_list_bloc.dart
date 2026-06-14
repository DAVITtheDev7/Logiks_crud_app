import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logiks_crud_app/features/objects/domain/usecases/get_objects_usecase.dart';
import 'package:logiks_crud_app/features/objects/presentation/bloc/list/object_list_event.dart';
import 'package:logiks_crud_app/features/objects/presentation/bloc/list/object_list_state.dart';

class ObjectListBloc extends Bloc<ObjectListEvent, ObjectListState> {
  final GetObjectsUseCase getObjectsUseCase;

  ObjectListBloc({required this.getObjectsUseCase})
    : super(ObjectListInitial()) {
    on<LoadObjectsEvent>((event, emit) async {
      emit(ObjectListLoading());
      try {
        final objects = await getObjectsUseCase();
        emit(ObjectListLoaded(objects));
      } catch (e) {
        emit(
          const ObjectListError('Failed to load objects. Please try again.'),
        );
      }
    });
  }
}
