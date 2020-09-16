import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:negoc8r_customer/CustomWidgets/AppDrawer.dart';

class CustomerAccountHome extends StatelessWidget {
  const CustomerAccountHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User _user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
      ),
      drawer: AppDrawer(),
      body: ListView(
        children: <Widget>[
          DefaultTextStyle(
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.grey[800],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  _user.photoURL,
                  alignment: Alignment.topRight,
                ),
                Text('Name: ' + _user.displayName),
                SizedBox(height: 30.0),
                Text('Email: ' + _user.email),
                SizedBox(height: 30.0),
                Text('Phone: ' + _user.phoneNumber),
                SizedBox(height: 30.0),
                Text('Location: ' + _user.phoneNumber),
                SizedBox(height: 30.0),
                RaisedButton(
                  padding: EdgeInsets.all(10.0),
                  //textColor: Colors.blue,
                  child: Text(
                    'Set location',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/customerlocation');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
