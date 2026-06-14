import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

// Core
import 'package:logiks_crud_app/core/network/api_client.dart';

// Data Sources
import 'package:logiks_crud_app/features/objects/data/datasources/object_remote_data_source.dart';
import 'package:logiks_crud_app/features/objects/data/datasources/object_remote_data_source_impl.dart';

// Repositories
import 'package:logiks_crud_app/features/objects/domain/repositories/object_repository.dart';
import 'package:logiks_crud_app/features/objects/data/repositories/object_repository_impl.dart';

// Use Cases
import 'package:logiks_crud_app/features/objects/domain/usecases/create_object_usecase.dart';
import 'package:logiks_crud_app/features/objects/domain/usecases/delete_object_usecase.dart';
import 'package:logiks_crud_app/features/objects/domain/usecases/get_object_usecase.dart';
import 'package:logiks_crud_app/features/objects/domain/usecases/get_objects_usecase.dart';
import 'package:logiks_crud_app/features/objects/domain/usecases/partially_update_object_usecase.dart';
import 'package:logiks_crud_app/features/objects/domain/usecases/update_object_usecase.dart';

// Presentation (BLoCs)
import 'package:logiks_crud_app/features/objects/presentation/bloc/action/object_action_bloc.dart';
import 'package:logiks_crud_app/features/objects/presentation/bloc/details/object_details_bloc.dart';
import 'package:logiks_crud_app/features/objects/presentation/bloc/list/object_list_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Presentation (BLoCs)
  sl.registerFactory(() => ObjectListBloc(getObjectsUseCase: sl()));

  sl.registerFactory(() => ObjectDetailsBloc(getObjectUseCase: sl()));

  sl.registerFactory(
    () => ObjectActionBloc(
      createObjectUseCase: sl(),
      updateObjectUseCase: sl(),
      partiallyUpdateObjectUseCase: sl(),
      deleteObjectUseCase: sl(),
    ),
  );

  // Use Cases - LazySingleton
  sl.registerLazySingleton(() => CreateObjectUseCase(sl()));
  sl.registerLazySingleton(() => DeleteObjectUseCase(sl()));
  sl.registerLazySingleton(() => GetObjectUseCase(sl()));
  sl.registerLazySingleton(() => GetObjectsUseCase(sl()));
  sl.registerLazySingleton(() => PartiallyUpdateObjectUseCase(sl()));
  sl.registerLazySingleton(() => UpdateObjectUseCase(sl()));

  // Repository - LazySingleton
  sl.registerLazySingleton<ObjectRepository>(
    () => ObjectRepositoryImpl(remoteDataSource: sl()),
  );

  // Data Sources - LazySingleton
  sl.registerLazySingleton<ObjectRemoteDataSource>(
    () => ObjectRemoteDataSourceImpl(dio: sl()),
  );

  // Core - LazySingleton
  sl.registerLazySingleton(() => ApiClient());
  sl.registerLazySingleton<Dio>(() => sl<ApiClient>().dio);
}
