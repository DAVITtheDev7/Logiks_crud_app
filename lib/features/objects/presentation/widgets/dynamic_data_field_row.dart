import 'package:flutter/material.dart';
import '../models/data_field_model.dart';

class DynamicDataFieldRow extends StatelessWidget {
  final DataFieldModel field;
  final VoidCallback onRemove;

  const DynamicDataFieldRow({
    super.key,
    required this.field,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: field.keyController,
              decoration: const InputDecoration(
                hintText: 'Key (e.g. Color)',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              controller: field.valueController,
              decoration: const InputDecoration(
                hintText: 'Value (e.g. Red)',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
            onPressed: onRemove,
            tooltip: 'Remove field',
          ),
        ],
      ),
    );
  }
}
