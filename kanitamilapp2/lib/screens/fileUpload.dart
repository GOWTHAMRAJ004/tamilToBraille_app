import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  static const routername = "/MyHomePage";
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late File _image = File('path_to_default_image');
  String _brailleText = "";

  Future<void> _getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _processImage() async {
    if (_image == null) {
      // Show an alert or message indicating that no image is selected
      return;
    }

    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse('http://your-api-endpoint.com/image-to-braille'));

    // Add the image file to the request
    request.files.add(await http.MultipartFile.fromPath('file', _image.path));

    try {
      // Send the request
      var response = await request.send();

      // Check if the response status code is OK (200)
      if (response.statusCode == 200) {
        // Read and decode the response
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseBody);

        // Update the UI with the Braille text
        setState(() {
          _brailleText = jsonResponse['braille_text'];
        });
      } else {
        // Handle non-OK response status codes, e.g., display an error message
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle errors, e.g., display an error message
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OCR analiyser'
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('No image selected.')
                : Image.file(_image, height: 200.0),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _getImage,
              child: Text('Select Image'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _processImage,
              child: Text('Process Image'),
            ),
            SizedBox(height: 20.0),
            Container(
              width: 300.0,
              height: 100.0,
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: Center(
                child: Text(_brailleText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
