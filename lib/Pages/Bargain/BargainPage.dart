import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:negoc8r_customer/Pages/Bargain/BargainOrderPage.dart';

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
    String _area = widget.order.data()['area'];
    String _subArea = widget.order.data()['subArea'];
    double _MRP = widget.order.data()['MRP'];
    double _BBP = widget.order.data()['BBP'];
    String _shortDesc = widget.order.data()['shortDescription'];
    String _orderId = widget.order.id;
    String _bargainPrice = widget.order.data()['bargainPrice'].toString();
    List _imgList = List.of(widget.order.data()['images']);

    try {
      return Scaffold(
        appBar: AppBar(
          title: Text('$_productName'),
        ),
        body: new SingleChildScrollView(
          child: Column(
            children: <Widget>[
              new CarouselSlider(
                items: _imgList.map(
                  (imgLink) {
                    if (imgLink != null) {
                      return Container(
                        child: Image.network(imgLink),
                      );
                    }
                  },
                ).toList(),
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 5),
                ),
              ),
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
                    Text(
                      'MRP: $_MRP',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Best Buy: $_BBP',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Requested Price: $_bargainPrice',
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
                              BargainOrderPage(product: widget.order),
                        ),
                      );
                    },
                  ),
                  // RaisedButton(
                  //   child: Text('Negotiate'),
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) =>
                  //             BargainOrderPage(product: widget.product),
                  //       ),
                  //     );
                  //   },
                  // ),
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
}
