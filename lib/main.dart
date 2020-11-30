import 'dart:async';

import 'package:cattle/components/splash/splash_page.dart';
import 'package:cattle/models/LocaleModel.dart';
import 'package:cattle/utils/api/ApiProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sentry/sentry.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Add this line.

// final sentry = SentryClient(dsn: "https://bd54fe34ae6842839c652a7ab201b220@o459244.ingest.sentry.io/5458076");

Future main() async{

    WidgetsFlutterBinding.ensureInitialized();

    ApiProvider apiProvider=new ApiProvider();
    await apiProvider.init();
    runApp(CattleApp());
  // runZonedGuarded(
  //   () async{
        
  //   },
  //   (error, stackTrace) async {
  //     // await sentry.captureException(
  //     //   exception: error,
  //     //   stackTrace: stackTrace,
  //     // );
  //   },
  // );


}

class CattleApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>LocaleModel(),
      child: Consumer<LocaleModel>(
        builder: (context,locale,child)=>MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale:Locale(locale.get())  ,
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
              headline4: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 13),
              headline3: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),
              headline2: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: 15),
              headline1: TextStyle(color: Colors.black,fontSize: 20),//detail

              button:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20) ,

              subtitle2:TextStyle(color: Colors.black,fontSize: 13)
            )

          ),
          home: new Scaffold(body:SplashPage(),)
        ),
      )
      ,
    );
  }
}
