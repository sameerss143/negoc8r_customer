import 'package:flutter/material.dart';

//Move this page to product catalog.
//this page will have customer dashboard with deals and similar product lists
class HomePage extends StatelessWidget {
  //const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Negoc8r Home'),
      ),
      drawer: Drawer(
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
      ),
      body: (GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 1,
        children: <Widget>[
          Container(
            //color: Colors.blue[200],
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.blue[200],
            ),
            child: IconButton(
              icon: Icon(
                Icons.filter_1,
                color: Colors.black,
                size: 100.0,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/productcatalog');
              },
              //_openProductList(context, 'mobile'),
            ),
          ),
        ],
      )),
    );
  }
}
