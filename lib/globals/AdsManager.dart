import 'package:firebase_admob/firebase_admob.dart';
import 'dart:async';

import '../globals/Variables.dart' show APP_ID, WORD_PAGE_BANNER_ID, PROD;

class AdsManager {
  static final AdsManager _instance = new AdsManager._internal();

  factory AdsManager() {
    return _instance;
  }

  AdsManager._internal() {
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
  }

  static final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: APP_ID != null ? [APP_ID] : null,
    keywords: ['Words', 'Learning', 'Information', 'Dictionary'],
  );

  BannerAd bannerAd;
  bool showing = false;

  BannerAd buildBanner() {
    return BannerAd(
      adUnitId: (PROD
        ? WORD_PAGE_BANNER_ID
        : BannerAd.testAdUnitId),
      targetingInfo: targetingInfo,
      size: AdSize.fullBanner,
      listener: (MobileAdEvent event) {}
    );
  }

  Future<bool> load() {
    bannerAd = buildBanner();
    return bannerAd.load();
  }

  void show() async {
    if (!showing) {
      if (await bannerAd.show()) showing = true;
    }
  }

  void dispose() async {
    if (showing) {
      if (await bannerAd?.dispose()) {
        bannerAd = buildBanner()..load();
        showing = false;
      }
    }
  }

}