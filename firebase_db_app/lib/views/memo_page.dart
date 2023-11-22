// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

//import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import 'memoAdd.dart';
// import 'memoDetail.dart';
import 'package:flutter/material.dart';
import 'memo_add_page.dart';

import '../models/memo.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class MemoPage extends StatefulWidget {
  const MemoPage({super.key});

  @override
  State<StatefulWidget> createState() => _MemoPage();
}

class _MemoPage extends State<MemoPage> {
  // static final AdRequest request = AdRequest(
  //   keywords: <String>['foo', 'bar'],
  //   contentUrl: 'http://foo.com/bar.html',
  //   nonPersonalizedAds: true,
  // );

  // AndroidNotificationChannel? channel;
  // FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  FirebaseDatabase? _database;
  DatabaseReference? reference;
  final String _databaseURL =
      'https://flutter-tranning-default-rtdb.firebaseio.com/';
  //'https://flutter-tranning-default-rtdb.firebaseio.com/';
  List<Memo> memos = List.empty(growable: true);
  // final FirebaseMessaging _firebaseMessaging = FirebaseMexssaging();

  @override
  void initState() {
    super.initState();

    final firebaseApp = Firebase.app();
    _database = FirebaseDatabase.instanceFor(
        app: firebaseApp, databaseURL: _databaseURL);

    reference = _database!.ref().child('memo');

    reference!.onChildAdded.listen(
      (event) {
        print(event.snapshot.value.toString());
        setState(
          () {
            memos.add(Memo.fromSnapshot(event.snapshot));
          },
        );
      },
    );

    // channel = const AndroidNotificationChannel(
    //   'high_importance_channel', // id
    //   'High Importance Notifications', // title
    //   'This channel is used for important notifications.', // description
    //   importance: Importance.high,
    // );
    // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  }

  //BannerAd? _banner;
  // bool _loadingBanner = false;

  // Future<void> _createBanner(BuildContext context) async {
  //   final AnchoredAdaptiveBannerAdSize? size =
  //       await AdSize.getAnchoredAdaptiveBannerAdSize(
  //     Orientation.portrait,
  //     MediaQuery.of(context).size.width.truncate(),
  //   );
  //   if (size == null) {
  //     return;
  //   }
  //   final BannerAd banner = BannerAd(
  //     size: size,
  //     request: AdRequest(),
  //     adUnitId: BannerAd.testAdUnitId, // '### 하단 배너 광고 ID ###',
  //     listener: BannerAdListener(
  //       onAdLoaded: (Ad ad) {
  //         print('$BannerAd loaded.');
  //         setState(() {
  //           _banner = ad as BannerAd?;
  //         });
  //       },
  //       onAdFailedToLoad: (Ad ad, LoadAdError error) {
  //         print('$BannerAd failedToLoad: $error');
  //         ad.dispose();
  //       },
  //       onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
  //       onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
  //     ),
  //   );
  //   return banner.load();
  // }

  // _initFirebaseMessaging(BuildContext context) async {
  //   await Firebase.initializeApp();

  //   FirebaseMessaging messaging = FirebaseMessaging.instance;
  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );

  //   FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
  //     RemoteNotification? notification = message!.notification;
  //     AndroidNotification? android = message.notification?.android;
  //     if (notification != null && android != null) {
  //       // showDialog(context: context, builder: (context){
  //       //   return AlertDialog(title: Text("${notification.title}"), content: Text("${notification.body}"),);
  //       // });

  //       flutterLocalNotificationsPlugin?.show(
  //           notification.hashCode,
  //           notification.title,
  //           notification.body,
  //           NotificationDetails(
  //             android: AndroidNotificationDetails(
  //               channel!.id,
  //               channel!.name,
  //               channel!.description,
  //               icon: 'launch_background',
  //             ),
  //           ));
  //     }
  //   });

  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     print('A new onMessageOpenedApp event was published!');
  //   });
  //   print("messaging.getToken() , ${await messaging.getToken()}");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memo App'),
      ),
      body: Container(
        child: Center(
          child: memos.isEmpty
              ? const CircularProgressIndicator()
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                      child: GridTile(
                        header: Text(memos[index].title),
                        footer: Text(
                          memos[index].createTime.substring(0, 10),
                        ),
                        child: Container(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: SizedBox(
                            child: GestureDetector(
                              onTap: () {},
                              onLongPress: () {},
                              child: Text(memos[index].title),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: memos.length,
                ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MemoAddPage(reference!)));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
