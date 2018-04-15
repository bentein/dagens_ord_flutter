import 'package:firebase_admob/firebase_admob.dart';

import '../globals/Variables.dart' show APP_ID, WORD_PAGE_BANNER_ID, PROD;

class AdsManager {
  static final AdsManager _instance = new AdsManager._internal();

  factory AdsManager() {
    return _instance;
  }

  AdsManager._internal() {
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    bannerAd = buildBanner()..load();
  }

  static final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: APP_ID != null ? [APP_ID] : null,
    keywords: ['Words', 'Learning', 'Information', 'Dictionary'],
  );

  BannerAd bannerAd;

  BannerAd buildBanner() {
    return BannerAd(
      adUnitId: (PROD
        ? WORD_PAGE_BANNER_ID
        : BannerAd.testAdUnitId),
      targetingInfo: targetingInfo,
      size: AdSize.smartBanner,
      listener: (MobileAdEvent event) {}
    );
  }

  void show() {
    bannerAd = buildBanner()..load()..show();
  }

  void dispose() {
    bannerAd?.dispose();
  }

}