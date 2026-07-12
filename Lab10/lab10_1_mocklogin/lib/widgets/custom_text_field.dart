import 'package:flutter/material.dart';

/// Reusable text field widget.
///
/// Instead of creating multiple TextField widgets,
/// we create one reusable component.
///
/// Benefits:
/// - Cleaner UI code
/// - Easier maintenance
/// - Consistent design
class CustomTextField extends StatelessWidget {
  final String label;

  final TextEditingController controller;

  final bool obscureText;

  final TextInputType keyboardType;

  const CustomTextField({
    super.key,

    required this.label,

    required this.controller,

    this.obscureText = false,

    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,

      obscureText: obscureText,

      keyboardType: keyboardType,

      decoration: InputDecoration(
        labelText: label,

        border: const OutlineInputBorder(),
      ),
    );
  }
}
