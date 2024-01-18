import 'package:flutter/material.dart';
import 'package:kanitamilapp2/screens/intro.dart';
class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {

  @override
void initState(){
  super.initState();
  _navigateToHome();
}
  _navigateToHome() async{
await Future.delayed(Duration(milliseconds: 1500),(){});
Navigator.pushNamed(context,introScreen.routername );
}

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      body: Center(
        child: Container(
          height: 100.0, // Set the desired height
          width: 100.0,  // Set the desired width
          decoration: BoxDecoration(
            color: Colors.white, // Set the background color of the container
          ),
          child: Image(
            image: AssetImage('assets/logo.png'),
            fit: BoxFit.contain,  // Adjust the fit as needed
          ),
        ),
      ),
    );
  }
}
