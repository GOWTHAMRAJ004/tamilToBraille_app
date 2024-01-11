import 'package:flutter/material.dart';
import 'package:kanitamilapp2/feature/router.dart';
import 'package:kanitamilapp2/screens/intro.dart';
import 'package:kanitamilapp2/screens/tamilToBraily.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     onGenerateRoute:(settings)=> generateRoute(settings),
      home:  introScreen(),
    );
  }
}
