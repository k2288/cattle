import 'dart:convert';
import 'package:cattle/components/login/otp_page.dart';
import 'package:cattle/repositories/AuthRepository.dart';
import 'package:cattle/utils/api/Response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();
  AuthRepository _authRepository;

  _LoginPageState(){
    _authRepository=new AuthRepository();
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
                          child: Text('ThePinHerd',
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
                              TextSpan(text: 'ما', style: TextStyle(color: Theme.of(context).primaryColor,fontFamily: "Iran_Sans")),
                              TextSpan(
                                  text: ' رمز یکبار مصرف ', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold,fontFamily: "Iran_Sans")),
                              TextSpan(text: 'را برای همین تلفن ارسال می کنیم', style: TextStyle(color: Theme.of(context).primaryColor,fontFamily: "Iran_Sans")),
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
                                  var response=await _authRepository.postUser(jsonEncode(<String, String>{"phone":phoneController.text}));
                                  if(Status.COMPLETED==response.status){
                                    
                                    // ApiProvider().setToken(response.data.token.toString());

                                    // Response settingsResponse=await _settingRepository.get();

                                    // SettingsProvider().setSettings(settingsResponse.data);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => OtpPage(phoneController.text,)),
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
