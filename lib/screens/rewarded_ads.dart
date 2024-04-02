import 'package:flutter/material.dart';
import 'package:flutter_admod/admod_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// Fully screen ads
class RewardedAds extends StatefulWidget {
  const RewardedAds({super.key});

  @override
  State<RewardedAds> createState() => _RewardedAdsState();
}

class _RewardedAdsState extends State<RewardedAds> {
  RewardedAd? _rewardedAd;
  int rewardScore = 0;
  @override
  void initState() {
    createRewardAd();
    super.initState();
  }

  void createRewardAd() {
    RewardedAd.load(
      adUnitId: AdmodService.getRewardedAdUnitId!,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) => setState(() {
          _rewardedAd = ad;
        }),
        onAdFailedToLoad: (error) => setState(() {
          _rewardedAd = null;
        }),
      ),
    );
  }

  void showRewardedAd() {
    if (_rewardedAd != null) {
      _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          createRewardAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          createRewardAd();
        },
      );
      _rewardedAd?.show(
        onUserEarnedReward: (ad, error) => setState(() {
          rewardScore++;
        }),
      );
      _rewardedAd = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RewardedAds'),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Reward score: $rewardScore"),
            ElevatedButton(
              onPressed: showRewardedAd,
              child: const Text('Get 1 free score'),
            )
          ],
        ),
      ),
    );
  }
}
