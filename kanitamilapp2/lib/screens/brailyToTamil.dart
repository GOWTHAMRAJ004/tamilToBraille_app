import 'package:flutter/material.dart';

import '../API/API.dart';
import '../common/button.dart';
import '../common/output.dart';
import '../common/textarea.dart';
class brailyToTamil extends StatefulWidget {
  static const routername="/brailyToTamil";
  const brailyToTamil({super.key});

  @override
  State<brailyToTamil> createState() => _brailyToTamilState();
}

class _brailyToTamilState extends State<brailyToTamil> {
  TextEditingController _inputController = TextEditingController();
  String _convertedText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('braily and tamil convertor'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text("braily text:" ,style: TextStyle(
                fontSize: 18,fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 10),
            textarea(_inputController),
            SizedBox(height: 20),
            button(() async{

            }, "convert"),
            SizedBox(height: 20),
            Text(
              'Converted tamil Text:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            outputbox(outputText: "hi"),
          ],
        ),
      ),
    );
  }
}
