import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hydro_energy/main.dart';
import 'package:hydro_energy/notifications.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/custom_dialog.dart';
import 'globals.dart';

void initialization() {
  runApp(MaterialApp(home: Initialization()));
}

class Initialization extends StatefulWidget {
  const Initialization({Key? key}) : super(key: key);

  @override
  State<Initialization> createState() => _InitializationState();
}

class _InitializationState extends State<Initialization> {
  late SharedPreferences _prefs1;
  String decision = '';
  bool _is_on1 = false;
  String initOn = 'screenon';
  String initOff = 'screenoff';
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs1) {
      _prefs1 = prefs1;
      setState(() {
        _is_on1 = _prefs1.getBool('is_on1') ?? false;
      });
    });
    }
  Future<void> UpdateText() async {
    if (connection != null) {
      setState(() {
        _is_on1 = !_is_on1;
      });
      await _prefs1.setBool('is_on1', _is_on1);
    } else {
      return showDialog(
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
                    'Not connected',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Connect to a bluetooth device in the settings tab.',
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
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
          leading:
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.lightBlueAccent[200],
            ),
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
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: const <Color>[
                Color(0xFF2C5364),
                Color(0xFF203A43),
                Color(0xFF0f2027)
              ])),
          padding: EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     Container(
              //       margin: EdgeInsets.all(5),
              //       height: 150.0,
              //       width: 150.0,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(75),
              //         //set border radius to 50% of square height and width
              //         image: DecorationImage(
              //           image: AssetImage("assets/water.png"),
              //           fit: BoxFit.cover, //change image fill type
              //         ),
              //       ),
              //     )],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                    height: 250.0,
                    width: 250.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(75),
                      //     color: Colors.white.withOpacity(0.8)
                    ),
                    child: InkWell(
                      highlightColor: Colors.grey,
                      child: Image.asset('assets/lcd-img.png'),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 100),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          UpdateText();

                          if (_is_on1 == true) {
                            if (initOn.isNotEmpty) {
                              try {
                                if (connection != null) {
                                  connection!.output.add(Uint8List.fromList(utf8.encode("$initOn\r\n")));
                                  sysInitializedOn();
                                  await connection!.output.allSent;
                                  print(initOn);
                                  print(connection);
                                } else {
                                  print('Bluetooth connection is null');

                                }
                              } catch (e) {
                                print(e);
                              }

                            }
                          }
                          else if (_is_on1 == false) {
                            if (initOff.isNotEmpty) {
                              try {
                                if (connection != null) {
                                  connection!.output.add(Uint8List.fromList(utf8.encode("$initOff\r\n")));
                                  sysInitializedOff();
                                  await connection!.output.allSent;
                                  print(initOff);
                                } else {
                                  print('Bluetooth connection is null');
                                }
                              } catch (e) {
                                print(e);
                              }

                            }
                          }
                        },
                        // onDoubleTap: (){is_on = false; UpdateText();},
                        child: Container(
                          height: 100,
                          margin: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20.0),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(75),
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: _is_on1 ? const <Color>[
                                          Color(0xFFe53935),
                                          Color(0xFFe35d5b)
                                        ] : const <Color>[
                                          Color(0xFF00C9FF),
                                          Color(0xFF92FE9D)
                                        ])),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 40, 10, 0),
                                    height: 40.0,
                                    width: 40.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(75),
                                      //     color: Colors.white.withOpacity(0.8)
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: Icon(
                                        Icons.power_settings_new_outlined,
                                        size: 40,
                                        color: Colors.white),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 50, 0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                          _is_on1
                                              ? decision = 'Turn off'
                                              : decision = 'Turn on',
                                          style: TextStyle(
                                            fontFamily: 'RobotoSlab',
                                            fontSize: 35.0,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Colors.white.withOpacity(0.8),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> showDialog1(BuildContext context) async {
    await showDialog(
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
    );}
}
