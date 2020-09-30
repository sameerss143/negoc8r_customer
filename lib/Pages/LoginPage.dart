//import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final String _appname = 'NegoC8r';
  //MobileAdTargetingInfo targetingInfo;
  // static const String _testDevice = 'YOUR_DEVICE_ID';
  // String adUnitId = 'ca-app-pub-4294394129487657/3622666221';
  // BannerAd _bannerAd;

  @override
  void initState() {
    // FirebaseAdMob.instance.initialize(
    //   appId: BannerAd.testAdUnitId,
    // );

    // targetingInfo = MobileAdTargetingInfo(
    //   testDevices: <String>[],
    //   //_testDevice != null ? <String>[_testDevice] : null,
    //   keywords: <String>['shopping', 'fashion'],
    //   //contentUrl: '',
    //   childDirected: true,
    //   nonPersonalizedAds: true,
    // );

    // _bannerAd = createBannerAd()
    //   ..load()
    //   ..show();

    super.initState();
  }

  @override
  void dispose() {
    //_bannerAd.dispose();
    super.dispose();
  }

  // BannerAd createBannerAd() {
  //   return BannerAd(
  //     adUnitId: adUnitId, //BannerAd.testAdUnitId,
  //     size: AdSize.banner,
  //     targetingInfo: targetingInfo,
  //     listener: (MobileAdEvent event) {
  //       print("BannerAd event $event");
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text(_appname),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(
              "Welcome to the New age of Shopping!",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            alignment: Alignment.center,
            //color: Colors.cyan[100],
          ),
          SizedBox(
            width: 50,
            height: 50,
          ),
          SignInButton(
            Buttons.Google,
            onPressed: () {
              //Navigator.pushNamed(context, '/homepage');
              _showButtonPressDialog(context, 'Google');
            },
          ),
          SignInButton(
            Buttons.Facebook,
            onPressed: () {},
          ),
          SignInButton(
            Buttons.Apple,
            onPressed: () {},
          ),
          // Container(
          //   child: createBannerAd(),
          // ),
        ],
      ),
    );
  }

  void _showButtonPressDialog(BuildContext context, String provider) {
    //print(provider);
    if (provider == 'Google') {
      //Future<FirebaseUser> user = googleSignIn();
      Navigator.pushNamed(context, '/signindemo');
      //   if (user != null) {
      //     //Navigator.push(
      //     //    context, MaterialPageRoute(builder: (context) => HomePage()));
      //     Navigator.pushNamed(context, '/homepage');
      //   } else
      //     print('login failed.');
    }
  }
}
