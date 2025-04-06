
import 'package:flutter/material.dart';
import 'package:kanitamilapp2/screens/brailyToTamil.dart';
import 'package:kanitamilapp2/screens/chat_bot.dart';
import 'package:kanitamilapp2/screens/fileUpload.dart';
import 'package:kanitamilapp2/screens/intro.dart';
import 'package:kanitamilapp2/screens/tamilToBraily.dart';

import '../screens/library..dart';

Route<dynamic> generateRoute(RouteSettings routeSettings){
switch(routeSettings.name){
  case tamilToBraily.routename:
    return MaterialPageRoute(builder: (_)=>tamilToBraily());
  case introScreen.routername:
    return MaterialPageRoute(builder: (_)=> introScreen());
  case MyHomePage.routername:
    return MaterialPageRoute(builder: (_)=> MyHomePage());
  case brailleToTamil.routername:
    return MaterialPageRoute(builder: (_)=> brailleToTamil ());
  case ChatPage.routername:
    return MaterialPageRoute(builder: (_)=> ChatPage ());
  case PdfUploadScreen.routername:
    return MaterialPageRoute(builder: (_)=>PdfUploadScreen());
  default:
    return MaterialPageRoute(builder: (_)=> Scaffold(
      body: Center(
        child: Text("something went wrong "),
      ),
    ));
}
}