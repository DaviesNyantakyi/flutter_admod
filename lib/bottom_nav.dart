import 'package:flutter/material.dart';
import 'package:flutter_admod/screens/banner_ads.dart';
import 'screens/Interstitial_ads.dart';
import 'screens/rewarded_ads.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int index = 0;
  List<Widget> pages = const [
    BannerAds(),
    InterstitialAds(),
    RewardedAds(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          index = value;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Banner ads',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Fully screen ads',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Rewarded ads',
          ),
        ],
      ),
    );
  }
}
