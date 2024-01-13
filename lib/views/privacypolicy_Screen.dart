import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../firabaseServices.dart';

class privacypolicy_Screen extends StatefulWidget {
  const privacypolicy_Screen({Key? key}) : super(key: key);

  @override
  State<privacypolicy_Screen> createState() => _privacypolicy_ScreenState();
}

class _privacypolicy_ScreenState extends State<privacypolicy_Screen> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            backgroundColor: Color(0xff005D91),
            title: Text('Privacy Policy',
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
                        color: Color(0xff4CAF50),
                        width: 2.5,
                        style: BorderStyle.solid)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('* Privacy Policy',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17)),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                              'Bold Apps Studio built the how to create PayPal Account app as an Ad Supported app. This SERVICE is provided by Bold Apps Studio at no cost and is intended for use as is.  \n\nThis page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service. \n\nIf you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy. \n\nThe terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at how to create PayPal Account unless otherwise defined in this Privacy Policy.',
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
                        SizedBox(
                          height: 15,
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
                          height: 85,
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
