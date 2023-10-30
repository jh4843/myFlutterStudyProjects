import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class LargeFileMain extends StatefulWidget {
  const LargeFileMain({super.key});

  @override
  State<StatefulWidget> createState() => _LargeFileMain();
}

class _LargeFileMain extends State<LargeFileMain> {
  final imgUrl =
      'https://images.pexels.com/photos/240040/pexels-photo-240040.jpeg';

  bool downloading = false; // check whether download is in progress or not
  var progressString = ""; // to display how much download is completed
  String? file = ""; // the downloaded file

  @override
  void initState() {
    super.initState();
  }

  Future<void> downloadFile() async {
    Dio dio = Dio();
    try {
      var dir = await getApplicationDocumentsDirectory();
      await dio.download(imgUrl, '${dir.path}/myimage.jpg',
          onReceiveProgress: (rec, total) {
        print('Rec: $rec , Total: $total');
        file = '${dir.path}/myimage.jpg';
        setState(() {
          downloading = true;
          progressString = '${((rec / total) * 100).toStringAsFixed(0)}%';
        });
      });
    } catch (e) {
      print(e);
    }
    setState(() {
      downloading = false;
      progressString = 'Completed';
    });
    print('Download completed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Large File Download'),
      ),
      body: Center(
          child: downloading
              ? SizedBox(
                  height: 120.0,
                  width: 200.0,
                  child: Card(
                    color: Colors.black,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const CircularProgressIndicator(),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Downloading File: $progressString',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : FutureBuilder(
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        print('none');
                        return const Text('데이터 없음');
                      case ConnectionState.waiting:
                        print('waiting');
                        return const CircularProgressIndicator();
                      case ConnectionState.active:
                        print('active');
                        return const CircularProgressIndicator();
                      case ConnectionState.done:
                        print('done $file');
                        if (snapshot.hasData) {
                          return snapshot.data as Widget;
                        }
                    }
                    return const Text('데이터 없음');
                  },
                  future: downloadWidget(file!),
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          downloadFile();
        },
        child: const Icon(Icons.file_download),
      ),
    );
  }

  Future<Widget> downloadWidget(String filePath) async {
    File file = File(filePath);
    bool exist = await file.exists();
    FileImage(file).evict();
    if (exist) {
      return Center(
        child: Column(
          children: <Widget>[Image.file(file)],
        ),
      );
    } else {
      return const Text('No Data');
    }
  }
}
