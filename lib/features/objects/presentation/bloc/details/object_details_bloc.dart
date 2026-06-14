import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logiks_crud_app/features/objects/domain/usecases/get_object_usecase.dart';
import 'package:logiks_crud_app/features/objects/presentation/bloc/details/object_details_event.dart';
import 'package:logiks_crud_app/features/objects/presentation/bloc/details/object_details_state.dart';

class ObjectDetailsBloc extends Bloc<ObjectDetailsEvent, ObjectDetailsState> {
  final GetObjectUseCase getObjectUseCase;

  ObjectDetailsBloc({required this.getObjectUseCase})
    : super(ObjectDetailsInitial()) {
    on<GetSingleObjectEvent>((event, emit) async {
      emit(ObjectDetailsLoading());
      try {
        final object = await getObjectUseCase(event.id);
        emit(ObjectDetailsLoaded(object));
      } catch (e) {
        emit(const ObjectDetailsError('Failed to load object details.'));
      }
    });
  }
}
