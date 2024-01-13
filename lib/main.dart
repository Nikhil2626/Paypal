import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:paypal/views/Splash_Screen.dart';

import 'firabaseServices.dart';

AppOpenAd? _appOpenAd;

Future<void> loadAd() async {
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref('googleAds');
  Map? allData = await FirebaseServices.getData(databaseReference);
  AppOpenAd.load(
      // adUnitId: "ca-app-pub-3940256099942544/9257395921",
      adUnitId: allData!['Appopen'],
      request: AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(onAdLoaded: (AppOpenAd ad) {
        print('ad is loaded');
        _appOpenAd = ad;
        _appOpenAd!.show();
      }, onAdFailedToLoad: (error) {
        print('ad failed to load $error');
      }),
      orientation: AppOpenAd.orientationPortrait);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAmdtK12OM6PLV5SZjyJgEPsxUc9inI11k',
      appId: '1:558864358860:android:af367347a018267a405169',
      messagingSenderId: '558864358860',
      projectId: 'fir-ff0f9',
    ),
  );

  runApp(MyApp());
  loadAd();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: Splesh_Screen());
  }
}
