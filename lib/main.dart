import 'dart:async';

import 'package:cattle/components/splash/splash_page.dart';
import 'package:cattle/models/LocaleModel.dart';
import 'package:cattle/utils/api/ApiProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cattle/l10n/app_localizations.dart';

// final sentry = SentryClient(dsn: "https://bd54fe34ae6842839c652a7ab201b220@o459244.ingest.sentry.io/5458076");

Future main() async{

    WidgetsFlutterBinding.ensureInitialized();

    ApiProvider apiProvider=ApiProvider();
    await apiProvider.init();
    runApp(const CattleApp());
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
  const CattleApp({super.key});


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
            scaffoldBackgroundColor: Color(0xFFf8f9fe),
            textTheme: TextTheme(
              headlineMedium: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 13),
              displaySmall: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),
              displayMedium: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: 15),
              displayLarge: TextStyle(color: Colors.black,fontSize: 20),//detail

              labelLarge:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20) ,

              titleSmall:TextStyle(color: Colors.black,fontSize: 13)
            ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(secondary: Color(0xFF369ee5))

          ),
          home: Scaffold(body:SplashPage(),)
        ),
      )
      ,
    );
  }
}
