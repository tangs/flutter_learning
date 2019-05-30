import 'package:flutter/material.dart';

class WidgetTools {
  static Widget buildTextField(String label, TextInputType keyboardType, callback) {
    return TextField(
      controller: new TextEditingController(),
      decoration: new InputDecoration(
        hintText: label,
      ),
      keyboardType: keyboardType,
      onChanged: callback,
    );
  }
}
