import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/action/object_action_bloc.dart';
import '../bloc/action/object_action_event.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final String objectId;

  const DeleteConfirmationDialog({super.key, required this.objectId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Object'),
      content: const Text(
        'Are you sure you want to delete this object? This action cannot be undone.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            context.read<ObjectActionBloc>().add(DeleteObjectEvent(objectId));
            Navigator.pop(context);
          },
          child: const Text('Delete', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
