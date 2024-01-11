import 'package:flutter/material.dart';

import '../feature/router.dart';
class introScreen extends StatefulWidget {
  static const routername="/introScreen";
  const introScreen({super.key});

  @override
  State<introScreen> createState() => _introScreenState();
}

class _introScreenState extends State<introScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(

),
      drawer: Drawer(

        child: ListView(

          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            Divider(),
            ListTile(

              title: const Text('pfd convertion'),
              onTap: () {
                Navigator.pushNamed(context, '/fileUpload');
               // Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              title: const Text('breily to tamil'),
              onTap: () {
                Navigator.pushNamed(context, '/brailyToTamil');
              //  Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              title: const Text('tamil to braily'),
              onTap: () {

                Navigator.pushNamed(context,'/tamilToBraily');
               // Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text("this screen will be updated soons"),
      ),
    );
  }
}
