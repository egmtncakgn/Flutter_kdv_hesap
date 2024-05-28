import 'package:flutter/material.dart';
import 'package:flutter_kdv_hesap/widgets.dart';
// ignore: unused_import
import 'package:flutter_kdv_hesap/data.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ad_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  reklamHazirla();
  runApp(Uygulama());
}

class Uygulama extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return anaAyarlar(AnaEkran());
  }
}

class AnaEkran extends StatefulWidget {
  @override
  _AnaEkranState createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  late BannerAd _ad;
  late bool isLoaded = false;

  var groupVal = 8;
  var sonuc= "0";

  @override
  void initState() {
    super.initState();

    /// Widgets de tanımlı
    _ad = bannerHazirla();
    _ad.load();
  }

  kdvOranSecimi(var val) {
    return Row(children: [
      oranRadioButon(1, "%1"),
      oranRadioButon(2, "%8"),
      oranRadioButon(3, "%18")
    ]);
  }

  oranRadioButon(var sec, String metin) {
    return Expanded(
        child: Card(
      color: Colors.orange,
      child: RadioListTile<int>(
        title: Text(metin),
        value: sec,
        groupValue: groupVal,
        onChanged: (val) {
          print("basıldı");
          setState(() {
            groupVal = sec;
            butonIslem();
          });
        },
      ),
    ));
  }

  butonIslem() {
    var buff;
    var field;

    print("butona bastın" + groupVal.toString());
    field = fieldKontrol() ?? 0;
    buff = (field * groupVal) / 100;
    setState(() {
      sonuc = buff.toString();
    });
  }

  fieldKontrol() {
    if (data.girilenSayi == 0) {
      Fluttertoast.showToast(
        msg: "Lütfen Bir Sayı Giriniz!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else
      return data.girilenSayi;
  }

  bannerHazirla() {
    return BannerAd(
        size: AdSize.banner,
        adUnitId: AdHelper.bannerAdUnitId,
        listener: BannerAdListener(onAdLoaded: (_) {
          // ignore: unnecessary_statements
          setState(() {
            isLoaded = true;
          });
        }, onAdFailedToLoad: (_, error) {
          print("Ad Failed to Load with Error= $error");
        }),
        request: AdRequest());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Kdv  Hesaplama",
            style: TextStyle(color: Colors.orange),
          ),
          centerTitle: true,
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Stack(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Widgets de tanımlı
                  girisKismi(),
                  SizedBox(height: 25),
                  Row(children: [
                    oranRadioButon(1, "%1"),
                    oranRadioButon(8, "%8"),
                    oranRadioButon(18, "%18")
                  ]),
                  SizedBox(
                    height: 50,
                  ),
                  Text(sonuc)
                ],
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: checkForAd(isLoaded, _ad),
                  ))
            ])));
  }
}
