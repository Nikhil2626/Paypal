import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../firabaseServices.dart';

class TopupBalance_Screen extends StatefulWidget {
  const TopupBalance_Screen({Key? key}) : super(key: key);

  @override
  State<TopupBalance_Screen> createState() => _TopupBalance_ScreenState();
}

class _TopupBalance_ScreenState extends State<TopupBalance_Screen> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            backgroundColor: Color(0xff005D91),
            title: Text('How To Topup Balance In Your Paypal Account?',
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
          SizedBox(
            height: 10,
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 580,
                width: 340,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Color(0xffFFC107),
                        width: 2.5,
                        style: BorderStyle.solid)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                            'PayPal has become a popular and prevalent way of paying for items on the internet; it`s not just for eBay. Setting up an account isn`t difficult, but it does involve several steps. ',
                            textAlign: TextAlign.start,
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 17.5,
                                letterSpacing: 1,
                                wordSpacing: 2,
                                height: 1.5)),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Text('* Link A Bank Account:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                            'go to the official paypal website (www.paypal.com)',
                            textAlign: TextAlign.start,
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 17.5,
                                letterSpacing: 1,
                                wordSpacing: 2,
                                height: 1.5)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text('* Add A Debit Or Credit Card:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                      SizedBox(
                        height: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                            'click on the sign up or ‘sign up for free’ button to start the registration process.',
                            textAlign: TextAlign.start,
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 17.5,
                                letterSpacing: 1,
                                wordSpacing: 2,
                                height: 1.5)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text('* Paypal Cash:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                      SizedBox(
                        height: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                            'on the paypal websitr, click the ‘’signup’’ for free button. this will take you to the account creation page.',
                            textAlign: TextAlign.start,
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 17.5,
                                letterSpacing: 1,
                                wordSpacing: 2,
                                height: 1.5)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Center(),
          if (_isBannerAdReady)
            SizedBox(
              height: _bannerAd.size.height.toDouble(),
              width: _bannerAd.size.width.toDouble(),
              child: AdWidget(ad: _bannerAd),
            ),
        ],
      ),
    );
  }
}
