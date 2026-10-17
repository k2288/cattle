import 'package:cattle/components/login/login_page.dart';
import 'package:cattle/home.dart';
import 'package:cattle/models/LocaleModel.dart';
import 'package:cattle/repositories/SettingRespository.dart';
import 'package:cattle/repositories/UserRepository.dart';
import 'package:cattle/utils/SettingsProvider.dart';
import 'package:cattle/utils/api/Response.dart';
import 'package:cattle/widgets/PinSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final UserRepository _userRepository = UserRepository();
  final SettingRepository _settingRepository = SettingRepository();

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
    final Response meResponse = await _userRepository.getMe();
    final Response response = await _settingRepository.get();
    if (response.data != null) {
      SettingsProvider().setSettings(response.data);
    }
    if (!mounted) return;

    Provider.of<LocaleModel>(context,listen: false).initLocalFromStorage();

    if(meResponse.status==Status.COMPLETED){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }else{
      if ((meResponse.message ?? '').isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(PinSnackBar(meResponse.message ?? '').get());
      }
      doStuffCallback();
    }

  }

  doStuffCallback(){
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => LoginPage()), (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Image.asset("assets/images/splash.png",width: MediaQuery.of(context).size.width/3,),
      ),
    );
  }
}