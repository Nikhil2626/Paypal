import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../firabaseServices.dart';

class changepassword_Screen extends StatefulWidget {
  const changepassword_Screen({Key? key}) : super(key: key);

  @override
  State<changepassword_Screen> createState() => _changepassword_ScreenState();
}

class _changepassword_ScreenState extends State<changepassword_Screen> {
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
            leading: Icon(
              Icons.arrow_back_ios,
              color: Color(0xffFFFFFF),
            ),
            title: Text('How To Change Password?',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                    color: Color(0xffFFFFFF))),
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
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 590,
                width: 340,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Color(0xffBA65BD),
                        width: 2.5,
                        style: BorderStyle.solid)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            '* How do I change my password and security questions?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17)),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                              'At this time, it`s not possible to change your password and security questions via the PayPal app. You can always change them by going to paypal.com. \n\nAt this time, it`s not possible to change your password and security questions via the PayPal app. You can always change them by going to paypal.com.  \n1)Your Visa or Mastercard Debit Card \n2)A Confirmed bank account Here show to ad  money to your Paypal account: \n3)Go to Your Wallet. \n4)Click Trancfer Money. \n5)Select Your PreferredWay of adding money. Enter the amount. \n6)Choose either in secounds with debit or up to 5 days with your bank.',
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
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                              'Adding money from your bank account to your Paypal Balance or Business account usually takes up to 5 business days (Saturday, sunday, and Holidays aren`t considered business days).',
                              textAlign: TextAlign.start,
                              textScaleFactor: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                  letterSpacing: 1,
                                  wordSpacing: 2,
                                  height: 1.5)),
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 200,
                          width: 310,
                          decoration: BoxDecoration(
                              color: Color(0xffFFFFFF),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 1.5,
                              )),
                          child: Center(
                              child:
                                  Text('Ads', style: TextStyle(fontSize: 20))),
                        ),
                        SizedBox(height: 15),
                        Text('* create  a paypal account:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17)),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                              'To ensure your account is set up correctly - always use the correct National ID or passport number.',
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
                          height: 10,
                        ),
                        Text('* verify your account (if required):',
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
                                  fontSize: 16,
                                  letterSpacing: 1,
                                  wordSpacing: 2,
                                  height: 1.5)),
                        ),
                      ],
                    ),
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
