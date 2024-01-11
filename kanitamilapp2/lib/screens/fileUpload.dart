import 'dart:io'; // Import 'dart:io' for the File class
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FileUpload extends StatefulWidget {
  static const routername = "/fileUpload";

  const FileUpload({Key? key}) : super(key: key);

  @override
  State<FileUpload> createState() => _FileUploadState();
}

class _FileUploadState extends State<FileUpload> {
  File? _pickedFile; // Use File? to handle the possibility of no file being picked

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _pickedFile = File(result.files.single.path!);
      });
    }
  }

  void _uploadFile() async {
    if (_pickedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("No file selected"),
        ),
      );
      return;
    }

    // Replace "YOUR_API_ENDPOINT" with your actual API endpoint
    String apiEndpoint = "YOUR_API_ENDPOINT";

    // Make API request
    try {
      // Use http.MultipartFile.fromBytes for file content
      http.MultipartFile file = http.MultipartFile.fromBytes(
        'file',
        await _pickedFile!.readAsBytes(),
        filename: _pickedFile!.path.split('/').last,
      );

      // Create a MultipartRequest to handle file upload
      var request = http.MultipartRequest('POST', Uri.parse(apiEndpoint))
        ..files.add(file);

      // Send the request
      var response = await request.send();

      // Handle the API response
      if (response.statusCode == 200) {
        print("File uploaded successfully");
        print(await response.stream.bytesToString());
      } else {
        print("Error uploading file: ${response.statusCode}");
      }
    } catch (error) {
      print("Error uploading file: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Upload Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _pickFile,
              child: Text("Pick a File"),
            ),
            SizedBox(height: 20),
            _pickedFile != null
                ? Text("Selected File: ${_pickedFile!.path}")
                : Text("No file selected"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadFile,
              child: Text("Upload File"),
            ),
          ],
        ),
      ),
    );
  }
}
