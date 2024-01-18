import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kanitamilapp2/common/button.dart';
import 'package:kanitamilapp2/common/output.dart';
import 'package:kanitamilapp2/common/textarea.dart';
import 'dart:convert';

import '../API/API.dart';
class tamilToBraily extends StatefulWidget {
  static const routename="/tamilToBraily";
  @override
  _tamilToBrailyState createState() => _tamilToBrailyState();
}
class _tamilToBrailyState extends State<tamilToBraily> {

  String brailleText = '';
  String tamilResult = '';
  Future<void> convertToTamil() async {
    Map<String, dynamic> result = await convertTamilToBraille(brailleText);

    if (result['success']) {
      setState(() {
        tamilResult = result['result'];
      });
    } else {
      print(result['error']);
    }
  }

  TextEditingController _inputController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tamil and Braille Converter'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Tamil text:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  brailleText = value; // Capture the value from the TextField
                },
                controller: _inputController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Enter a Tamil text',
                ),
              ),
              SizedBox(height: 20),
              button(() async {
                convertToTamil();
              }, "Convert"),
              SizedBox(height: 20),
              Text(
                'Converted Braille Text:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              outputbox(outputText:tamilResult ),
              SizedBox(height: 20),
              button(() {
                setState(() {
                  _inputController.text='';
                  tamilResult='';
                });

              }, 'clear')
            ],
          ),
        ),
      ),
    );
  }
}
