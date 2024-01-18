import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:paypal/views/privacypolicy_Screen.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:share_plus/share_plus.dart';

import '../firabaseServices.dart';
import 'HowToCreate_Account_Screen.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  ///================================================================================///

  @override
  void initState() {
    super.initState();
    initBannerAd();
    loadNativeAd();
  }

  ///================================================================================///

  ///================================== Banner ads ==================================///

  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  Future<void> initBannerAd() async {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref('googleAds');
    Map? allData = await FirebaseServices.getData(databaseReference);
    _bannerAd = BannerAd(
        size: AdSize.mediumRectangle,
        adUnitId: allData!['banner'],
        listener: BannerAdListener(onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        }, onAdFailedToLoad: (ad, LoadAdError error) {
          print("Failed to Load A Banner Ad${error.message}");
          _isBannerAdReady = false;
          ad.dispose();
        }),
        request: const AdRequest());
    if (allData["showAds"] == true) {
      _bannerAd.load();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Ad is not open"),
        ),
      );
    }
  }

  ///================================ InterstitialAds ===============================///

  late InterstitialAd _interstitialAd;
  bool adsShow = true;

  Future<void> interstitialAd() async {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref('googleAds');
    Map? allData = await FirebaseServices.getData(databaseReference);
    InterstitialAd.load(
      adUnitId: allData!['interstitialAd'],
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (InterstitialAd ad) =>
                print("Full Content"),
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              print("Ad not Loaded");
            },
          );
          if (allData["showAds"] == true) {
            _interstitialAd.show();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Ad is not open"),
              ),
            );
          }
        },
        onAdFailedToLoad: (error) {
          print("==========$error");
        },
      ),
    );
  }

  ///================================= Native ads code ==============================///

  late NativeAd native;
  bool isAdLoaded = false;

  Future<void> loadNativeAd() async {
    // DatabaseReference databaseReference =
    //     FirebaseDatabase.instance.ref('googleAds');
    // Map? allData = await FirebaseServices.getData(databaseReference);
    // MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
    //     testDeviceIds: ['0579EBB96BB01ACA99C05956A6B1B7C5']));
    native = NativeAd(
      request: AdRequest(),
      nativeTemplateStyle:
          NativeTemplateStyle(templateType: TemplateType.medium),
      // factoryId: "listTile",
      // adUnitId: allData!['NativeAd'],
      adUnitId: "ca-app-pub-3940256099942544/2247696110",
      listener: NativeAdListener(
        onAdLoaded: (_) {
          print("Ad Loaded");
          setState(() {
            isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print(error.message);
        },
      ),
    );
    native.load();
    // if (allData["showAds"] == true) {
    //   native.load();
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text("Ad is not open"),
    //     ),
    //   );
    // }
  }

  // adsLoad() async {
  //   print("==============load");
  //   _nativeAd = await NativeBigAd(onLoad: (ad) {
  //     setState(() {
  //       isAdLoadedBig = true;
  //     });
  //     print("---------ad---$ad");
  //   }).loadNativeAd();
  // }

  ///================================================================================///
  // final String adUnitId = "ca-app-pub-3940256099942544/2247696110";

  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
    _interstitialAd.dispose();
  }

  ///================================ Rating App code ===============================///

  double rating = 0;

  void show() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return RatingDialog(
              starSize: 25,
              starColor: Colors.yellow,
              showCloseButton: false,
              submitButtonTextStyle:
                  TextStyle(color: Colors.blue, fontSize: 20),
              title: Text(' Rate This App', textAlign: TextAlign.center),
              image: Image.asset('asserts/images/splesh_screenpng',
                  width: 110, height: 110),
              submitButtonText: 'SUBMIT',
              onSubmitted: (response) {
                print("onsubmitpressed: rating = ${response.rating}");
                print("comment: ${response.comment}");
              });
        });
  }

  ///================================================================================///

  List iconlist = [Icons.star, Icons.share, Icons.privacy_tip];
  List colorlist = [Color(0xffFFC107), Color(0xff4CAF50), Color(0xffBA65BD)];
  List textlist = ['Rate', 'Share', 'Privacy'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SafeArea(child: Center()),
              if (_isBannerAdReady)
                SizedBox(
                  height: _bannerAd.size.height.toDouble(),
                  width: _bannerAd.size.width.toDouble(),
                  child: AdWidget(ad: _bannerAd),
                ),
              SizedBox(
                height: 40,
              ),
              Center(
                  child: Container(
                height: 180,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Image.asset('asserts/images/Main_Screen.png',
                    fit: BoxFit.cover),
              )),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {
                      show();
                    },
                    minWidth: 90,
                    height: 100,
                    color: Color(0xffFFFFFF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.star,
                          color: Color(0xffFFC107),
                          size: 31,
                        ),
                        Text(
                          'Rate',
                          style: TextStyle(fontSize: 21),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      await Share.share('Hii My Name Is Nikhil',
                          subject: 'any subject if you have');
                    },
                    minWidth: 90,
                    height: 90,
                    color: Color(0xffFFFFFF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.share,
                          color: Color(0xff4CAF50),
                          size: 31,
                        ),
                        Text(
                          'Share',
                          style: TextStyle(fontSize: 21),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      interstitialAd();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => privacypolicy_Screen(),
                          ));
                    },
                    minWidth: 90,
                    height: 100,
                    color: Color(0xffFFFFFF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.privacy_tip,
                          color: Color(0xffBA65BD),
                          size: 31,
                        ),
                        Text(
                          'Privacy',
                          style: TextStyle(fontSize: 19),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {
                  interstitialAd();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateAccount_Screen(),
                      ));
                },
                height: 65,
                minWidth: 320,
                color: Color(0xff005D91),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text('GET STARTED',
                    style: GoogleFonts.acme(
                        fontSize: 21,
                        color: Color(0XFFffffff),
                        fontWeight: FontWeight.bold,
                        wordSpacing: 1,
                        letterSpacing: 1.5)),
              ),
              SizedBox(
                height: 25,
              ),
              isAdLoaded
                  ? Container(
                      height: 200,
                      width: double.infinity,
                      child: AdWidget(ad: native))
                  : CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
