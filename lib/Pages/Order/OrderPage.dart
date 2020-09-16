///List of active orders

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final User _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    //User user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      // body: ListView(
      //   children: <Widget>[
      //     ListTile(
      //       leading: Icon(Icons.access_alarm),
      //     )
      //   ],
      // ),
      body: //Text('List of my orders'),
          // ******************streambuilder query is failing. resolve this on priority*************
          StreamBuilder(
        stream: _fetchOrderList(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          if (!snapshot.hasData) {
            return Center(
              child: Text('data not fetched yet'),
              //child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: snapshot.data.docs.map(
                (DocumentSnapshot order) {
                  return ListTile(
                    dense: true,
                    leading: Icon(Icons.phone_android),
                    trailing: Container(
                      //color: Colors.green[200],
                      child: Text(
                          'Price: ' + order.data()['bargainPrice'].toString()
                          // + '\nValid Till: ' +
                          // new DateTime().millisecondsSinceEpoch(
                          //     order.data()['validTill'])),
                          ),
                    ),
                    title: Text(
                      'Order Id: ' + order.id.toString(),
                    ),
                    subtitle: Text('Product: ' + order.data()['productName']),

                    isThreeLine: true,

                    //onTap: () {},
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ProductPage(document: product),
                    //   ),
                    // );
                  );
                },
              ).toList(),
            );
          }
        },
      ),
    );
  }

  Stream<QuerySnapshot> _fetchOrderList() {
    try {
      print(
        'inside order fetch. uid: ' + _user.uid.toString(),
      );
      return FirebaseFirestore.instance
          .collection('customer')
          .doc(_user.uid)
          .collection('myBargainOrder')
          .where(
            'isActive',
            isEqualTo: true,
          )
          .orderBy('dateModified', descending: true)
          .snapshots();
    } on Exception catch (e) {
      // handle excp
      print('Order Query Failed.\n' + e.toString());
      return null;
    }
  }
}
