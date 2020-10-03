//import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:negoc8r_customer/CustomWidgets/AppDrawer.dart';

//Move this page to product catalog.
//this page will have customer dashboard with deals and similar product lists
class HomePage extends StatelessWidget {
  //const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Negoc8r Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications,
              //size: 10.0,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/notificationpage');
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
/*       drawer: Drawer(
        child: ListView(
          //padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              color: Colors.blue[300],
              height: 60.0,
              child: DrawerHeader(
                //padding: EdgeInsets.fromLTRB(10, 10, 2, 2),
                //margin: EdgeInsets.fromLTRB(0, 0, 0, 0), //, top, right, bottom),
                child: Text(
                  'Menu',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
                //child: BackButton(),
              ),
            ),

            //add Greeting, user first name, user thumbnail
            ListTile(
              title: Text('My Account'),
              onTap: () {
                //open my account and close drawer
                Navigator.pushNamed(context, 'productcatalog');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('My Orders'),
              onTap: () {
                //open my orders
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Sign Out'),
              onTap: () {
                //sign out of the app
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Help'),
              onTap: () {
                //open help page
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                //open About page
                Navigator.pop(context);
              },
            )
          ],
        ),
      ), */
      body: GridView.count(
        padding: const EdgeInsets.all(10.0),
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        crossAxisCount: 2,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.blue[100],
            ),
            // width: 200.0,
            // height: 200.0,
            //alignment: Alignment.bottomCenter,
            //color: Colors.blue[200],
            child: FlatButton(
              padding: EdgeInsets.all(20.0),
              onPressed: () {
                Navigator.pushNamed(context, '/productcatalog');
              },
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.account_tree,
                    size: 100.0,
                    //color: Colors.grey[300],
                  ),
                  Text(
                    'Product Catalog',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.blue[100],
            ),
            // width: 200.0,
            // height: 200.0,
            //alignment: Alignment.bottomCenter,
            //color: Colors.blue[200],
            child: FlatButton(
              padding: EdgeInsets.all(20.0),
              onPressed: () {
                //Navigator.pushNamed(context, '/productcatalog');
              },
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.disc_full,
                    size: 100.0,
                  ),
                  Text(
                    'Best Deals',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      //new GridView.custom(gridDelegate: null, childrenDelegate: null),
      // Column(
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   //crossAxisAlignment: CrossAxisAlignment.start,
      //   children: <Widget>[
      //     Container(
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(10.0),
      //         color: Colors.blue[100],
      //       ),
      //       // width: 50.0,
      //       // height: 50.0,
      //       child: Container(
      //         // height: 50,
      //         // width: 100,
      //         child: CarouselSlider(
      //           options: CarouselOptions(
      //             //height: 50.0,
      //             autoPlay: true,
      //             autoPlayAnimationDuration: Duration(
      //               milliseconds: 500,
      //             ),
      //           ),
      //           items: <Widget>[
      //             Icon(
      //               Icons.accessibility_new,
      //               size: 50.0,
      //             ),
      //             IconButton(
      //               icon: Icon(
      //                 Icons.ac_unit,
      //                 size: 50.0,
      //               ),
      //               onPressed: () {},
      //             ),
      //             Icon(
      //               Icons.airline_seat_flat,
      //               size: 50.0,
      //             ),
      //             Icon(
      //               Icons.add_alarm,
      //               size: 50.0,
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //     GridView.count(
      //       primary: false,
      //       padding: const EdgeInsets.all(15.0),
      //       crossAxisSpacing: 10,
      //       mainAxisSpacing: 10,
      //       crossAxisCount: 2,
      //       children: <Widget>[
      //         Container(
      //           //color: Colors.blue[200],
      //           // width: 100.0,
      //           // height: 50.0,
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(10.0),
      //             color: Colors.blue[200],
      //           ),
      //           child: IconButton(
      //             icon: Icon(
      //               Icons.filter_1,
      //               color: Colors.black,
      //               size: 50.0,
      //             ),
      //             onPressed: () {
      //               Navigator.pushNamed(context, '/productcatalog');
      //             },
      //             //_openProductList(context, 'mobile'),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
    );
  }
}
