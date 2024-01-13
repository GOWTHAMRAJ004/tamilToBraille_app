import 'package:flutter/material.dart';
import '../common/button.dart';
import '../common/output.dart';
import '../common/textarea.dart';

class brailleToTamil extends StatefulWidget {
  static const routername = "/brailleToTamil";

  const brailleToTamil({Key? key}) : super(key: key);

  @override
  State<brailleToTamil> createState() => _brailleToTamilState();
}

class _brailleToTamilState extends State<brailleToTamil> {
  TextEditingController _inputController = TextEditingController();
  String _convertedText = '';

  var data = ['வணக்கம்', 'புவியியல் பரவல்', 'புராண', 'வகைப்பாடு'];
  late int value;

  @override
  void initState() {
    super.initState();
    value = -1; // Initialize value to -1
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Braille and Tamil Converter'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Braille text:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            textarea(_inputController),
            SizedBox(height: 20),
            button(() async {
              setState(() {
                value++;
              });
            }, "Convert"),
            SizedBox(height: 20),
            Text(
              'Converted Tamil Text:',
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
