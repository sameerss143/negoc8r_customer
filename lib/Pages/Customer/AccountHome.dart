import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:negoc8r_customer/CustomWidgets/AppDrawer.dart';

class CustomerAccountHome extends StatefulWidget {
  const CustomerAccountHome({Key key}) : super(key: key);
  //User _user = FirebaseAuth.instance.currentUser;

  @override
  _CustomerAccountHomeState createState() => _CustomerAccountHomeState();
}

class _CustomerAccountHomeState extends State<CustomerAccountHome> {
  User _user;
  @override
  void initState() {
    super.initState();
    this._user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    //print('User : ' + _user.uid + _user.displayName);
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
                SizedBox(height: 30.0),
                Text('Name: ' + _user.displayName),
                SizedBox(height: 30.0),
                Text('Email: ' + _user.email),
                SizedBox(height: 30.0),
                Text('Phone: ' + _user.phoneNumber.toString()),
                SizedBox(height: 30.0),
                // Text('Location: ' + _user.phoneNumber),
                SizedBox(height: 30.0),
                RaisedButton(
                  padding: EdgeInsets.all(10.0),
                  //textColor: Colors.blue,
                  child: Text(
                    'Set location',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
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
