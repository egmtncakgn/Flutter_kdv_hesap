import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-4818067817392821/5199877944";
    } else if (Platform.isIOS) {
      return "ca-app-pub-your app / id";
    } else {
      return throw new UnsupportedError("Unspported Platform bro");
    }
  }
}
