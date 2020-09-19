import 'package:flutter/material.dart';
import 'package:negoc8r_customer/CustomWidgets/AppDrawer.dart';
import 'package:negoc8r_customer/Pages/ProductCatalog/ProductListPage.dart';
//import 'package:negoc8r_customer/Pages/ProductList.dart';

class ProductCatalog extends StatelessWidget {
  const ProductCatalog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      /*      drawer: Drawer(
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
      appBar: AppBar(
        title: Text('Negotiator Home Page'),
      ),
      body: (GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          Container(
            //color: Colors.blue[200],
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.blue[200],
            ),
            child: IconButton(
              tooltip: 'Mobile & Accessories',
              icon: Icon(
                Icons.phone_android,
                color: Colors.black,
                size: 100.0,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductListPage(
                      productCategory: "Mobile & Accessories",
                    ),
                  ),
                );
                // Navigator.pushNamed(
                //   context,
                //   '/productlist',
                //   arguments: <String>{
                //     'Mobile & Accessories',
                //   },
                // );
              },
              //_openProductList(context, 'mobile'),
            ),
          ),

          /*
              IconButton(
              icon: Icon(Icons.phone), 
              onPressed: (){}),),
            ),
            padding: const EdgeInsets.all(8),
            const Text('Mobile'),
            color: Colors.teal[100],
            decoration: BoxDecoration(
              //border: Border.all(),
              color: Colors.blue[200],
              borderRadius: BorderRadius.circular(10),
               boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.33),
                  spreadRadius: 3,
                  blurRadius: 6,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ], */
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.blue[200],
            ),
            child: IconButton(
              tooltip: 'PC & Laptop',
              icon: Icon(
                Icons.laptop,
                color: Colors.black,
                size: 100.0,
              ),
              //onPressed: _openProductList(context, 'laptop'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductListPage(
                      productCategory: 'PC & Laptop',
                    ),
                  ),
                );
                // Navigator.pushNamed(
                //   context,
                //   '/productlist',
                //   arguments: <String, String>{
                //     'productCategory': 'PC & Laptop',
                //   },
                // );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.blue[200],
            ),
            child: IconButton(
                tooltip: 'Electronics',
                icon: Icon(
                  Icons.devices,
                  color: Colors.black,
                  size: 100.0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductListPage(
                        productCategory: 'Electronics',
                      ),
                    ),
                  );
                }),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.blue[200],
            ),
            child: IconButton(
              icon: Icon(
                Icons.camera,
                color: Colors.black,
                size: 100.0,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductListPage(
                      productCategory: 'Camera & Accessories',
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.blue[200],
            ),
            child: IconButton(
                tooltip: 'Home and Kitchen Appliances',
                icon: Icon(
                  Icons.add_shopping_cart,
                  color: Colors.black,
                  size: 100.0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductListPage(
                        productCategory: 'Home & Kitchen Appliances',
                      ),
                    ),
                  );
                }),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.blue[200],
            ),
            child: IconButton(
                icon: Icon(
                  Icons.shopping_basket,
                  color: Colors.black,
                  size: 100.0,
                ),
                onPressed: () {}),
          ),
        ],
      )),
    );
  }

/*   _openProductList(BuildContext context, String productType) {
    if (productType == 'mobile') {
      try {
        Navigator.pushNamed(context, '/productlist');
      } catch (e) {
        print(e.toString());
      }
      {}
    } else {
      if (productType == 'laptop') {
        try {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProductList()));
        } catch (e) {
          print(e.toString());
        }
      }
    }
  } */
}
