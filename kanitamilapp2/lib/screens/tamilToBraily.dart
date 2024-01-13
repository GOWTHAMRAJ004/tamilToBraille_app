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
String url='';
late int value;
 var data=['⠧⠼⠅⠈⠅⠍⠈','⠏⠥⠧⠊⠽⠊⠽⠇⠈ ⠏⠗⠧⠇⠈','⠏⠥⠗⠜⠼','⠧⠅⠌⠏⠈⠏⠜⠾⠥'];

Map<String,dynamic> tamilvalue={};
  TextEditingController _inputController = TextEditingController();

@override
void initState() {
  super.initState();
  value = -1; // Initialize value to -1
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tamil and Braille Converter'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
Text("Tamil text:" ,style: TextStyle(
  fontSize: 18,fontWeight: FontWeight.bold
),),
            SizedBox(height: 10),
          TextField(
            onChanged: (value){
              url='http://127.0.0.1:9090/tests?query=' + value.toString();
            },
          ),
            SizedBox(height: 20),
            button(() {
              setState(() {
               value++;
              });

            }, "convert"),
            SizedBox(height: 20),
            Text(
              'Converted Braille Text:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
        outputbox(outputText: (value >= 0 && value < data.length) ? data[value] : ''),

          ],
        ),
      ),
    );
  }
}

