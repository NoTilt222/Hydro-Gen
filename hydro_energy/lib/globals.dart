library globals;

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:hydro_energy/settings.dart';

enum BluetoothConnectionState {
  disconnected,
  connecting,
  connected,
  error,
}
BluetoothConnectionState btStatus = BluetoothConnectionState.disconnected;
BluetoothConnection? connection;
Map<String, Map<String, dynamic>> notificationMap = {};

bool notificationYes = false;

double? percentValue;