import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hydro_energy/settings.dart';
import 'package:hydro_energy/waterpump.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:avatar_glow/avatar_glow.dart';

import 'globals.dart';
import 'initialization.dart';
import 'main.dart';

void mainPage(){
  runApp(
      MaterialApp(
          home: MainPage()
      )
  );
}
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {

  LinearGradient getBatteryGradient(double? percentValue) {
    if (percentValue == null) {
      // default gradient if percentValue is null
      return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: const <Color>[Colors.redAccent, Colors.red]);
    } else if (percentValue <= 0.3) {
      return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: const <Color>[Colors.redAccent, Colors.red]);
    } else if (percentValue <= 0.6) {
      return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: const <Color>[Colors.orangeAccent, Colors.orange]);
    } else {
      return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: const <Color>[
            Color(0xFF00C9FF),
            Color(0xFF92FE9D)
          ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
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
              Expanded(
                flex: 0,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 150,
                        margin:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 20.0),
                        padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: getBatteryGradient(percentValue)
                                ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Battery Level",
                                    style: TextStyle(
                                      fontFamily: 'RobotoSlab',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white.withOpacity(0.6),
                                    )),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('${((percentValue ?? 0) * 100).toStringAsFixed(0)}%',
                                        style: TextStyle(
                                          fontFamily: 'RobotoSlab',
                                          fontSize: 35.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white.withOpacity(0.8),
                                        )),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 20),
                                  height: 50.0,
                                  width: 50.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(75),
                                      color: Colors.white.withOpacity(0.8)),
                                  child: Icon(
                                    Icons.electric_bolt_sharp,
                                    size: 35,
                                    color: Colors.yellow[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 0,
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Container(
                    margin: EdgeInsets.only(left: 22),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Activities",
                          style: TextStyle(
                            fontFamily: 'RobotoSlab',
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(1),
                          )),
                    ),
                  ),
                ]),
              ),
              Expanded(
                flex: 0,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 182,
                        margin:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 15.0),
                        padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: const <Color>[
                                  Color(0xFF16222a),
                                  Color(0xFF3a6073),
                                  // Color(0xFF0f2027),
                                  // Color(0xFF203A43),
                                  // Color(0xFF0f2027)
                                ])),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  height: 120.0,
                                  width: 120.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(75),
                                    //     color: Colors.white.withOpacity(0.8)
                                  ),
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => Initialization()));
                                      },
                                    highlightColor: Colors.grey,
                                    child:Image.asset('assets/lcd-img.png'),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Initialization',
                                    style: TextStyle(
                                      fontFamily: 'RobotoSlab',
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white.withOpacity(0.8),
                                    )
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 182,
                        margin:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 15.0),
                        padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: const <Color>[
                                  Color(0xFF16222a),
                                  Color(0xFF3a6073),
                                  // Color(0xFF2C5364)
                                ])),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  height: 120.0,
                                  width: 120.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(75),
                                    //     color: Colors.white.withOpacity(0.8)
                                  ),
                                  child: InkWell(
                                    onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => WaterPump()));},
                                    highlightColor: Colors.grey,
                                    child:Image.asset('assets/hydro_pump.png'),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Water Pump',
                                    style: TextStyle(
                                      fontFamily: 'RobotoSlab',
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white.withOpacity(0.8),
                                    )
                                ),
                              ],
                            )
                          ],
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
}

