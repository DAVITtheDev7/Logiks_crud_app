import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/action/object_action_bloc.dart';
import '../bloc/action/object_action_state.dart';

class ObjectFormSubmitButton extends StatelessWidget {
  final VoidCallback onSubmit;

  const ObjectFormSubmitButton({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ObjectActionBloc, ObjectActionState>(
      builder: (context, state) {
        if (state is ObjectActionLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return ElevatedButton(
          onPressed: onSubmit,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
          ),
          child: const Text('Save'),
        );
      },
    );
  }
}
