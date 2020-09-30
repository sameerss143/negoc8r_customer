//import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:negoc8r_customer/Pages/Bargain/MyBargainPage.dart';
import 'package:negoc8r_customer/Pages/Customer/CustomerLocation.dart';
import 'package:negoc8r_customer/Pages/Notifications.dart';
import 'Pages/Customer/AccountHome.dart';
import 'Pages/Order/OrderPage.dart';
import 'Pages/ProductCatalog/ProductCatalog.dart';
import 'Pages/HomePage.dart';
import 'Pages/LoginPage.dart';
import 'Pages/ProductCatalog/ProductListPage.dart';
import 'services/GoogleAuthenticationHandler.dart';

//main
void main() async {
  //String customerAppId = 'ca-app-pub-4294394129487657~8420531489';
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //FirebaseAdMob.instance.initialize(appId: customerAppId);

  runApp(
    MaterialApp(
      //home: WelcomePage(),
      routes: <String, WidgetBuilder>{
        '/': (context) => LoginPage(),
        '/homepage': (context) => HomePage(),
        '/myaccounthome': (context) => CustomerAccountHome(),
        '/productlist': (context) => ProductListPage(),
        '/productcatalog': (context) => ProductCatalog(),
        '/mybargainorderpage': (context) => MyBargainOrderPage(),
        //'/productpage': (context) => ProductPage(DocumentSnapshot),
        '/orderpage': (context) => OrderPage(),
        '/customeraccount': (context) => CustomerAccountHome(),
        '/customerlocation': (context) => CustomerLocation(),
        '/signindemo': (context) => SignInDemo(),
        '/setlocation': (context) => CustomerLocation(),
        //'/buyproduct': (context) => BuyProduct(),
        '/notificationpage': (context) => NotificationsPage(),
      },
    ),
  );
}
