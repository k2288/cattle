import 'dart:convert';

import 'package:cattle/home.dart';
import 'package:cattle/repositories/AuthRepository.dart';
import 'package:cattle/repositories/SettingRespository.dart';
import 'package:cattle/utils/SettingsProvider.dart';
import 'package:cattle/utils/api/ApiProvider.dart';
import 'package:cattle/utils/api/Response.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();
  var storage;
  AuthRepository _authRepository;
  SettingRepository _settingRepository;

  _LoginPageState(){
    _authRepository=new AuthRepository();
  }

  @override
  void initState() {
    storage = FlutterSecureStorage();
    _settingRepository=SettingRepository();
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height-30,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                child: Stack(
                                  children: <Widget>[
                                    Center(
                                      child: Container(
                                        height: 240,
                                        constraints: const BoxConstraints(
                                          maxWidth: 500
                                        ),
                                        margin: const EdgeInsets.only(top: 20),
                                        decoration: const BoxDecoration(color: Color(0xFFE1E0F5), borderRadius: BorderRadius.all(Radius.circular(30))),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                          constraints: const BoxConstraints(maxHeight: 320),
                                          margin: const EdgeInsets.symmetric(horizontal: 8),
                                          child: Image.asset('assets/images/login.png')),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text('ThePinPet',
                                      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 30, fontWeight: FontWeight.w800)))
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              Container(
                                  constraints: const BoxConstraints(
                                      maxWidth: 500
                                  ),
                                  margin: const EdgeInsets.symmetric(horizontal: 10),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(children: <TextSpan>[
                                      TextSpan(text: 'We will send you an ', style: TextStyle(color: Theme.of(context).primaryColor)),
                                      TextSpan(
                                          text: 'One Time Password ', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                                      TextSpan(text: 'on this mobile number', style: TextStyle(color: Theme.of(context).primaryColor)),
                                    ]),
                                  )),
                              Container(
                                height: 40,
                                constraints: const BoxConstraints(
                                  maxWidth: 500
                                ),
                                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                child: CupertinoTextField(
                                  textAlign: TextAlign.left,
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(Radius.circular(4))
                                  ),
                                  controller: phoneController,
                                  clearButtonMode: OverlayVisibilityMode.editing,
                                  keyboardType: TextInputType.phone,
                                  maxLines: 1,
                                  placeholder: '...09',
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                constraints: const BoxConstraints(
                                    maxWidth: 500
                                ),
                                child: Builder(
                                  builder: (context){
                                     return RaisedButton(
                                      onPressed: () async {
                                        if (phoneController.text.isNotEmpty) {
                                          var response=await _authRepository.login(jsonEncode(<String, String>{"phone":phoneController.text}));
                                          if(Status.COMPLETED==response.status){
                                            
                                            ApiProvider().setToken(response.data.token.toString());

                                            Response settingsResponse=await _settingRepository.get();

                                            SettingsProvider().setSettings(settingsResponse.data);

                                            Navigator.push(
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
                                          

                                          // loginStore.getCodeWithPhoneNumber(context, phoneController.text.toString());
                                        } else {
                                          Scaffold
                                            .of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text('تلفن را درست وارد کنید',style: TextStyle(color: Colors.white,fontFamily: "Iran_Sans"),),
                                                behavior: SnackBarBehavior.floating,
                                                backgroundColor: Colors.red,
                                              )
                                            );
                                        }
                                      },
                                      color: Theme.of(context).primaryColor,
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'بعدی',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                color: Theme.of(context).primaryColor,
                                              ),
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ) 
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
  } 
}
