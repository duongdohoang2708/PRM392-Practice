import 'package:flutter/material.dart';

/// Exercise 5 - Debug & Fix Common UI Errors
///
/// Required fixes:
/// 1. Fix ListView inside Column using Expanded/SizedBox.
/// 2. Fix overflow using SingleChildScrollView.
/// 3. Fix state update issue by using setState().
/// 4. Fix DatePicker BuildContext issue by calling from a valid widget tree.
class CommonUiFixesDemo extends StatefulWidget {
  const CommonUiFixesDemo({super.key});

  @override
  State<CommonUiFixesDemo> createState() => _CommonUiFixesDemoState();
}

class _CommonUiFixesDemoState extends State<CommonUiFixesDemo> {
  final List<String> movies = [
    'Movie A',
    'Movie B',
    'Movie C',
    'Movie D',
  ];

  // Counter is used to demonstrate setState().
  int counter = 0;

  // Date selected from DatePicker.
  DateTime? selectedDate;

  /// Fix 3: State update issue.
  ///
  /// Any data change that should update the UI must be placed inside setState().
  /// setState() tells Flutter to rebuild this widget.
  void increaseCounter() {
    setState(() {
      counter++;
    });
  }

  /// Fix 4: DatePicker BuildContext issue.
  ///
  /// showDatePicker needs a valid BuildContext.
  /// Calling it inside a State class method is safe because this class
  /// has access to the current widget context.
  Future<void> pickDate() async {
    final result = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

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
        title: const Text('Exercise 5 - Common UI Fixes'),
      ),

      // Fix 2: Overflow issue.
      //
      // SingleChildScrollView makes the content scrollable.
      // This prevents overflow when the screen is too small.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Fix 1: ListView inside Column using SizedBox/Expanded',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            // Fix 1: ListView inside Column.
            //
            // A ListView needs a bounded height.
            // Since this Column is inside SingleChildScrollView,
            // Expanded is not suitable here.
            // Therefore, SizedBox gives the ListView a fixed height.
            SizedBox(
              height: 220,
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.movie),
                    title: Text(movies[index]),
                  );
                },
              ),
            ),

            const Divider(height: 32),

            const Text(
              'Fix 2: Overflow fixed by SingleChildScrollView',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              'This screen can scroll, so content will not overflow on small screens.',
            ),

            const Divider(height: 32),

            const Text(
              'Fix 3: State update using setState()',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text('Counter: $counter'),

            const SizedBox(height: 8),

            ElevatedButton(
              onPressed: increaseCounter,
              child: const Text('Increase Counter'),
            ),

            const Divider(height: 32),

            const Text(
              'Fix 4: DatePicker using valid BuildContext',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text('Selected date: $dateText'),

            const SizedBox(height: 8),

            ElevatedButton(
              onPressed: pickDate,
              child: const Text('Pick Date'),
            ),
          ],
        ),
      ),
    );
  }
}