import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothDevices extends StatelessWidget {
  const BluetoothDevices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: const Text('Bluetooth Devices'),
      ),
      body: Container(
        child: FutureBuilder(
          future: FlutterBluetoothSerial.instance.getBondedDevices(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<BluetoothDevice> devices = snapshot.requireData;
              if (devices.isNotEmpty) {
                return ListView.builder(
                  itemCount: devices.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(devices[index].name ?? 'Unknown device'),
                      subtitle: Text(devices[index].address),
                      onTap: () {
                        Navigator.of(context).pop(devices[index]);
                      },
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text('No devices found'),
                );
              }
            } else {
              return const Center(
                child: LinearProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}