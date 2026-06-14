import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:logiks_crud_app/features/objects/domain/entities/my_object_entity.dart';
import 'package:logiks_crud_app/features/objects/domain/usecases/get_objects_usecase.dart';
import 'package:logiks_crud_app/features/objects/presentation/bloc/list/object_list_bloc.dart';
import 'package:logiks_crud_app/features/objects/presentation/bloc/list/object_list_event.dart';
import 'package:logiks_crud_app/features/objects/presentation/bloc/list/object_list_state.dart';

// Mock for the UseCase using Mocktail
class MockGetObjectsUseCase extends Mock implements GetObjectsUseCase {}

void main() {
  late ObjectListBloc bloc;
  late MockGetObjectsUseCase mockGetObjectsUseCase;

  // Setup runs before every single test
  setUp(() {
    mockGetObjectsUseCase = MockGetObjectsUseCase();
    bloc = ObjectListBloc(getObjectsUseCase: mockGetObjectsUseCase);
  });

  // TearDown runs after every test to clean up memory
  tearDown(() {
    bloc.close();
  });

  // A dummy object to use in our successful test
  final tObjectList = [
    const MyObjectEntity(
      id: '1',
      name: 'Test Device',
      data: {'color': 'red', 'price': 999},
    ),
  ];

  group('ObjectListBloc', () {
    test('initial state should be ObjectListInitial', () {
      expect(bloc.state, isA<ObjectListInitial>());
    });

    // Test the Success Path
    blocTest<ObjectListBloc, ObjectListState>(
      'emits [ObjectListLoading, ObjectListLoaded] when LoadObjectsEvent is added and succeeds',
      build: () {
        // Arrange: Tell the mock what to return when called
        when(
          () => mockGetObjectsUseCase(),
        ).thenAnswer((_) async => tObjectList);
        return bloc;
      },
      act: (bloc) => bloc.add(LoadObjectsEvent()),
      // Assert: Verify the exact sequence of states emitted
      expect: () => [isA<ObjectListLoading>(), ObjectListLoaded(tObjectList)],
      verify: (_) {
        // Verify the usecase was actually called exactly once
        verify(() => mockGetObjectsUseCase()).called(1);
      },
    );

    // Test the Error Path
    blocTest<ObjectListBloc, ObjectListState>(
      'emits [ObjectListLoading, ObjectListError] when LoadObjectsEvent fails',
      build: () {
        // Arrange: Force the mock to throw an exception
        when(
          () => mockGetObjectsUseCase(),
        ).thenThrow(Exception('Server failure'));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadObjectsEvent()),
      expect: () => [
        isA<ObjectListLoading>(),
        const ObjectListError('Failed to load objects. Please try again.'),
      ],
    );
  });
}
