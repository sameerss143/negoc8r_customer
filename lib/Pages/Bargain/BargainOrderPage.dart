import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BargainOrderPage extends StatefulWidget {
  final DocumentSnapshot product;

  const BargainOrderPage({Key key, @required this.product}) : super(key: key);

  @override
  _BargainOrderPageState createState() => _BargainOrderPageState();
}

class _BargainOrderPageState extends State<BargainOrderPage> {
  //FirebaseAuth _auth = FirebaseAuth.instance;
  User _user = FirebaseAuth.instance.currentUser;
  int _dropdownValue = 1;
  String _city = 'Mumbai';
  String _area = 'Ghatkopar';
  String _subArea = 'Pantnagar';
  DateTime _validTillDate;

  TextEditingController _myController = TextEditingController();
  //DocumentSnapshot product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Negotiate Price'),
      ),
      body: ListView(
        padding: EdgeInsets.all(15.0),
        children: <Widget>[
          Center(
            child: Form(
              child: Column(
                children: [
                  //Center(child: Text("Product Name :" + document.data()['name']),
                  ListTile(
                    dense: false,
                    //leading: Icon(Icons.phone_iphone),
                    // insert thumbnail widget.product.data()['img']),
                    leading: Image.network(widget.product.data()['images'][0]),
                    trailing: Container(
                      //color: Colors.green[200],
                      child: Text('MRP: ' +
                          widget.product.data()['MRP'].toString() +
                          '\nBBP: ' +
                          widget.product.data()['BBP'].toString()),
                    ),
                    title: Text(widget.product.data()['name']),
                    subtitle: Text(widget.product.data()['Brand']),
                    isThreeLine: true,
                  ),
                  //Customer location
                  //DropdownButton(items: DropdownMenuItem(child: null), onChanged: null),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: 'City',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    hint: Text(
                      'Select City',
                      textAlign: TextAlign.center,
                      //TextAlignVertical.bottom,,
                    ),
                    items: _getCities(),
                    onChanged: (newValue) {
                      setState(
                        () {
                          _area = null;
                          _subArea = null;
                          _city = newValue;
                          _getAreasInCity();
                          //print('area: $_area');
                        },
                      );
                    },
                  ),
                  //select area
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: 'Area',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    hint: Text(
                      'Select Area',
                      textAlign: TextAlign.center,
                      //TextAlignVertical.bottom,,
                    ),
                    items: _getAreasInCity(),
                    onChanged: (newValue) {
                      setState(
                        () {
                          //if (newValue != null) {
                          _subArea = null;
                          _area = newValue;
                          _getSubAreas();
                          //}
                        },
                      );
                    },
                  ),
                  //select sub-area
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: 'Sub-area',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    hint: Text(
                      'Select Sub-area',
                      textAlign: TextAlign.right,
                      //TextAlignVertical.bottom,,
                    ),
                    items: _getSubAreas(),
                    onChanged: (newValue) {
                      setState(
                        () {
                          //if (newValue != null) {
                          _subArea = newValue;
                          //}
                        },
                      );
                    },
                  ),
                  //Customer price
                  TextFormField(
                    validator: (String value) {
                      if (widget.product.data()['BBP'] >= value) {
                        return 'Bargain value cant be less than offer value';
                      } else {
                        return null;
                      }
                    }, //initialValue: Text('0.00').toString(),
                    keyboardType: TextInputType.number,
                    controller: _myController,
                    decoration: const InputDecoration(
                      labelText: 'Bargain Price',
                      labelStyle: TextStyle(
                        fontSize: 20.0,
                      ),
                      hintText: 'Enter Bargain Price',
                    ),
                  ),
                  //Active for number of days
                  DropdownButtonFormField(
                    hint: Text('Valid for days'),
                    items: [1, 2, 3]
                        .map(
                          (e) => DropdownMenuItem(
                            child: Text(
                              e.toString(),
                            ),
                            value: e,
                          ),
                        )
                        .toList(),
                    onChanged: (newValue) {
                      setState(
                        () {
                          _dropdownValue = newValue;
                          _validTillDate = DateTime.now()
                              .add(Duration(days: _dropdownValue));
                        },
                      );
                    },
                  ),
                  RaisedButton(
                    child: Text('Submit'),
                    onPressed: () => _submitBargainOrder(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // bool _submitBargainOrder() {
  //   return true;
  // }

  void _submitBargainOrder() async {
    try {
      await FirebaseFirestore.instance.collection('BargainOrder').add(
        {
          'productId': 'product/' + widget.product.id,
          //.data()['documentId'], //'/product/wyrBLHYu6uhsvBKSrSra',
          'userId': _user.uid, //'/customer/yxNVdYqQJsFpI3GlG5MF',
          'city': _city,
          'area': _area,
          'subArea': _subArea,
          'bargainPrice': double.parse(_myController.text.toString()),
          'validTill': _validTillDate,
          'dateInserted': Timestamp.now(),
          'isActive': true,
          'status': 'active',
        },
      );
      //return true;
      Navigator.popUntil(context, (route) => false);
      Navigator.pushNamed(context, '/orderpage');
    } catch (e) {
      print(e.toString());
      Text(
        'Submission failed',
        style: TextStyle(
          color: Colors.red,
        ),
      );
      //return false;
    }
  }

//get list of cities
  List<DropdownMenuItem> _getCities() {
    return ['Mumbai', 'Pune', 'Thane', 'Navi Mumbai']
        .map(
          (e) => DropdownMenuItem(
            child: Text(
              e.toString(),
            ),
            value: e,
          ),
        )
        .toList();
  }

  List<DropdownMenuItem> _getAreasInCity() {
    if (_city == 'Mumbai') {
      return ['Ghatkopar', 'Mulund', 'Dadar', 'CST', 'Borivli']
          .map(
            (e) => DropdownMenuItem(
              child: Text(e),
              value: e,
              //key: Text(e.toString()
            ),
          )
          .toList();
    }
    if (_city == 'Navi Mumbai') {
      return ['Airoli', 'Vashi', 'Panvel']
          .map(
            (e) => DropdownMenuItem(
              child: Text(e),
              value: e,
              //key: Text(e.toString()
            ),
          )
          .toList();
    }
    if (_city == 'Thane') {
      return ['Thane', 'Dombivli', 'Kalyan', 'Diva']
          .map(
            (e) => DropdownMenuItem(
              child: Text(e),
              value: e,
              //key: Text(e.toString()
            ),
          )
          .toList();
    }
    if (_city == 'Pune') {
      return ['Shivaji Nagar', 'Katraj', 'Sangamwadi', 'Koregaon', 'Bibwewadi']
          .map(
            (e) => DropdownMenuItem(
              child: Text(e),
              value: e,
              //key: Text(e.toString()
            ),
          )
          .toList();
    }

    //if no city selected
    return null;
  }

  //get Sub-area
  List<DropdownMenuItem> _getSubAreas() {
    if (_area == 'Ghatkopar') {
      return ['Pantnagar', 'Garudia', 'Samta nagar', 'Bhatwadi']
          .map(
            (e) => DropdownMenuItem(
              child: Text(e),
              value: e,
              //key: Text(e.toString()
            ),
          )
          .toList();
    }
    if (_area == 'Airoli') {
      return ['Sector 5', 'Sector 20', 'Sector 10']
          .map(
            (e) => DropdownMenuItem(
              child: Text(e),
              value: e,
              //key: Text(e.toString()
            ),
          )
          .toList();
    }
    if (_area == 'Dombivli') {
      return ['Kopar', 'Nandivli', 'Ramnagar', 'Desale pada', 'Palava']
          .map(
            (e) => DropdownMenuItem(
              child: Text(e),
              value: e,
              //key: Text(e.toString()
            ),
          )
          .toList();
    }
    if (_area == 'Shivaji Nagar') {
      return ['Model Colony', 'Fergusson', 'Sakhar Sankul', 'Station']
          .map(
            (e) => DropdownMenuItem(
              child: Text(e),
              value: e,
              //key: Text(e.toString()
            ),
          )
          .toList();
    }
    return null;
  }
}
