import 'package:flutter/material.dart';
import 'package:flutter_admod/admod_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAds extends StatefulWidget {
  const BannerAds({super.key});

  @override
  State<BannerAds> createState() => _BannerAdsState();
}

class _BannerAdsState extends State<BannerAds> {
  BannerAd? banner;

  @override
  void initState() {
    createBannerAd();
    super.initState();
  }

  void createBannerAd() {
    banner = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdmodService.getBannerUnitedId!,
      listener: AdmodService.bannerAdListener,
      request: const AdRequest(),
    )..load();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Banner Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Banner Screen"),
            banner == null
                ? Container()
                : Flexible(
                    child: AdWidget(
                      ad: banner!,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
