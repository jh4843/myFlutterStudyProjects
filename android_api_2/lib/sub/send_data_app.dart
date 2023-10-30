import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SendDataApp extends StatefulWidget {
  const SendDataApp({super.key});

  @override
  State<StatefulWidget> createState() => _SendDataApp();
}

class _SendDataApp extends State<SendDataApp> {
  static const platform = MethodChannel('com.flutter.dev/encryto');
  static const platform2 = MethodChannel('com.flutter.dev/dialog');

  TextEditingController controller = TextEditingController(text: 'Hi flutter');
  String _encodedText = 'Nothing';
  String _decodedText = 'Nothing';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Data Example'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: controller,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                _encodedText,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  _decodeText(_encodedText);
                },
                child: const Text('Decode'),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                _decodedText,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  _popupDialog();
                },
                child: const Text('Show Dialog'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _sendData(controller.value.text);
        },
        child: const Text('Encode'),
      ),
    );
  }

  Future<void> _sendData(String text) async {
    final String result = await platform.invokeMethod('getEncryto', text);
    print(result);
    setState(() {
      _encodedText = result;
    });
  }

  void _decodeText(String changeText) async {
    final String result = await platform.invokeMethod('getDecode', changeText);
    setState(() {
      _decodedText = result;
    });
  }

  void _popupDialog() async {
    final String result = await platform2.invokeMethod('showDialog');
    setState(() {
      _decodedText = result;
    });
  }
}
