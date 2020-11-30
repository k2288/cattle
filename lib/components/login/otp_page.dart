import 'dart:convert';

import 'package:cattle/home.dart';
import 'package:cattle/models/LocaleModel.dart';
import 'package:cattle/repositories/AuthRepository.dart';
import 'package:cattle/repositories/SettingRespository.dart';
import 'package:cattle/utils/SettingsProvider.dart';
import 'package:cattle/utils/api/ApiProvider.dart';
import 'package:cattle/utils/api/Response.dart';
import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OtpPage extends StatefulWidget {

  final String phoneNumber;

  const OtpPage(this.phoneNumber);
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {

  String text = '';
  AuthRepository _authRepository;
  SettingRepository _settingRepository;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  _OtpPageState(){
    _authRepository=new AuthRepository();
    _settingRepository=SettingRepository();
  }

  void _onKeyboardTap(String value) {
    setState(() {
      text = text + value;
    });
  }

  Widget otpNumberWidget(int position) {
    try {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
        child: Center(child: Text(text[position], style: TextStyle(color: Colors.black),)),
      );
    } catch (e) {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              // color: Theme.of(context).primaryColor,
            ),
            child: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor, size: 20,),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(AppLocalizations.of(context).otp_title, style: TextStyle(color: Colors.black, fontSize: 26, fontWeight: FontWeight.w500))
                        ),
                        Container(
                          constraints: const BoxConstraints(
                              maxWidth: 500
                          ),
                          child: Row(
                            textDirection: Language.isRtl(context) ? TextDirection.ltr:TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              otpNumberWidget(5),
                              otpNumberWidget(4),
                              otpNumberWidget(3),
                              otpNumberWidget(2),
                              otpNumberWidget(1),
                              otpNumberWidget(0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    constraints: const BoxConstraints(
                        maxWidth: 500
                    ),
                    child: RaisedButton(
                      onPressed: () async{

                        var response = await _authRepository.postCode(jsonEncode(<String, dynamic>{"code":text,"phone":widget.phoneNumber.toString()}));
                        if(Status.COMPLETED==response.status){
                          
                          await ApiProvider().setToken(response.data.token.toString());

                          Response settingsResponse=await _settingRepository.get();

                          SettingsProvider().setSettings(settingsResponse.data);
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        }else{
                          _scaffoldKey.currentState
                          .showSnackBar(SnackBar(
                              content: Text(response.message,style: TextStyle(color: Colors.white,fontFamily: "Iran_Sans"),),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.red,
                            )
                          );
                        }

                        // loginStore.validateOtpAndLogin(context, text);
                      },
                      color: Theme.of(context).primaryColor,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14))
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(AppLocalizations.of(context).otp_confirm, style: TextStyle(color: Colors.white),),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                color: Theme.of(context).primaryColor,
                              ),
                              child: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16,),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: NumericKeyboard(
                      onKeyboardTap: _onKeyboardTap,
                      textColor: Theme.of(context).primaryColor,
                      rightIcon: Icon(
                        Icons.backspace,
                        color: Theme.of(context).primaryColor,
                      ),
                      rightButtonFn: () {
                        setState(() {
                          text = text.substring(0, text.length - 1);
                        });
                      },
                    ),
                  ),
                  
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
