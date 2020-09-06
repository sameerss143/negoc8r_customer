import 'package:flutter/material.dart';
import 'package:negoc8r_customer/Pages/Customer/AccountHome.dart';
import 'package:negoc8r_customer/services/UserAuth.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            title: Text('Home'),
            onTap: () {
              //open my account and close drawer
              Navigator.pop(context);
              Navigator.pushNamed(context, '/homepage');
/*               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              ); */
            },
          ),
          ListTile(
            title: Text('My Account'),
            onTap: () {
              Navigator.pop(context);
              //open my account and close drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomerAccountHome(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('My Orders'),
            onTap: () {
              //open my orders
              Navigator.pop(context);
              Navigator.pushNamed(context, '/orderpage');
            },
          ),
          ListTile(
            title: Text('Sign Out'),
            onTap: () {
              //sign out of the app
              Navigator.pop(context);
              signOutUser();
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
    );
  }
}
