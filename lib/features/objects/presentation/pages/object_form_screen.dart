import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Core / Domain
import 'package:logiks_crud_app/features/objects/domain/entities/my_object_entity.dart';

// BLoCs
import '../bloc/action/object_action_bloc.dart';
import '../bloc/action/object_action_event.dart';
import '../bloc/action/object_action_state.dart';
import '../bloc/list/object_list_bloc.dart';
import '../bloc/list/object_list_event.dart';

// Models and Widgets
import '../models/data_field_model.dart';
import '../widgets/dynamic_data_field_row.dart';
import '../widgets/object_form_submit_button.dart';

class ObjectFormScreen extends StatefulWidget {
  final MyObjectEntity? existingObject;

  const ObjectFormScreen({super.key, this.existingObject});

  @override
  State<ObjectFormScreen> createState() => _ObjectFormScreenState();
}

class _ObjectFormScreenState extends State<ObjectFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  final List<DataFieldModel> _dataFields = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.existingObject?.name ?? '',
    );

    if (widget.existingObject?.data != null &&
        widget.existingObject!.data!.isNotEmpty) {
      widget.existingObject!.data!.forEach((key, value) {
        _dataFields.add(
          DataFieldModel(
            keyController: TextEditingController(text: key),
            valueController: TextEditingController(text: value.toString()),
          ),
        );
      });
    } else {
      _addField();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    for (var field in _dataFields) {
      field.dispose();
    }
    super.dispose();
  }

  void _addField() {
    setState(() {
      _dataFields.add(
        DataFieldModel(
          keyController: TextEditingController(),
          valueController: TextEditingController(),
        ),
      );
    });
  }

  void _removeField(int index) {
    setState(() {
      _dataFields[index].dispose();
      _dataFields.removeAt(index);
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    Map<String, dynamic> parsedData = {};

    for (var field in _dataFields) {
      final key = field.keyController.text.trim();
      final value = field.valueController.text.trim();

      if (key.isNotEmpty && value.isNotEmpty) {
        if (value.toLowerCase() == 'true') {
          parsedData[key] = true;
        } else if (value.toLowerCase() == 'false') {
          parsedData[key] = false;
        } else if (num.tryParse(value) != null) {
          parsedData[key] = num.parse(value);
        } else {
          parsedData[key] = value;
        }
      }
    }

    final event = widget.existingObject == null
        ? CreateObjectEvent(
            name: _nameController.text,
            data: parsedData.isNotEmpty ? parsedData : null,
          )
        : UpdateObjectEvent(
            id: widget.existingObject!.id,
            name: _nameController.text,
            data: parsedData.isNotEmpty ? parsedData : null,
          );

    context.read<ObjectActionBloc>().add(event);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingObject != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Object' : 'Add Object')),
      body: BlocListener<ObjectActionBloc, ObjectActionState>(
        listener: (context, state) {
          if (state is ObjectActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            context.read<ObjectListBloc>().add(LoadObjectsEvent());
            Navigator.pop(context);
          } else if (state is ObjectActionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name Field
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Name is required'
                      : null,
                ),
                const SizedBox(height: 24),

                // Properties Title
                const Text(
                  'Properties (Data)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                // Dynamic Fields
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _dataFields.length,
                  itemBuilder: (context, index) {
                    return DynamicDataFieldRow(
                      field: _dataFields[index],
                      onRemove: () => _removeField(index),
                    );
                  },
                ),

                // Add Button
                TextButton.icon(
                  onPressed: _addField,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Data Field'),
                ),
                const SizedBox(height: 32),

                // Submit Button
                ObjectFormSubmitButton(onSubmit: _submit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
