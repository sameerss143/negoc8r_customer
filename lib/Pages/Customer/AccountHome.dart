import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:negoc8r_customer/CustomWidgets/AppDrawer.dart';
import 'package:negoc8r_customer/Objects/LocationClasses.dart';

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
    // Location currentLocation;
    // getLocation(currentLocation);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
      ),
      drawer: AppDrawer(),
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(15.0),
        children: <Widget>[
          DefaultTextStyle(
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.grey[800],
            ),
            child: Column(
              // crossAxisCount: 2,
              // scrollDirection: Axis.vertical,
              //padding: EdgeInsets.all(15.0),
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  _user.photoURL,
                  alignment: Alignment.topRight,
                ),
                SizedBox(height: 20.0),
                Icon(Icons.account_box),
                Text('Name: ' + _user.displayName),
                SizedBox(height: 20.0),
                Icon(Icons.email),
                Text('Email: ' + _user.email),
                SizedBox(height: 20.0),
                Icon(Icons.phone),
                Text('Phone: ' + _user.phoneNumber.toString()),
                SizedBox(height: 20.0),
                Icon(Icons.location_on),
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('customer')
                      .doc(_user.uid)
                      .collection('myLocation')
                      .doc('currentLocation')
                      .get(),
                  initialData: Text('Location not set'),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    DocumentSnapshot location = snapshot.data;
                    String city = location.data()['city'];
                    String area = location.data()['area'];
                    String subArea = location.data()['subArea'];
                    if (city != null && area != null && subArea != null) {
                      return Text('Location: $city > $area > $subArea');
                    } else {
                      return Text(
                        'Please set the location.',
                        style: TextStyle(color: Colors.red),
                      );
                    }
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  padding: EdgeInsets.all(10.0),
                  //textColor: Colors.blue,
                  child: Text(
                    'Update location',
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
          )
        ],
      ),
    );
  }

  getLocation(Location currentLocation) async {
    DocumentSnapshot myLocation = await FirebaseFirestore.instance
        .collection('customer')
        .doc(_user.uid)
        .collection('myLocation')
        .doc('currentLocation')
        .get();

    currentLocation = new Location(
      city: myLocation.data()["city"],
      area: myLocation.data()["area"],
      subArea: myLocation.data()["subArea"],
    );

    // currentLocation.city = myLocation.data()["city"];
    // currentLocation.area = myLocation.data()["area"];
    // currentLocation.subArea = myLocation.data()["subArea"];
    //return currentLocation;
  }
}
