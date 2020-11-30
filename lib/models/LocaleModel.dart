import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocaleModel extends ChangeNotifier{
  String _locale="en";

  void set(String l){
    _locale=l;

    FlutterSecureStorage storage = FlutterSecureStorage();
    storage.write(key: "locale",value: l);

    notifyListeners();
  }

  String get(){
    return _locale;
  }

  initLocalFromStorage()async{
    FlutterSecureStorage storage = FlutterSecureStorage();
    String locale=await storage.read(key: "locale");
    if(locale==null){
      set("en");
    }else{
      set(locale);
    }
  }
}

class Language{
  String code;
  String name;

  Language(this.code,this.name);

  static isRtl(context){
    return Localizations.localeOf(context).languageCode=="fa";
  }
}

List<Language> languageList=<Language> [Language("en","English"),Language("fa","فارسی")];