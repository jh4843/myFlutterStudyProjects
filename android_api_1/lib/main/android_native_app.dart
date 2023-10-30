import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AndroidNativeApp extends StatefulWidget {
  const AndroidNativeApp({super.key});

  @override
  State<StatefulWidget> createState() => _AndroidNativeApp();
}

class _AndroidNativeApp extends State<AndroidNativeApp> {
  String _deviceInfo = 'Unknown Info';
  static const platformMsg = MethodChannel('com.flutter.dev/info');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Natvie API Example'),
      ),
      body: Container(
        child: Center(
          child: Text(
            _deviceInfo,
            style: const TextStyle(fontSize: 30),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _getDeviceInfo();
        },
        child: const Icon(Icons.get_app),
      ),
    );
  }

  Future<void> _getDeviceInfo() async {
    String batteryLevel;
    try {
      final String result = await platformMsg.invokeMethod('getDeviceInfo');
      batteryLevel = 'Device info : $result';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get Device info: '${e.message}'.";
    }
    setState(() {
      _deviceInfo = batteryLevel;
    });
  }
}
