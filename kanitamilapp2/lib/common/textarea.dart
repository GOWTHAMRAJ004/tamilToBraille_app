import 'package:flutter/material.dart';
class textarea extends StatelessWidget {
  final TextEditingController inputcontroller;
  const textarea(this.inputcontroller);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value){

      },

      controller: inputcontroller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: 'Enter a tamiltext',
      ),
    );
  }
}
