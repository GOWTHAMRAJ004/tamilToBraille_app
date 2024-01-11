import 'package:flutter/material.dart';
class button extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const button(   this.onTap , this.text);

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
        onPressed: onTap,
      child: Text(text),
    style: ElevatedButton.styleFrom(
    foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color on the button
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Button padding
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0), // Button border radius
    ),
    ));
  }
}
