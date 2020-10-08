import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:negoc8r_customer/Pages/Bargain/BargainOrderPage.dart';
import 'package:negoc8r_customer/Pages/Bargain/UpdBargainOrderPage.dart';

class BargainPage extends StatefulWidget {
  final DocumentSnapshot order;
  BargainPage({Key key, @required this.order}) : super(key: key);

  @override
  _BargainPageState createState() => _BargainPageState();
}

class _BargainPageState extends State<BargainPage> {
  @override 
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String _productName = widget.order.data()['productName'];
    String _city = widget.order.data()['city'];
    String _thumbnail = widget.order.data()['thumbnail'];
    String _area = widget.order.data()['area'];
    String _subArea = widget.order.data()['subArea'];
    double _MRP = widget.order.data()['MRP'];
    double _BBP = widget.order.data()['BBP'];
    String _shortDesc = widget.order.data()['shortDescription'];
    String _orderId = widget.order.id;
    String _bargainPrice = widget.order.data()['bargainPrice'].toString();
    DateTime _validTill = widget.order.data()['validTill'].toDate();
  
    try {
      return Scaffold(
        appBar: AppBar(
          title: Text('$_productName'),
        ),
        body: new SingleChildScrollView(
          child: Column(
            children: <Widget>[

              Container(
                child: Text(
                  '$_shortDesc',
                  textAlign: TextAlign.left,
                ),
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.all(10.0),
              ),

              //MRP And Best Buy prices
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.network(_thumbnail, width:150, height:150),
                  
                    Text(
                      'Valid till:$_validTill\nMRP: $_MRP \nBest Buy: $_BBP \nRequested Price: $_bargainPrice',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),                   
                  ],
                  
                ),
                
              ),
                 //location of the customer
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(50.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Location set:\n' + '$_city > $_area > $_subArea',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),

              SizedBox(
                width: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Edit Bargain Details'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UpdBargainOrderPage(product: widget.order),
                        ),
                      );
                    },
                  ),

                  RaisedButton(
                    child: Text('Cancel Request'),
                    onPressed: () => _cancelBargainOrder(_orderId),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      );
    } catch (e) {
      return Text('Something went wrong');
      //report error
    }
  }
  void _cancelBargainOrder(String _id) async {
    try {
     
          await FirebaseFirestore.instance.collection('allBargainOrder').
          document(_id).delete();
      print(_id);
      //add data to sub collection
      await FirebaseFirestore.instance
          .collection('customer')
          .doc("XVd5BdS8kOMFbLLFgy2H13CPLir2")
          .collection('myBargainOrder')
          .doc(_id)
          .delete();
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
