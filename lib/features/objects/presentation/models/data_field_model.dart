import 'package:flutter/material.dart';

class DataFieldModel {
  final TextEditingController keyController;
  final TextEditingController valueController;

  DataFieldModel({required this.keyController, required this.valueController});

  void dispose() {
    keyController.dispose();
    valueController.dispose();
  }
}
