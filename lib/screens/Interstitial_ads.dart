import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../admod_service.dart';

// Fully screen ads
class InterstitialAds extends StatefulWidget {
  const InterstitialAds({super.key});

  @override
  State<InterstitialAds> createState() => _InterstitialAdsState();
}

class _InterstitialAdsState extends State<InterstitialAds> {
  InterstitialAd? interstitialAd;

  @override
  void initState() {
    createInterstitial();
    super.initState();
  }

  void createInterstitial() {
    InterstitialAd.load(
      adUnitId: AdmodService.getInterstitialUnitedId!,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => interstitialAd = ad,
        onAdFailedToLoad: (LoadAdError error) => interstitialAd = null,
      ),
    );
  }

  void showIntersitialAd() {
    if (interstitialAd != null) {
      interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          createInterstitial();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          createInterstitial();
        },
      );
      interstitialAd?.show();
      interstitialAd = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interstitial Ads (Fully screen)'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text("Fully Screen"),
            ElevatedButton(
              onPressed: () {
                showIntersitialAd();
              },
              child: const Text('ShowAd'),
            )
          ],
        ),
      ),
    );
  }
}
