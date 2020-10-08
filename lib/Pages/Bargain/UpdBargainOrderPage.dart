/// Page for creating new bargain order

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdBargainOrderPage extends StatefulWidget {
  final DocumentSnapshot product;

  const UpdBargainOrderPage({Key key, @required this.product}) : super(key: key);

  @override
  _UpdBargainOrderPageState createState() => _UpdBargainOrderPageState();
}

class _UpdBargainOrderPageState extends State<UpdBargainOrderPage> {

  double _bargainPrice;
   @override 
  void initState() {
    super.initState();
    _bargainPrice = widget.product.data()['bargainPrice'];
    _myController.text = _bargainPrice.toString();
  }
  //FirebaseAuth _auth = FirebaseAuth.instance;
  User _user = FirebaseAuth.instance.currentUser;
  int _dropdownValue = 1;
  String _productName;
  double _MRP;
  double _BBP;
  String _thumbnail;
  String _shortDescription; 
  String _id;
  //String _
  String _city = 'Mumbai';
  String _area = 'Ghatkopar';
  String _subArea = 'Pantnagar';
  DateTime _validTillDate;
  DateTime _validTill;

  TextEditingController _myController = TextEditingController();
  //DocumentSnapshot product;

  @override
  Widget build(BuildContext context) {
    _productName = widget.product.data()['productName'];
    _MRP = widget.product.data()['MRP'];
    _BBP = widget.product.data()['BBP'];
    _thumbnail = widget.product.data()['thumbnail'];
    _shortDescription = widget.product.data()['shortDescription'];
    _id = widget.product.id;
    _validTill = widget.product.data()['validTill'].toDate();
   
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
           
                    title: Text(widget.product.data()['productName']),
                    subtitle: Text(widget.product.data()['brand']),
                    trailing: Container(
                      //color: Colors.green[200],
                      child: Text('MRP: ' +
                          widget.product.data()['MRP'].toString() +
                          '\nBBP: ' +
                          widget.product.data()['BBP'].toString()),
                    ),
                    isThreeLine: true,
                  ),

                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('customer')
                        .doc("XVd5BdS8kOMFbLLFgy2H13CPLir2")
                        .collection('myLocation')
                        .doc('currentLocation')
                        .get(),
                    initialData: Text('Location not set'),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      DocumentSnapshot location = snapshot.data;
                      String city = location.data()['city'];
                      String area = location.data()['area'];
                      String subArea = location.data()['subArea'];
                      return Text(
                        'Current Location \n $city > $area > $subArea',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      );
                    },
                  ),
                  IconButton(
                    tooltip: 'Change Location',
                    icon: Icon(
                      Icons.location_on,
                      color: Colors.blue,
                    ),
                    iconSize: 30.0,
                    onPressed: () {
                      Navigator.pushNamed(context, '/setlocation');
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
                    }, 
                    //initialValue: Text('$_bargainPrice').toString(),
                    keyboardType: TextInputType.number,
                    controller: _myController,
                    decoration: const InputDecoration(
                      labelText: 'Bargain Price',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                      hintText: 'Enter Bargain Price',
                    ),
                  ),
                  //Active for number of days
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: 'Extend Validity by',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    //hint: Text('Valid for days'),
                    items: [1, 2, 3]
                        .map(
                          (e) => DropdownMenuItem(
                            child: Text(
                              '${e.toString()} Day',
                            ),
                            value: e,
                          ),
                        )
                        .toList(),
                    onChanged: (newValue) {
                      setState(
                        () {
                          _dropdownValue = newValue;
                          _validTillDate = _validTill
                              .add(Duration(days: _dropdownValue));
                        },
                      );
                    },
                  ),
                  RaisedButton(
                    child: Text('Submit'),
                    onPressed: () => _updateBargainOrder(_id),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateBargainOrder(String _id) async {
    try {
          
        await FirebaseFirestore.instance.collection('allBargainOrder').doc(_id).updateData(
          {
          'bargainPrice': double.parse(_myController.text.toString()),
          'validTill': _validTillDate,
          },
        );
        
      //print('#order: ' + _order.id);
      //add data to sub collection
      await FirebaseFirestore.instance
          .collection('customer')
          .doc("XVd5BdS8kOMFbLLFgy2H13CPLir2")
          .collection('myBargainOrder')
          .doc(_id)
          .updateData(
        {
          'bargainPrice': double.parse(_myController.text.toString()),
          'validTill': _validTillDate,
        },
      );
      //return true;
      //Navigator.popUntil(context, (route) => false);
      Navigator.pushNamed(context, '/mybargainorderpage');
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
  
}
