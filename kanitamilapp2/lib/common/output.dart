import 'package:flutter/material.dart';
class outputbox extends StatelessWidget {
  final String outputText;
  const outputbox({required this.outputText});

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      padding: EdgeInsets.all(10.0),
      child: Text(
        outputText,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
