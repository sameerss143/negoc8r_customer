import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:negoc8r_customer/Pages/Bargain/BargainPage.dart';

class MyBargainOrderPage extends StatefulWidget {
  MyBargainOrderPage({Key key}) : super(key: key);

  @override
  _MyBargainOrderPageState createState() => _MyBargainOrderPageState();
}

class _MyBargainOrderPageState extends State<MyBargainOrderPage> {
  final User _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('My Negociations'),
      ),
      body: //Text('List of my orders'),
          // ******************streambuilder query is failing. resolve this on priority*************
          StreamBuilder(
        stream: _fetchBargainList(),
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
                  String _thumbnail = order.data()['thumbnail'];
                  bool _isThumbnailLoaded = _thumbnail?.isNotEmpty ?? false;
                  
                  return ListTile(
                    dense: true,
                    leading: SizedBox(
                      width: 50,
                      child: _isThumbnailLoaded
                          ? Image.network(_thumbnail)
                          : Icon(Icons.network_locked),
                    ),
                    trailing: Container(
                      //color: Colors.green[200],
                      child: Text(
                          'Bargain Price: ' + order.data()['bargainPrice'].toString()
                          // + '\nValid Till: ' +
                          // new DateTime().millisecondsSinceEpoch(
                          //     order.data()['validTill'])),
                          ),
                    ),
                    // title: Text(
                    //   'Order Id: ' + order.id.toString(),
                    // ),
                    subtitle: Text(order.data()['productName']),
                    isThreeLine: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BargainPage(order: order),
                        ),
                      );
                    },
                  );
                },
              ).toList(),
            );
          }
        },
      ),
    );
  }

  Stream<QuerySnapshot> _fetchBargainList() {
    try {
      // print(
      //   'inside order fetch. uid: ' + _user.uid.toString(),
      // );
      return FirebaseFirestore.instance
          .collection('customer')
          .doc("XVd5BdS8kOMFbLLFgy2H13CPLir2")
          .collection('myBargainOrder')
          .where(
            'isActive',
            isEqualTo: true,
          )
          //.orderBy('dateInserted', descending: true)
          .snapshots();
    } on Exception catch (e) {
      // handle excp
      print('Order Query Failed.\n' + e.toString());
      return null;
    }
  }
}
