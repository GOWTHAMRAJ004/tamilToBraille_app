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

 Map<String,dynamic> tamilvalue={};
  TextEditingController _inputController = TextEditingController();


  Future<void> fetchDataFromAPI() async {

    final response=await http.get(Uri.parse("http://127.0.0.1:5000/tests"));
    if(response.statusCode==200) {
      setState(() {
        tamilvalue= jsonDecode(response.body);
      });
    }else{
      print("error occur in the following");
    }
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
            textarea(_inputController),
            SizedBox(height: 20),
            button(() async{
              await fetchDataFromAPI();
            }, "convert"),
            SizedBox(height: 20),
            Text(
              'Converted Braille Text:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
        outputbox(outputText: tamilvalue["response"] ?? 'No data available'),
          ],
        ),
      ),
    );
  }
}

