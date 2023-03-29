import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
import 'globals.dart';
import 'models/location.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:hydro_energy/settings.dart';
import 'package:hydro_energy/currentWeather.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'login.dart';
import 'main_page.dart';

import 'package:localstorage/localstorage.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'notification_service.dart';
import 'notifications.dart';


Future<void> GetPermission() async {
  var status = await Permission.bluetooth.request();

  if (status == PermissionStatus.granted) {
    // Permission granted
  } else {
    // Permission denied
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // NotificationService().initNotification();
  AwesomeNotifications().initialize(
      'resource://drawable/rsz_app_logo',
      [NotificationChannel(channelKey: 'basic_channel', channelName: 'notif', channelDescription: 'lol', defaultColor: Colors.lightBlueAccent,
        ledColor: Colors.white,
      importance: NotificationImportance.Max, channelShowBadge: true,)],debug: true);
  runApp(MaterialApp(
    home: LoginPage(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();

}

class HomeState extends State<Home> {

  String messageBuffer = '';
  bool isWatering = false;


  void onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    var message = '';
    if (~index != 0) {
      message = backspacesCounter > 0
          ? messageBuffer.substring(
          0, messageBuffer.length - backspacesCounter)
          : messageBuffer + dataString.substring(0, index);
      messageBuffer = dataString.substring(index);
    } else {
      messageBuffer = (backspacesCounter > 0
          ? messageBuffer.substring(
          0, messageBuffer.length - backspacesCounter)
          : messageBuffer + dataString);
    }

    // calculate percentage from message
    // analog 10 bit

      if (message.isEmpty) return; // to avoid fomrmat exception
      double? analogMessage = double.tryParse(message.trim());

        var percent = (analogMessage ?? 0) / 1023;

        percentValue = 0 + percent; // inverse percent
  }
  int getNotificationLength() {
    return notificationMap.length;
  }
  List<Location> locations = [
    Location(
        city: "Paramaribo",
        country: "Suriname",
        lat: "5.8520",
        lon: "55.2038"),
    Location(
        city: "edmonton",
        country: "canada",
        lat: "53.5365386",
        lon: "-114.1513999"),
    Location(city: "Amsterdam", country: "Netherlands", lon: "4.9041", lat: "52.3676"),
    Location(city: "Rotterdam", country: "Netherlands", lon: "4.4792", lat: "51.9244"),
    Location(city: "Utrecht", country: "Netherlands", lon: "5.1214", lat: "52.0907"),
    Location(city: "Paris", country: "France", lon: "2.3522", lat: "48.8566"),
    Location(city: "Marseille", country: "France", lon: "5.3698", lat: "43.2965"),
    Location(city: "Lyon", country: "France", lon: "4.8357", lat: "45.7640"),
    Location(city: "Berlin", country: "Germany", lon: "13.4049", lat: "52.5200"),
    Location(city: "Munich", country: "Germany", lon: "11.5819", lat: "48.1351"),
    Location(city: "Frankfurt", country: "Germany", lon: "8.6821", lat: "50.1109"),
    Location(city: "Athens", country: "Greece", lon: "23.7275", lat: "37.9838"),
    Location(city: "Budapest", country: "Hungary", lon: "19.0402", lat: "47.4979"),
    Location(city: "Copenhagen", country: "Denmark", lon: "12.5683", lat: "55.6761"),
    Location(city: "Dublin", country: "Ireland", lon: "-6.2603", lat: "53.3498"),
    Location(city: "Lisbon", country: "Portugal", lon: "-9.1393", lat: "38.7223"),
    Location(city: "Prague", country: "Czech Republic", lon: "14.4378", lat: "50.0755"),
    Location(city: "Stockholm", country: "Sweden", lon: "18.0686", lat: "59.3293"),
    Location(city: "Zurich", country: "Switzerland", lon: "8.5417", lat: "47.3769"),
    Location(city: "Vienna", country: "Austria", lon: "16.3738", lat: "48.2082"),
    Location(city: "Oslo", country: "Norway", lon: "10.7522", lat: "59.9139"),
    Location(city: "Kabul", country: "Afghanistan", lon: "69.2075", lat: "34.5553"),
    Location(city: "Tirana", country: "Albania", lon: "19.8189", lat: "41.3275"),
    Location(city: "Algiers", country: "Algeria", lon: "3.0420", lat: "36.7525"),
    Location(city: "Andorra la Vella", country: "Andorra", lon: "1.5218", lat: "42.5063"),
    Location(city: "Luanda", country: "Angola", lon: "13.2453", lat: "-8.8304"),
    Location(city: "St. John's", country: "Antigua and Barbuda", lon: "-61.8456", lat: "17.1177"),
    Location(city: "Buenos Aires", country: "Argentina", lon: "-58.3816", lat: "-34.6037"),
    Location(city: "Yerevan", country: "Armenia", lon: "44.5126", lat: "40.1776"),
    Location(city: "Canberra", country: "Australia", lon: "149.1300", lat: "-35.2809"),
    Location(city: "Vienna", country: "Austria", lon: "16.3738", lat: "48.2082"),
    Location(city: "Baku", country: "Azerbaijan", lon: "49.8920", lat: "40.4093"),
    Location(city: "Nassau", country: "Bahamas", lon: "-77.3505", lat: "25.0478"),
    Location(city: "Manama", country: "Bahrain", lon: "50.5856", lat: "26.2285"),
    Location(city: "Dhaka", country: "Bangladesh", lon: "90.4125", lat: "23.8103"),
    Location(city: "Bridgetown", country: "Barbados", lon: "-59.6167", lat: "13.0969"),
    Location(city: "Minsk", country: "Belarus", lon: "27.5615", lat: "53.9045"),
    Location(city: "Brussels", country: "Belgium", lon: "4.3517", lat: "50.8503"),
    Location(city: "Belmopan", country: "Belize", lon: "-88.7729", lat: "17.2510"),
    Location(city: "Porto-Novo", country: "Benin", lon: "2.6162", lat: "6.4779"),
    Location(city: "Thimphu", country: "Bhutan", lon: "89.6390", lat: "27.4712"),
    Location(city: "Sucre", country: "Bolivia", lon: "-65.2610", lat: "-19.0421"),
    Location(city: "Sarajevo", country: "Bosnia and Herzegovina", lon: "18.4131", lat: "43.8564"),
  Location(city: "Doha", country: "Qatar", lon: "51.5310", lat: "25.2854"),
  Location(city: "Kathmandu", country: "Nepal", lon: "85.3239", lat: "27.7172"),
  Location(city: "Naypyidaw", country: "Myanmar", lon: "96.1561", lat: "19.7633"),
  Location(city: "Sana'a", country: "Yemen", lon: "44.2066", lat: "15.3694"),
  Location(city: "Maseru", country: "Lesotho", lon: "27.4667", lat: "-29.3167"),
  Location(city: "Nuku'alofa", country: "Tonga", lon: "-175.2167", lat: "-21.1333"),
  Location(city: "Funafuti", country: "Tuvalu", lon: "179.2167", lat: "-8.5167"),
  Location(city: "Male", country: "Maldives", lon: "73.5099", lat: "4.1755"),
  Location(city: "Moroni", country: "Comoros", lon: "43.2402", lat: "-11.7022"),
  Location(city: "Port Louis", country: "Mauritius", lon: "57.4984", lat: "-20.1604")
  ];

  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed){
      if(!isAllowed){
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    super.initState();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static int _selectedIndex = 0;
  List<Widget> _pages = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> notifications = [];

    if (notificationMap.containsKey("welcome_1")) {
      notifications.add(notificationMap["welcome_1"]!);
    }
    if (notificationMap.containsKey("welcome_2")) {
      notifications.add(notificationMap["welcome_2"]!);
    }
    if (notificationMap.containsKey("welcome_3")) {
      notifications.add(notificationMap["welcome_3"]!);
    }
    if (notificationMap.containsKey("welcome_4")) {
      notifications.add(notificationMap["welcome_4"]!);
    }
    if (notificationMap.containsKey("welcome_5")) {
      notifications.add(notificationMap["welcome_5"]!);
    }
    if (notifications.isEmpty) {
      // Handle the case where neither "welcome_1" nor "welcome_2" exist in the map
    }
    if(locations.isEmpty){
      return Text("loading");
    }
    else {
      _pages = [MainPage(), CurrentWeatherPage(locations, context), Settings(title:'hydro gen')];
      //...
      final Uri phoneNumber = Uri.parse('tel:878-8963');
      final Uri
      whatsApp = Uri.parse('https://wa.me/5978788963');
      String timestamp = DateTime.now().toString().substring(0, 19);

      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white12,
        drawerEnableOpenDragGesture: true,
        drawer: Drawer(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: const <Color>[
                      Color(0xFF2C5364),
                      Color(0xFF203A43),
                    ])),
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text(''),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(''),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
        endDrawer: Drawer(
          child: Container(
              height: 500.0,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: const <Color>[
                        Color(0xFF2C5364),
                        Color(0xFF203A43),
                      ])),
              child: Column(
                children: [
                  Container(
                    height: 30,
                    margin: EdgeInsets.only(top: 50, bottom: 0),
                    child: Text(
                      "Notification History",
                      style: TextStyle(
                        fontFamily: 'RobotoSlab',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> notification = notifications[index];
                        return Container(
                          margin: EdgeInsets.only(
                              top: 8, bottom: 8, left: 16, right: 16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: const <Color>[
                                  Color(0xFF0ED2F7),
                                  Color(0xFFB2FEFA)
                                  // Color(0xFF00C9FF),
                                  // Color(0xFF92FE9D)
                                ]),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notification["title"]!,
                                  style: TextStyle(
                                      fontFamily: 'RobotoSlab',
                                      fontSize: 15,
                                      color: Colors.white),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  notification["body"]!,
                                  style: TextStyle(
                                    fontFamily: 'RobotoSlab',
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  style: TextStyle(
                                    fontFamily: 'RobotoSlab',
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                  "Timestamp: ${notification["timestamp"]}",
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )),
        ),
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
          leading: null,
          // IconButton(
          //   onPressed: () {
          //     onDataReceived;
          //   },
          //   icon: Icon(
          //     Icons.menu,
          //     color: Colors.lightBlueAccent[200],
          //   ),
          // ),
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
                    text: "-Gen",
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
          actions: <Widget>[
            AvatarGlow(
              endRadius: 25.0,
              child: IconButton(
                onPressed: () {
                  _scaffoldKey.currentState?.openEndDrawer();
                  // NotificationService().showNotification(1, "title", "body", 10);
                },
                icon: Icon(
                  Icons.notifications_active_outlined,
                  color: Colors.lightBlueAccent[200],
                ),
              ),
            ),
          ],
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: Future.delayed(const Duration(milliseconds: 500), () {}),
          builder: (context, snapshot) {
            return _pages[_selectedIndex];
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.lightBlueAccent[200],
          child: IconButton(
              onPressed: () async {
                await launchUrl(phoneNumber);
              },
              icon: Icon(Icons.call)),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [Color(0xFF2C5364), Color(0xFF0f2027)],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              stops: const [0.0, 0.8],
              tileMode: TileMode.clamp,
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            showUnselectedLabels: true,
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            unselectedItemColor: Colors.white,
            selectedIconTheme: IconThemeData(
                color: Colors.lightBlueAccent[200]),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.cloudy_snowing), label: 'Weather'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings')
            ],
          ),
        ),
      );
    }
  }
}

