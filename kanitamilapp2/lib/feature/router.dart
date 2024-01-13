
import 'package:flutter/material.dart';
import 'package:kanitamilapp2/screens/brailyToTamil.dart';
import 'package:kanitamilapp2/screens/fileUpload.dart';
import 'package:kanitamilapp2/screens/intro.dart';
import 'package:kanitamilapp2/screens/tamilToBraily.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings){
switch(routeSettings.name){
  case tamilToBraily.routename:
    return MaterialPageRoute(builder: (_)=>tamilToBraily());
  case introScreen.routername:
    return MaterialPageRoute(builder: (_)=> introScreen());
  case FileUpload.routername:
    return MaterialPageRoute(builder: (_)=> FileUpload());
  case brailleToTamil.routername:
    return MaterialPageRoute(builder: (_)=> brailleToTamil ());
  default:
    return MaterialPageRoute(builder: (_)=> Scaffold(
      body: Center(
        child: Text("something went wrong "),
      ),
    ));
}
}