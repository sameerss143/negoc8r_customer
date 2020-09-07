import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatelessWidget {
  final String _appname = 'Negotiator';

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
          SignInButton(Buttons.Apple, onPressed: () {}),
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
