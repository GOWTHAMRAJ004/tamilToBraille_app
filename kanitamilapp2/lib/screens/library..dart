import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class PdfUploadScreen extends StatefulWidget {
  static const routername ="/PdfUploadScreen";
  @override
  _PdfUploadScreenState createState() => _PdfUploadScreenState();
}

class _PdfUploadScreenState extends State<PdfUploadScreen> {
  String _extractedText = '';

  // Function to pick a PDF file
  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      // Handle the picked file, e.g., send it to the API
      String filePath = result.files.single.path!;
      await _uploadPDF(filePath);
    }
  }

  // Function to upload the PDF file to the API
  Future<void> _uploadPDF(String filePath) async {
    // Replace 'YOUR_API_ENDPOINT' with the actual API endpoint
    String apiEndpoint = 'YOUR_API_ENDPOINT';

    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(apiEndpoint));

    // Add the PDF file to the request
    request.files.add(await http.MultipartFile.fromPath('pdf', filePath));

    // Send the request
    var response = await request.send();

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      // Decode the response body (assuming it's a JSON string)
      Map<String, dynamic> data = json.decode(await response.stream.bytesToString());

      // Extracted text from the API response
      String extractedText = data['extractedText'];

      // Update the state to trigger a UI update
      setState(() {
        _extractedText = extractedText;
      });
    } else {
      // Handle the error
      print('Error uploading PDF. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _pickPDF,
              child: Text('Pick PDF'),
            ),
            SizedBox(height: 20),
            Text(
              'Extracted Text:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              _extractedText,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
