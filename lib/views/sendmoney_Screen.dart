import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../firabaseServices.dart';

class SendMoney_Screen extends StatefulWidget {
  const SendMoney_Screen({Key? key}) : super(key: key);

  @override
  State<SendMoney_Screen> createState() => _SendMoney_ScreenState();
}

class _SendMoney_ScreenState extends State<SendMoney_Screen> {
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
            title: Text('Send Money',
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
                height: 570,
                width: 340,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Color(0xff4CAF50),
                        width: 2.5,
                        style: BorderStyle.solid)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('* How do i send money with paypal',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                            'to send money, you just need the recipient’s emial address. if your recipi- ent doesn’t have a paypal account, they can crate one after receiving an email message about transfered money.',
                            textAlign: TextAlign.start,
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                                letterSpacing: 1,
                                wordSpacing: 2,
                                height: 1.5)),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text('* create a paypal account:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                            'To ensure your account is set up correctly - always use the correct National ID or passport number. ',
                            textAlign: TextAlign.start,
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                                letterSpacing: 1,
                                wordSpacing: 2,
                                height: 1.5)),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text('* link a payment method:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                      SizedBox(
                        height: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                            'on the paypal websitr, click the ‘’sign up’’ for free button. this will take you to the account creation page.',
                            textAlign: TextAlign.start,
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
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
            height: 20,
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
