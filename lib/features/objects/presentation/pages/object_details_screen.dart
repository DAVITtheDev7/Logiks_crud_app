import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/details/object_details_bloc.dart';
import '../bloc/details/object_details_event.dart';
import '../bloc/details/object_details_state.dart';
import '../bloc/action/object_action_bloc.dart';
import '../bloc/action/object_action_state.dart';
import '../bloc/list/object_list_bloc.dart';
import '../bloc/list/object_list_event.dart';

import 'object_form_screen.dart';
import '../widgets/quick_rename_dialog.dart';
import '../widgets/delete_confirmation_dialog.dart';
import '../widgets/object_data_display.dart';

class ObjectDetailsScreen extends StatefulWidget {
  final String objectId;

  const ObjectDetailsScreen({super.key, required this.objectId});

  @override
  State<ObjectDetailsScreen> createState() => _ObjectDetailsScreenState();
}

class _ObjectDetailsScreenState extends State<ObjectDetailsScreen> {
  @override
  void initState() {
    super.initState();

    context.read<ObjectDetailsBloc>().add(
      GetSingleObjectEvent(widget.objectId),
    );
  }

  void _refreshDetailsAndList() {
    context.read<ObjectDetailsBloc>().add(
      GetSingleObjectEvent(widget.objectId),
    );
    context.read<ObjectListBloc>().add(LoadObjectsEvent());
  }

  Future<void> _openEditScreen(ObjectDetailsLoaded state) async {
    final message = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => ObjectFormScreen(existingObject: state.object),
      ),
    );

    if (!mounted || message == null) return;

    _refreshDetailsAndList();

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.green),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ObjectActionBloc, ObjectActionState>(
      listenWhen: (previous, current) {
        return current is ObjectActionSuccess || current is ObjectActionError;
      },
      listener: (context, state) {
        final isCurrentRoute = ModalRoute.of(context)?.isCurrent ?? false;
        if (!isCurrentRoute) return;

        if (state is ObjectActionSuccess) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );

          if (state.message.toLowerCase().contains('deleted')) {
            context.read<ObjectListBloc>().add(LoadObjectsEvent());
            Navigator.pop(context);
            return;
          }

          _refreshDetailsAndList();
        }

        if (state is ObjectActionError) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Object Details'),
          actions: [
            BlocBuilder<ObjectDetailsBloc, ObjectDetailsState>(
              builder: (context, state) {
                if (state is! ObjectDetailsLoaded) {
                  return const SizedBox.shrink();
                }

                final obj = state.object;

                return Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.flash_on, color: Colors.orange),
                      tooltip: 'Quick Rename',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => QuickRenameDialog(
                            objectId: obj.id,
                            currentName: obj.name,
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      tooltip: 'Full Edit',
                      onPressed: () => _openEditScreen(state),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      tooltip: 'Delete',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) =>
                              DeleteConfirmationDialog(objectId: obj.id),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<ObjectDetailsBloc, ObjectDetailsState>(
          builder: (context, state) {
            if (state is ObjectDetailsLoading ||
                state is ObjectDetailsInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ObjectDetailsError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (state is ObjectDetailsLoaded) {
              final obj = state.object;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ID: ${obj.id}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      obj.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(height: 32),
                    const Text(
                      'Data:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ObjectDataDisplay(data: obj.data),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
