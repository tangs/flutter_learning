import 'package:flutter/material.dart';

class WidgetTools {
  static Widget buildTextField(String label, TextInputType keyboardType, callback, String text) {
    return TextField(
      controller: new TextEditingController.fromValue(
        TextEditingValue(
          text: text,
          selection: TextSelection.fromPosition(
            TextPosition(
              affinity: TextAffinity.downstream,
              offset: text.length,
            )
          ),
        ),
      ),
      decoration: new InputDecoration(
        labelText: label,
      ),
      keyboardType: keyboardType,
      onChanged: callback,
      
    );
  }
}
