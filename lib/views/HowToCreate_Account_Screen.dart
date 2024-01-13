import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:paypal/views/sendmoney_Screen.dart';

import '../firabaseServices.dart';
import 'AccountCreation_Screen.dart';
import 'Accountwithcraditcard_Scren.dart';
import 'BusinessAccount_Screen.dart';
import 'CompleteinfoGuide_Screen.dart';
import 'PersonalAccount_Screen.dart';
import 'ReceiveMoney_Screen.dart';
import 'TopupBalance_Screen.dart';

class CreateAccount_Screen extends StatefulWidget {
  const CreateAccount_Screen({Key? key}) : super(key: key);

  @override
  State<CreateAccount_Screen> createState() => _CreateAccount_ScreenState();
}

class _CreateAccount_ScreenState extends State<CreateAccount_Screen> {
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

  ///======================================== native ads code=================
  // adsLoad() async {
  //   print("==============load");
  //   adBig = await NativeBigAd(onLoad: (ad) {
  //     setState(() {
  //       isAdLoadedBig = true;
  //       print("---------ad---$ad");
  //     });
  //   }).loadNativeAd();
  // }
  //
  // NativeAd? adBig;
  // bool isAdLoadedBig = false;

  ///================================================================================///

  @override
  void initState() {
    super.initState();
    initBannerAd();
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

  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
    _interstitialAd.dispose();
  }

  List screens = [
    AccountCreation_Screen(),
    SendMoney_Screen(),
    ReceiveMoney_Screen(),
  ];
  List screens2 = [
    CompleteinfoGuide_Screen(),
    Accountwithcraditcard_Screen(),
    TopupBalance_Screen(),
  ];
  List screens3 = [
    PersonalAccount_Screen(),
    BusinessAccount_Screen(),
  ];
  List icon2list = [
    Icons.info_outline,
    Icons.credit_card,
    Icons.cloud_download
  ];
  List color2list = [Color(0xff4CAF50), Color(0xffBA65BD), Color(0xffFFC107)];
  List text2list = [
    'Complete Info Guide',
    'Account With Credit Card',
    'Top Up Balance'
  ];

  List iconlist = [Icons.account_circle, Icons.send, Icons.wallet];
  List colorlist = [Color(0xffFFC107), Color(0xff4CAF50), Color(0xffBA65BD)];
  List textlist = ['Account Creation', 'Send Money', 'Receive Money'];

  List icon3list = [Icons.person, Icons.account_balance_wallet];
  List text3list = ['Personal Account', 'Business Account'];
  List color3list = [Color(0xff4CAF50), Color(0xffBA65BD)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff005D91),
        title: Text('How To Create Account Guide',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 17,
                color: Color(0xffFFFFFF))),
        leading: Icon(
          Icons.home,
          color: Color(0xffFFFFFF),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child:
                Image.asset('asserts/images/HowtocreateAccount.png', width: 40),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(),
            if (_isBannerAdReady)
              Container(
                height: _bannerAd.size.height.toDouble(),
                width: _bannerAd.size.width.toDouble(),
                child: AdWidget(ad: _bannerAd),
              ),
            SizedBox(
              height: 20,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => InkWell(
                      onTap: () {
                        interstitialAd();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => screens[index],
                            ));
                      },
                      child: Container(
                        height: 140,
                        width: 100,
                        margin: EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                            color: Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                offset: Offset(1, 1),
                                blurRadius: 2,
                              )
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(iconlist[index],
                                color: colorlist[index], size: 40),
                            Text(
                              textlist[index],
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
            SizedBox(
              height: 25,
            ),
            Column(
              children: List.generate(
                3,
                (index) => InkWell(
                  onTap: () {
                    interstitialAd();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => screens2[index],
                        ));
                  },
                  child: Container(
                    height: 70,
                    width: 320,
                    margin: EdgeInsets.symmetric(vertical: 7),
                    decoration: BoxDecoration(
                        color: Color(0xffFFFFFF),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            offset: Offset(1, 1),
                            blurRadius: 2,
                          )
                        ]),
                    child: Row(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              icon2list[index],
                              color: color2list[index],
                              size: 32,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              text2list[index],
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        // Spacer(),
                        // Container(
                        //   height: 65,
                        //   width: 5,
                        //   decoration: BoxDecoration(
                        //     color: color2list[index],
                        //     borderRadius: BorderRadius.only(
                        //         topRight: Radius.circular(15),
                        //         bottomRight: Radius.circular(15)),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            // Container(
            //   height: 174.7,
            //   width: double.infinity,
            //   decoration: BoxDecoration(color: Color(0xffFFFFFF)),
            //   child: Center(
            //     child: Text('Ads',
            //         style:
            //             TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
            //   ),
            // ),
            // adBig != null && isAdLoadedBig == true
            //     ? Container(
            //         width: double.infinity,
            //         height: 350,
            //         child: AdWidget(ad: adBig!),
            //       )
            //     : Text('Loading Ad'),
            // SizedBox(
            //   height: 20,
            // ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    2,
                    (index) => InkWell(
                      onTap: () {
                        interstitialAd();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => screens3[index],
                            ));
                      },
                      child: Container(
                        height: 100,
                        width: 155,
                        margin: EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                            color: Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                offset: Offset(1, 1),
                                blurRadius: 2,
                              )
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(icon3list[index],
                                color: color3list[index], size: 40),
                            Text(
                              text3list[index],
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
