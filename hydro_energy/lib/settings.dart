import 'dart:convert';
import 'package:hydro_energy/main.dart';
import 'main.dart';
import 'globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'bluetooth_devices.dart';
import 'percent_indicator.dart';



class Settings extends StatefulWidget {
  const Settings({super.key, required this.title});

  final String title;

  @override
  State<Settings> createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  HomeState homeState = HomeState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 130),
                child: Stack(
                  children: [SizedBox(
                    width: 220,
                    height:220,
                    child: DecoratedBox(
                      decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: <Color>[Color(0xFF00C9FF),
                        Color(0xFF92FE9D)])),
                      child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor:Colors.transparent,
                        shadowColor: Colors.transparent,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(110), // <-- Radius
                        ),),
                        onPressed: () async {

                          BluetoothDevice? device = await Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const BluetoothDevices()));
                          if (device == null) return;

                          print('Connecting to device...');
                          setState(() {
                            btStatus = BluetoothConnectionState.connecting;
                          });

                          BluetoothConnection.toAddress(device.address).then((_connection) {
                            print('Connected to the device');

                            setState(() {
                              connection = _connection;
                              btStatus = BluetoothConnectionState.connected;
                            });

                            connection!.input!.listen(homeState.onDataReceived).onDone(() {
                              setState(() {
                                btStatus = BluetoothConnectionState.disconnected;
                              });
                            });
                          }).catchError((error) {
                            print('Cannot connect, exception occured');
                            print(error);

                            setState(() {
                              btStatus = BluetoothConnectionState.error;
                            });
                          });
                        },
                        child: Builder(
                          builder: (context) {
                            switch (btStatus) {
                              case BluetoothConnectionState.disconnected:
                                return const PercentIndicator.disconnected();
                              case BluetoothConnectionState.connecting:
                                return PercentIndicator.connecting();
                              case BluetoothConnectionState.connected:
                                return PercentIndicator.connected(
                                  percent: percentValue ?? 0,
                                );
                              case BluetoothConnectionState.error:
                                return const PercentIndicator.error();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              const Spacer(),
              // ElevatedButton(
              //   onPressed: () async {
              //     String text = 'water';
              //
              //     setState(() => _isWatering = true);
              //
              //     if (text.isNotEmpty) {
              //       try {
              //         connection!.output
              //             .add(Uint8List.fromList(utf8.encode("$text\r\n")));
              //         await connection!.output.allSent;
              //       } finally {
              //         print(connection);
              //         print(text);
              //         Future.delayed(const Duration(seconds: 4), () {
              //           setState(() => _isWatering = false);
              //         });
              //       }
              //     }
              //   },
              //   child: const Text('Water my plant'),
              // ),
              const Spacer(),
              SizedBox(
                height: 300,
                child: Builder(
                  builder: (context) {
                    if (homeState.isWatering) {
                      return Text('');
                    }

                    if (percentValue == null) {
                      return const SizedBox.shrink();
                    }
                    if (percentValue! > 0.7) {
                      return Text('');
                    } else if (percentValue! < 0.2) {
                      return Text('');
                    } else {
                      return Text('');
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}