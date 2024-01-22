import 'package:flutter/material.dart';
import '../feature/router.dart';

class introScreen extends StatefulWidget {
  static const routername = "/introScreen";

  const introScreen({Key? key}) : super(key: key);

  @override
  _introScreenState createState() => _introScreenState();
}

class _introScreenState extends State<introScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Braille App'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tamil to Braille App',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Explore the world of Braille',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                'PDF Conversion',
                style: TextStyle(fontSize: 16.0),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/fileUpload');
              },
            ),
            ListTile(
              title: Text(
                'Braille to Tamil',
                style: TextStyle(fontSize: 16.0),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/brailleToTamil');
              },
            ),
            ListTile(
              title: Text(
                'Tamil to Braille',
                style: TextStyle(fontSize: 16.0),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/tamilToBraily');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome to the Braille App!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Braille is a tactile writing system used by people who are visually impaired. It is traditionally written with embossed paper. Each Braille character is made up of six dots, arranged in two columns of three dots each.',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to the main part of your app
                // Replace 'YourMainScreen()' with the actual widget/screen you want to navigate to.
                Navigator.pushNamed(context, "/tamilToBraily");
              },
              child: Text('Start Exploring'),
            ),
          ],
        ),
      ),
    );
  }
}
