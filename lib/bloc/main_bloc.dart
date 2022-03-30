import 'package:bts_offline_music_2021/persistence/share_preference.dart';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';

const int maxFailedLoadAttempts = 3;

class MainBloc extends ChangeNotifier {
  // late SharePreference sp;

  // int milliSecondInADay = 86400000;

  // InterstitialAd? _interstitialAd;

  // int _numInterstitialLoadAttempts = 0;
  // String timeStemp = "";


  // MainBloc() {
  //   sp = SharePreference();
  //   getTimeStemp().then((value) => print("time $timeStemp"));

  //   _createInterstitialAd();
    
  // }



  // Future getTimeStemp() async {
  //   timeStemp = await sp.getAdsShowTime() ?? "";
  //   notifyListeners();
  // }

  // Future saveTimeStemp(String time) async {
  //   await sp.saveAdsShowTime(time);
  // }

  // Future<void> _createInterstitialAd() async {
  //   InterstitialAd.load(
  //       adUnitId: InterstitialAd.testAdUnitId,
  //       request: AdRequest(),
  //       adLoadCallback: InterstitialAdLoadCallback(
  //         onAdLoaded: (InterstitialAd ad) {
  //           print('$ad loaded');
  //           _interstitialAd = ad;
  //           _numInterstitialLoadAttempts = 0;
  //           _interstitialAd!.setImmersiveMode(true);
  //         },
  //         onAdFailedToLoad: (LoadAdError error) {
  //           print('InterstitialAd failed to load: $error.');
  //           _numInterstitialLoadAttempts += 1;
  //           _interstitialAd = null;
  //           if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
  //             _createInterstitialAd();
  //           }
  //         },
  //       ));
  // }

  // void showInterstitialAd() {
  //   if (_interstitialAd == null) {
  //     print('Warning: attempt to show interstitial before loaded.');
  //     return;
  //   }
  //   _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
  //     onAdShowedFullScreenContent: (InterstitialAd ad) =>
  //         print('ad onAdShowedFullScreenContent.'),
  //     onAdDismissedFullScreenContent: (InterstitialAd ad) {
  //       print('$ad onAdDismissedFullScreenContent.');
  //       ad.dispose();
  //       _createInterstitialAd();
  //     },
  //     onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
  //       print('$ad onAdFailedToShowFullScreenContent: $error');
  //       ad.dispose();
  //       _createInterstitialAd();
  //     },
  //   );
  //   _interstitialAd!.show();
  //   _interstitialAd = null;
  // }

  // void showAdsAfter24hrs() {
  //   if (timeStemp == null || timeStemp == "") {
  //     saveTimeStemp(DateTime.now().toString()).then(
  //       (value) => Future.delayed(Duration(seconds: 1)).then(
  //         (value) => showInterstitialAd(),
  //       ),
  //     );
  //     print("saving time stemp");
  //   } else {
  //     // Check if he opened the app
  //     final bool openedTimeStemp =
  //         DateTime.now().difference(DateTime.parse(timeStemp)).inMinutes >= 30;
  //     print(
  //         'range : $openedTimeStemp ${DateTime.now().difference(DateTime.parse(timeStemp)).inMinutes}');
  //     if (openedTimeStemp) {
  //       saveTimeStemp(DateTime.now().toString()).then((value) =>
  //           Future.delayed(Duration(seconds: 1))
  //               .then((value) => showInterstitialAd()));
  //       print("is after");
  //     } else {
  //       print('is before');
  //     }
  //   }
  // }

  // @override
  // void dispose() {
  //   _interstitialAd?.dispose();
  //   super.dispose();
  // }
}
