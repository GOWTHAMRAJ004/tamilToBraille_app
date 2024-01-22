import 'package:flutter/material.dart';
import '../API/API.dart';
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
  String brailleText = '';
  String tamilResult = '';
  Future<void> convertbrailleToTamil() async {
    Map<String, dynamic> result = await convertBrailleToTamil(brailleText);

    if (result['success']) {
      setState(() {
        tamilResult = result['result'];
      });
    } else {
      print(result['error']);
    }
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
              convertbrailleToTamil();
            }, "Convert"),
            SizedBox(height: 20),
            Text(
              'Converted Tamil Text:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            outputbox(outputText:  tamilResult ),
            ElevatedButton(onPressed: (){
              Navigator.pushNamed(context, '/introScreen');
            }, child: Text("back"))
          ],
        ),
      ),
    );
  }
}
