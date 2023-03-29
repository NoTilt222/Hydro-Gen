import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hydro_energy/notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'globals.dart';
import 'main.dart';

void main() {
  runApp(MaterialApp(
    home: LoginPage(),
  ));
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool showProgressIndicator= false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: const <Color>[
                    Color(0xFF2C5364),
                    Color(0xFF203A43),
                    Color(0xFF0f2027)
                  ])),
        ),
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: "Hydro",
                  style: TextStyle(
                      fontFamily: 'RobotoSlab',
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..shader = LinearGradient(
                          colors: const <Color>[
                            Colors.lightBlueAccent,
                            Colors.blue,
                            Colors.green,
                            Colors.lightGreenAccent
                            //add more color here.
                          ],
                        ).createShader(
                            Rect.fromLTWH(100.0, 0.0, 200.0, 200.0)))),
              TextSpan(
                  text: " Gen",
                  style: TextStyle(
                      fontFamily: 'RobotoSlab',
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..shader = LinearGradient(
                          colors: const <Color>[
                            Colors.lightGreenAccent,
                            Colors.blue,
                            Colors.green,
                            Colors.lightBlueAccent
                            //add more color here.
                          ],
                        ).createShader(
                            Rect.fromLTWH(100.0, 0.0, 200.0, 200.0)))),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: StatefulBuilder(
            builder:(context, setState) {
              bool isHidden = false;
              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 60.0),
                        child: Center(
                          child: Container(
                              width: 200,
                              height: 150,
                              /*decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(50.0)),*/
                              child: Image.asset('assets/app_logo.png')),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email address';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                        ),
                      ),
                      Center(
                        child: TextButton(
                          onPressed: (){
                            //TODO FORGOT PASSWORD SCREEN GOES HERE

                          },
                          child: Text(
                            'Forgot Password',
                            style: TextStyle(color: Colors.blue, fontSize: 15),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: 50,
                          width: 250,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: const <Color>[
                                    Color(0xFF00C9FF),
                                    Color(0xFF92FE9D)
                                  ]
                              )
                          ),
                          child: TextButton(
                              child: Text(
                                'Login',
                                style: TextStyle(color: Colors.white, fontSize: 25),
                              ),
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      backgroundColor: Colors.transparent,
                                      elevation: 0.0,
                                      child: Container(
                                        padding: EdgeInsets.all(20.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Loading...",
                                              style: TextStyle(
                                                color: Colors.grey[800],
                                                fontSize: 16.0,
                                              ),
                                            ),
                                            SizedBox(height: 20.0),
                                            SizedBox(
                                              height: 10.0,
                                              child: LinearProgressIndicator(
                                                valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
                                                backgroundColor: Colors.grey[300],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                                Future.delayed(Duration(milliseconds: 500), () {
                                  Navigator.pop(context);
                                    if (_formKey.currentState != null &&
                                        _formKey.currentState!.validate()) {
                                      _saveCredentials();
                                      _login();
                                    }
                                }
                                );
                                }
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Future<void> _saveCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', 'timmento7@gmail.com');
    await prefs.setString('password', 'test123');
  }

  Future<void> _login() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final password = prefs.getString('password');
    if (_emailController.text == email &&
        _passwordController.text == password) {
      // Navigate to the home page or do something else
      triggerWelcomeNotification();
      print(notificationMap);
      Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Login Failed',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Incorrect email or password.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Please try again.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 20.0),
                  DecoratedBox(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color(0xFF00C9FF),
                                Color(0xFF92FE9D)
                                //add more colors
                              ]),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                                blurRadius: 5) //blur radius of shadow
                          ]
                      ),
                      child:ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
                            shadowColor: Colors.transparent,
                            //make color or elevated button transparent
                          ),

                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding:EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                            ),
                            child:Text("OK",
                            style: TextStyle(fontFamily: 'RobotoSlab',
                                fontSize: 14.0,
                                fontWeight: FontWeight.normal,)
                            ),
                          )
                      )
                  )
                ],
              ),
            ),
          );
        },
      );
    }
  }}
