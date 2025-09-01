import 'package:flutter/material.dart';
import 'package:string_calculator_tdd_kata/string_calculator.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'String Calculator Demo',
      home: const MyHomePage(title: 'String Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = TextEditingController();
  final _calc = StringCalculator();
  String _result = "";

  void _calculate() {
    try {
      final sum = _calc.add(_controller.text);
      setState(() => _result = "Result: $sum");
    } catch (e) {
      setState(() => _result = "Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Enter numbers (e.g. 1,2,3)",
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _calculate,
              child: const Text("Calculate"),
            ),
            const SizedBox(height: 12),
            Text(_result),
          ],
        ),
      ),
    );
  }
}
