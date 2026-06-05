import 'package:flutter/material.dart';

/// Exercise 2 - Input Widgets
///
/// Required widgets:
/// - Slider
/// - Switch
/// - RadioListTile
/// - DatePicker
///
/// This screen must be StatefulWidget because user input changes the UI.
class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});

  @override
  State<InputControlsDemo> createState() => _InputControlsDemoState();
}

class _InputControlsDemoState extends State<InputControlsDemo> {
  // Stores the current slider value.
  double rating = 5;

  // Stores the current switch value.
  bool isActive = false;

  // Stores the currently selected radio option.
  String selectedGenre = 'Action';

  // Stores the selected date.
  // It is nullable because the user may not select a date yet.
  DateTime? selectedDate;

  /// Opens a Material DatePicker dialog.
  ///
  /// showDatePicker returns Future<DateTime?> because the result is available
  /// later, after the user selects a date or cancels the dialog.
  Future<void> pickDate() async {
    final result = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    // If result is not null, the user selected a date.
    if (result != null) {
      setState(() {
        selectedDate = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateText = selectedDate == null
        ? 'No date selected'
        : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 2 - Input Controls'),
      ),

      // ListView prevents overflow on small screens.
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Rating (Slider)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          // Slider lets users select a numeric value from a range.
          Slider(
            value: rating,
            min: 0,
            max: 10,
            divisions: 10,
            label: rating.toStringAsFixed(0),
            onChanged: (value) {
              setState(() {
                rating = value;
              });
            },
          ),

          Text('Current rating: ${rating.toStringAsFixed(0)}'),

          const SizedBox(height: 24),

          const Text(
            'Active (Switch)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          // SwitchListTile combines a Switch with a text label.
          SwitchListTile(
            title: const Text('Is movie active?'),
            value: isActive,
            onChanged: (value) {
              setState(() {
                isActive = value;
              });
            },
          ),

          const SizedBox(height: 24),

          const Text(
            'Genre (RadioListTile)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          // RadioListTile is used when only one option can be selected.
          RadioListTile<String>(
            title: const Text('Action'),
            value: 'Action',
            groupValue: selectedGenre,
            onChanged: (value) {
              setState(() {
                selectedGenre = value!;
              });
            },
          ),

          RadioListTile<String>(
            title: const Text('Comedy'),
            value: 'Comedy',
            groupValue: selectedGenre,
            onChanged: (value) {
              setState(() {
                selectedGenre = value!;
              });
            },
          ),

          RadioListTile<String>(
            title: const Text('Drama'),
            value: 'Drama',
            groupValue: selectedGenre,
            onChanged: (value) {
              setState(() {
                selectedGenre = value!;
              });
            },
          ),

          Text('Selected genre: $selectedGenre'),

          const SizedBox(height: 24),

          Text('Selected date: $dateText'),

          const SizedBox(height: 12),

          ElevatedButton(
            onPressed: pickDate,
            child: const Text('Open Date Picker'),
          ),
        ],
      ),
    );
  }
}