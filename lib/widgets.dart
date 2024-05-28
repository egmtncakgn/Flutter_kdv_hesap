import 'package:flutter/material.dart';
import 'package:flutter_kdv_hesap/data.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

anaAyarlar(var home) {
  return MaterialApp(
    theme: ThemeData(
      brightness: Brightness.light,
    ),
    darkTheme: ThemeData(
      brightness: Brightness.dark,
    ),
    themeMode: ThemeMode.dark,
    debugShowCheckedModeBanner: false,
    title: "Kdv Hesaplama",
    home: home,
  );
}

reklamHazirla() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
}

checkForAd(bool isLoaded, BannerAd _ad) {
  if (isLoaded == true) {
    return Container(
      child: AdWidget(
        ad: _ad,
      ),
      height: _ad.size.height.toDouble(),
      width: _ad.size.width.toDouble(),
      alignment: Alignment.center,
    );
  } else {
    return CircularProgressIndicator();
  }
}

girisKismi() {
  return Card(
    color: Colors.transparent,
    child: Column(
      children: [
        Text(
          "Hesaplanacak Miktar",
          style: TextStyle(color: Colors.orange),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          keyboardType: TextInputType.number,
          maxLength: 17,
          onChanged: (String say) {
            try {
              data.girilenSayi = double.parse(say);
              print(say);
            } catch (ex) {
              data.girilenSayi = 0;
              print("Başğanım bi sıkıntımız var galiba?");
            }
          },
        )
      ],
    ),
  );
}
