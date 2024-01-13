// import 'package:firebase_database/firebase_database.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// import '../firabaseServices.dart';
//
// class NativeBigAd {
//   NativeBigAd({this.onLoad});
//
//   void Function(Ad)? onLoad;
//
//   loadNativeAd() async {
//     DatabaseReference databaseReference =
//         FirebaseDatabase.instance.ref('googleAds');
//     Map? allData = await FirebaseServices.getData(databaseReference);
//     print("object");
//     MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
//         testDeviceIds: ['0579EBB96BB01ACA99C05956A6B1B7C5']));
//     NativeAd ad = NativeAd(
//       request: AdRequest(),
//       nativeTemplateStyle:
//           NativeTemplateStyle(templateType: TemplateType.medium),
//       factoryId: "big",
//
//       ///This is a test adUnitId make sure to change it
//       adUnitId: allData!['NativeAd'],
//
//       listener: NativeAdListener(
//         onAdLoaded: onLoad,
//         onAdFailedToLoad: (ad, error) {
//           print('failed to load the ad ${error.message}, ${error.code}');
//           // return false;
//         },
//       ),
//     )..load();
//
//     return ad;
//   }
// }
