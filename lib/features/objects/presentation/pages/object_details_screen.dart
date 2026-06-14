import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Core
import 'package:logiks_crud_app/core/errors/error_parser.dart';

// BLoCs
import '../bloc/details/object_details_bloc.dart';
import '../bloc/details/object_details_event.dart';
import '../bloc/details/object_details_state.dart';
import '../bloc/action/object_action_bloc.dart';
import '../bloc/action/object_action_state.dart';
import '../bloc/list/object_list_bloc.dart';
import '../bloc/list/object_list_event.dart';

// Screens and Widgets
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<ObjectActionBloc, ObjectActionState>(
      listener: (context, state) {
        if (state is ObjectActionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );

          if (state.message.toLowerCase().contains('deleted')) {
            context.read<ObjectListBloc>().add(LoadObjectsEvent());
            Navigator.pop(context);
          } else {
            context.read<ObjectDetailsBloc>().add(
              GetSingleObjectEvent(widget.objectId),
            );
            context.read<ObjectListBloc>().add(LoadObjectsEvent());
          }
        } else if (state is ObjectActionError) {
          final parsedMessage = ErrorParser.parse(
            state.message,
            contextId: widget.objectId,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(parsedMessage), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Object Details'),
          actions: [
            BlocBuilder<ObjectDetailsBloc, ObjectDetailsState>(
              builder: (context, state) {
                if (state is ObjectDetailsLoaded) {
                  final obj = state.object;
                  return Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.flash_on, color: Colors.orange),
                        tooltip: 'Quick Rename',
                        onPressed: () => showDialog(
                          context: context,
                          builder: (_) => QuickRenameDialog(
                            objectId: obj.id,
                            currentName: obj.name,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        tooltip: 'Full Edit',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ObjectFormScreen(existingObject: obj),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        tooltip: 'Delete',
                        onPressed: () => showDialog(
                          context: context,
                          builder: (_) =>
                              DeleteConfirmationDialog(objectId: obj.id),
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        body: BlocBuilder<ObjectDetailsBloc, ObjectDetailsState>(
          builder: (context, state) {
            if (state is ObjectDetailsLoading ||
                state is ObjectDetailsInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ObjectDetailsError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (state is ObjectDetailsLoaded) {
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
