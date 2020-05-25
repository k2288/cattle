import 'package:cattle/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(CattleApp());

class CattleApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: Locale("fa", "IR") ,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        fontFamily: "Iran_Sans",
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Color(0xFF39445a),
        accentColor: Color(0xFF369ee5),
        scaffoldBackgroundColor: Color(0xFFf8f9fe),
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          display1: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 13),
          display2: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),
          display3: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30),//detail
          display4: TextStyle(color: Colors.black,fontSize: 20),//detail

          button:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20) ,

          subtitle:TextStyle(color: Colors.black,fontSize: 13)
        )

      ),
      home: HomePage(),
    );
  }
}
