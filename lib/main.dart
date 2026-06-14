import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Injection
import 'package:logiks_crud_app/core/di/injection_container.dart' as di;

// BLoCs
import 'features/objects/presentation/bloc/list/object_list_bloc.dart';
import 'features/objects/presentation/bloc/list/object_list_event.dart';
import 'features/objects/presentation/bloc/details/object_details_bloc.dart';
import 'features/objects/presentation/bloc/action/object_action_bloc.dart';

// Screens
import 'features/objects/presentation/pages/object_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<ObjectListBloc>()..add(LoadObjectsEvent()),
        ),
        BlocProvider(create: (_) => di.sl<ObjectDetailsBloc>()),
        BlocProvider(create: (_) => di.sl<ObjectActionBloc>()),
      ],
      child: MaterialApp(
        title: 'Logiks CRUD App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
        home: const ObjectListScreen(),
      ),
    );
  }
}
