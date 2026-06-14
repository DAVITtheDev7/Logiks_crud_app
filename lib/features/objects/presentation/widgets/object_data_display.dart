import 'package:flutter/material.dart';

class ObjectDataDisplay extends StatelessWidget {
  final Map<String, dynamic>? data;

  const ObjectDataDisplay({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    if (data == null || data!.isEmpty) {
      return const Text(
        'No additional data available.',
        style: TextStyle(fontStyle: FontStyle.italic),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: data!.entries
          .map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                '• ${e.key}: ${e.value}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          )
          .toList(),
    );
  }
}
