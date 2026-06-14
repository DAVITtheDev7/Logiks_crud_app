import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logiks_crud_app/features/objects/presentation/bloc/action/object_action_bloc.dart';
import 'package:logiks_crud_app/features/objects/presentation/bloc/action/object_action_event.dart';

class QuickRenameDialog extends StatefulWidget {
  final String objectId;
  final String currentName;

  const QuickRenameDialog({
    super.key,
    required this.objectId,
    required this.currentName,
  });

  @override
  State<QuickRenameDialog> createState() => _QuickRenameDialogState();
}

class _QuickRenameDialogState extends State<QuickRenameDialog> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Quick Rename (Patch)'),
      content: TextField(
        controller: _nameController,
        decoration: const InputDecoration(
          labelText: 'Object Name',
          hintText: 'Enter updated name',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<ObjectActionBloc>().add(
              PartiallyUpdateObjectEvent(
                id: widget.objectId,
                name: _nameController.text.trim(),
              ),
            );
            Navigator.pop(context);
          },
          child: const Text('Update'),
        ),
      ],
    );
  }
}
