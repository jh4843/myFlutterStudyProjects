import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/memo.dart';

class MemoAddPage extends StatefulWidget {
  final DatabaseReference reference;

  const MemoAddPage(this.reference, {super.key});

  @override
  State<StatefulWidget> createState() => _MemoAddPage();
}

class _MemoAddPage extends State<MemoAddPage> {
  TextEditingController? titleController;
  TextEditingController? contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Memo'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                    labelText: 'Title', fillColor: Colors.blueAccent),
              ),
              Expanded(
                  child: TextField(
                controller: contentController,
                keyboardType: TextInputType.multiline,
                maxLines: 100,
                decoration: const InputDecoration(labelText: 'Contents'),
              )),
              MaterialButton(
                onPressed: () {
                  widget.reference
                      .push()
                      .set(Memo(
                              titleController!.value.text,
                              contentController!.value.text,
                              DateTime.now().toIso8601String())
                          .toJson())
                      .then((_) {
                    Navigator.of(context).pop();
                  });
                },
                shape:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
                child: const Text('Store'),
              )
            ],
          ),
        ),
      ),
    );
  }

  // InterstitialAd? _interstitialAd;
  // int _numInterstitialLoadAttempts = 0;
  // int maxFailedLoadAttempts = 3;

  // void _createInterstitialAd() {
  //   InterstitialAd.load(
  //       adUnitId: InterstitialAd.testAdUnitId,
  //       request: request,
  //       adLoadCallback: InterstitialAdLoadCallback(
  //         onAdLoaded: (InterstitialAd ad) {
  //           print('$ad loaded');
  //           _interstitialAd = ad;
  //           _numInterstitialLoadAttempts = 0;
  //         },
  //         onAdFailedToLoad: (LoadAdError error) {
  //           print('InterstitialAd failed to load: $error.');
  //           _numInterstitialLoadAttempts += 1;
  //           _interstitialAd = null;
  //           if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
  //             _createInterstitialAd();
  //           }
  //         },
  //       ));

  // }

  // void _showInterstitialAd() {
  //   if (_interstitialAd == null) {
  //     print('Warning: attempt to show interstitial before loaded.');
  //     return;
  //   }
  //   _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
  //     onAdShowedFullScreenContent: (InterstitialAd ad) =>
  //         print('ad onAdShowedFullScreenContent.'),
  //     onAdDismissedFullScreenContent: (InterstitialAd ad) {
  //       print('$ad onAdDismissedFullScreenContent.');
  //       ad.dispose();
  //       _createInterstitialAd();
  //     },
  //     onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
  //       print('$ad onAdFailedToShowFullScreenContent: $error');
  //       ad.dispose();
  //       _createInterstitialAd();
  //     },
  //   );
  //   _interstitialAd!.show();
  //   _interstitialAd = null;
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('메모 추가'),
  //     ),
  //     body: Container(
  //       padding: EdgeInsets.all(20),
  //       child: Center(
  //         child: Column(
  //           children: <Widget>[
  //             TextField(
  //               controller: titleController,
  //               decoration: InputDecoration(
  //                   labelText: '제목', fillColor: Colors.blueAccent),
  //             ),
  //             Expanded(
  //                 child: TextField(
  //                   controller: contentController,
  //                   keyboardType: TextInputType.multiline,
  //                   maxLines: 100,
  //                   decoration: InputDecoration(labelText: '내용'),
  //                 )),
  //             MaterialButton(
  //               onPressed: () {
  //                 widget.reference
  //                     .push()
  //                     .set(Memo(
  //                     titleController!.value.text,
  //                     contentController!.value.text,
  //                     DateTime.now().toIso8601String())
  //                     .toJson())
  //                     .then((_) {
  //                   Navigator.of(context).pop();
  //                 });
  //                 _showInterstitialAd();
  //               },
  //               child: Text('저장하기'),
  //               shape:
  //               OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
