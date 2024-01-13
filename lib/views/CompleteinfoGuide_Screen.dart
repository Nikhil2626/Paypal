import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:paypal/views/benifitsofapaypal_Screen.dart';
import 'package:paypal/views/electroniccheck_Screen.dart';
import 'package:paypal/views/instantcash_Screen.dart';
import 'package:paypal/views/loanthroughpaypal_Screen.dart';
import 'package:paypal/views/moneytransferfees_Screen.dart';
import 'package:paypal/views/paymentoption_Screen.dart';
import 'package:paypal/views/paymentwithpaypal_Screen.dart';
import 'package:paypal/views/paypalsendmoney_Screen.dart';
import 'package:paypal/views/resetpassword_Screen.dart';
import 'package:paypal/views/safeandsecure_Screen.dart';
import 'package:paypal/views/shopingwithpaypal_Screen.dart';
import 'package:paypal/views/topupmoneyinpaypal_Screen.dart';
import 'package:paypal/views/verifyyouraccount_Screen.dart';
import 'package:paypal/views/withdrawmoney_Screen.dart';

import '../firabaseServices.dart';
import 'Howtoaddmoney_Screen.dart';
import 'Internationalwallet_Screen.dart';
import 'changepassword_Screen.dart';
import 'craditcard_Screen.dart';
import 'linkbankaccount_Screen.dart';

class CompleteinfoGuide_Screen extends StatefulWidget {
  const CompleteinfoGuide_Screen({Key? key}) : super(key: key);

  @override
  State<CompleteinfoGuide_Screen> createState() =>
      _CompleteinfoGuide_ScreenState();
}

class _CompleteinfoGuide_ScreenState extends State<CompleteinfoGuide_Screen> {
  ///================================================================================///

  @override
  void initState() {
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

  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
    _interstitialAd.dispose();
  }

  List iconlist = [
    Icons.attach_money,
    Icons.wallet,
    Icons.currency_rupee,
    Icons.paypal,
    Icons.local_atm_sharp,
    Icons.password,
    Icons.support,
    Icons.food_bank,
    Icons.credit_card,
    Icons.reply_all,
    Icons.shopping_bag,
    Icons.replay,
    Icons.more_horiz,
    Icons.password_outlined,
    Icons.security,
    Icons.monetization_on,
    Icons.account_balance_wallet,
    Icons.check_circle,
    Icons.credit_score
  ];
  List namelist = [
    'How to add money',
    'How to international wallet works?',
    'How to get instant cash?',
    'What are the benefits of paypal?',
    'Getting a loan through paypal?',
    'How to change password?',
    'Is paypal support electronic check?',
    'How to link Bank Account with paypal account?',
    'How to add a Bank Account or credit card to paypal',
    'Paypal money transder fees?',
    'Online shopping with paypal.',
    'Payments with paypal',
    'Paypal payment options',
    'How to reset paypal pass - word if you can’t Log in?',
    'Is Paypal Safe and secure?',
    'How to send Money?',
    'How to topup money in your paypal account?',
    'How to verify your account?',
    'How to withdraw money?'
  ];
  List colorlist = [
    Color(0xff4CAF50),
    Color(0xffBA65BD),
    Color(0xffFFC107),
    Color(0xff7490F8),
    Color(0xff4CAF50),
    Color(0xffBA65BD),
    Color(0xffFFC107),
    Color(0xff7490F8),
    Color(0xff9674F8),
    Color(0xff4CAF50),
    Color(0xffBA65BD),
    Color(0xffFFC107),
    Color(0xff7490F8),
    Color(0xff4CAF50),
    Color(0xffBA65BD),
    Color(0xffFFC107),
    Color(0xff7490F8),
    Color(0xff9674F8),
    Color(0xff4CAF50)
  ];

  List screenslist = [
    howtoaddmoney_Screen(),
    Internationalwallet_Screen(),
    instantcash_Screen(),
    benifitsofpaypal_Screen(),
    loanthroughpaypal_Screen(),
    changepassword_Screen(),
    electroniccheck_Screen(),
    linkbankaccount_Screen(),
    craditcard_Screen(),
    moneytransferfees_Screen(),
    shopingwithpaypal_Screen(),
    paymentwithpaypal_Screen(),
    paymentoption_Screen(),
    resetpassword_Screen(),
    safeandsecure_Screen(),
    paypalsendmoney_Sreen(),
    topupinpaypal_Screen(),
    verifyyouraccount_Screen(),
    withdrawmoney_Screen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            backgroundColor: Color(0xff005D91),
            title: Text('Complete Info Guide',
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
                child: Image.asset('asserts/images/Sendmoney.png', width: 40),
              ),
            ],
          ),
          Expanded(
            child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => index == 4
                    ? Container(
                        width: _bannerAd!.size.width.toDouble(),
                        height: _bannerAd!.size.height.toDouble(),
                        child: AdWidget(ad: _bannerAd!),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 70,
                              width: 320,
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
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Icon(iconlist[index],
                                        color: colorlist[index], size: 25),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        interstitialAd();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  screenslist[index],
                                            ));
                                      },
                                      child: Text(
                                        namelist[index],
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                itemCount: 19),
          )
        ],
      ),
    );
  }
}
