import 'package:flutter/material.dart';

class OrderConfimationPage extends StatefulWidget {
  OrderConfimationPage({Key key}) : super(key: key);

  @override
  _OrderConfimationPageState createState() => _OrderConfimationPageState();
}

class _OrderConfimationPageState extends State<OrderConfimationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Order Confirmed'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Thanks for ordering with us to support local community!',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.green,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text('Order details'),
            SizedBox(
              height: 20.0,
            ),
            Text('Vendor Details'),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              child: Text('Continue Shopping'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/homepage');
              },
            ),
          ],
        ),
      ),
    );
  }
}
