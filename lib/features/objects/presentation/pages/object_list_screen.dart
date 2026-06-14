import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// BLoCs
import '../bloc/list/object_list_bloc.dart';
import '../bloc/list/object_list_event.dart';
import '../bloc/list/object_list_state.dart';

// Screens
import 'object_details_screen.dart';
import 'object_form_screen.dart';

class ObjectListScreen extends StatelessWidget {
  const ObjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Objects'), centerTitle: true),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ObjectListBloc>().add(LoadObjectsEvent());
          await Future.delayed(const Duration(milliseconds: 500));
        },
        child: BlocBuilder<ObjectListBloc, ObjectListState>(
          builder: (context, state) {
            // Loading State
            if (state is ObjectListInitial || state is ObjectListLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            // Error State
            else if (state is ObjectListError) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Pull down to try again',
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }
            // Loaded State
            else if (state is ObjectListLoaded) {
              if (state.objects.isEmpty) {
                return ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                    const Center(child: Text('No objects found. Add one!')),
                  ],
                );
              }

              return ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.objects.length,
                itemBuilder: (context, index) {
                  final obj = state.objects[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      title: Text(
                        obj.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        'ID: ${obj.id}',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ObjectDetailsScreen(objectId: obj.id),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }

            // Fallback
            return const SizedBox.shrink();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ObjectFormScreen()),
          );
        },
        tooltip: 'Add new object',
        child: const Icon(Icons.add),
      ),
    );
  }
}
