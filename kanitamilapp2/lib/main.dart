import 'package:flutter/material.dart';
import 'package:kanitamilapp2/feature/router.dart';
import 'package:kanitamilapp2/screens/intro.dart';
import 'package:kanitamilapp2/screens/tamilToBraily.dart';

import 'feature/splashScreen.dart';

import 'package:alan_voice/alan_voice.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _initAlanButton();
  }

  void _initAlanButton() {
    AlanVoice.addButton("f2acbdccf0a718459fa94552bda1c9732e956eca572e1d8b807a3e2338fdd0dc/stage");

    AlanVoice.onCommand.add((command) {
      _handleCommand(command.data);
    });

    AlanVoice.onEvent.add((event) {
      _handleCommand(event.data);
    });

    AlanVoice.onButtonState.add((state) {
      debugPrint("got new button state ${state.name}");
      // Depending on your use case, you may handle button state here.
    });
  }

  void _handleCommand(Map<String, dynamic> command) {
    if (NavigatorKey.navigatorKey.currentState != null) {
      switch (command["command"]) {
        case 'start Exploring':
          NavigatorKey.navigatorKey.currentState!.pushNamed('/tamilToBraily');
          break;
        case "home page":
          NavigatorKey.navigatorKey.currentState!.pushNamed('/introScreen');
          break;
        case "pdfconversion":
          NavigatorKey.navigatorKey.currentState!.pushNamed('/fileUpload');
          break;
        case "braille to tamil":
          NavigatorKey.navigatorKey.currentState!.pushNamed('/brailleToTamil');
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     onGenerateRoute:(settings)=> generateRoute(settings),
      home:  splashScreen(),
      navigatorKey: NavigatorKey.navigatorKey,
    );
  }
}

class NavigatorKey {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
