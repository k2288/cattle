import 'package:cattle/components/login/login_page.dart';
import 'package:cattle/home.dart';
import 'package:cattle/repositories/SettingRespository.dart';
import 'package:cattle/repositories/UserRepository.dart';
import 'package:cattle/utils/SettingsProvider.dart';
import 'package:cattle/utils/api/Response.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  UserRepository _userRepository;
  SettingRepository _settingRepository;

  _SplashPageState(){
    _userRepository=new UserRepository();
    _settingRepository=new SettingRepository();
  }

  @override
  void initState() {
    
    super.initState();
    checkToken();
    // new Future.delayed(const Duration(milliseconds: 500), checkToken);

    // var response= Http().get("/v1/users/me");
    // if (response.statusCode)


    // Provider.of<LoginStore>(context, listen: false).isAlreadyAuthenticated().then((result) {
    //   if (result) {
    //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const HomePage()), (Route<dynamic> route) => false);
    //   } else {
      // }
    // });
  }
  checkToken()async{
    var response=await _userRepository.getMe();
    if(response!=null){
      
      Response response=await _settingRepository.get();
      SettingsProvider().setSettings(response.data);

      if(response.status==Status.COMPLETED){

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }else{
        Scaffold
          .of(context)
          .showSnackBar(SnackBar(
              content: Text(response.message,style: TextStyle(color: Colors.white,fontFamily: "Iran_Sans"),),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
            )
          );
      }

    }else{
      doStuffCallback();
    }
  }

  doStuffCallback(){
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const LoginPage()), (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}