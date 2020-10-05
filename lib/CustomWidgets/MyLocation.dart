import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:negoc8r_customer/Objects/LocationClasses.dart';

class MyLocationList extends StatefulWidget {
  final Location newLocation;
  MyLocationList({Key key, this.newLocation}) : super(key: key);

  @override
  _MyLocationListState createState() => _MyLocationListState();
}

class _MyLocationListState extends State<MyLocationList> {
  @override
  Widget build(BuildContext context) {
    bool isCitySelected = false;
    if (widget.newLocation.city != null) {
      isCitySelected = true;
    } else {
      isCitySelected = false;
    }

    bool isAreaSelected = false;
    if (widget.newLocation.area != null) {
      isAreaSelected = true;
    } else {
      isAreaSelected = false;
    }
    return Container(
      child: Column(
        children: <Widget>[
          //select city
          new FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('refLocation')
                .doc("city")
                .get(),
            //.where("id", isEqualTo: "city")
            //.snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return Text('Waiting');
                  break;
                case ConnectionState.done:
                  if (!snapshot.hasData) {
                    return Text('No data');
                  } else {
                    //fetch city list
                    print("correct ");
                    DocumentSnapshot ds = snapshot.data;
                    List cityList = ds.data()["city"];
                    return DropdownButtonFormField(
                      value: widget.newLocation.city,
                      items: cityList.map((e) {
                        return DropdownMenuItem(
                          child: Text(e.toString()),
                          value: e.toString(),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          print(newVal);
                          widget.newLocation.city = newVal;
                          widget.newLocation.area = null;
                          widget.newLocation.subArea = null;
                        });
                        //getAreaDropdown();
                      },
                    );
                  }
                  break;
                default:
                  print("incorrect");
                  return Text('No city available');
              }
            },
          ),

          //select Area
          Container(
              child: isCitySelected
                  ? new FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('refLocation')
                          .doc(widget.newLocation.city)
                          .get(),
                      //.where("id", isEqualTo: "city")
                      //.snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        //if (_selectedCity != null) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                          case ConnectionState.none:
                            return Text('Waiting');
                            break;
                          case ConnectionState.done:
                            if (!snapshot.hasData) {
                              return Text('No data');
                            } else {
                              //fetch city list
                              print("correct area");
                              DocumentSnapshot ds = snapshot.data;
                              List areaList = ds.data()["area"];
                              if (areaList != null) {
                                return DropdownButtonFormField(
                                  value: widget.newLocation.area,
                                  items: areaList.map((e) {
                                    return DropdownMenuItem(
                                      child: Text(e.toString()),
                                      value: e.toString(),
                                    );
                                  }).toList(),
                                  onChanged: (newVal) {
                                    setState(() {
                                      print(newVal);
                                      widget.newLocation.area = newVal;
                                      widget.newLocation.subArea = null;
                                    });
                                  },
                                );
                              } else {
                                return null;
                              }
                            }

                            break;
                          default:
                            print("incorrect area");
                            return Text('No area available');
                        }
                        // } else {
                        //   return Text('No area available');
                        // }
                      },
                    )
                  : Text('')),

          //subArea
          Container(
            child: isAreaSelected
                ? new FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('refLocation')
                        .doc(widget.newLocation.city)
                        .collection('area')
                        .doc(widget.newLocation.area)
                        .get(),
                    //.where("id", isEqualTo: "city")
                    //.snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      //if (_selectedCity != null) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return Text('Waiting');
                          break;
                        case ConnectionState.done:
                          if (!snapshot.hasData) {
                            return Text('No data');
                          } else {
                            //fetch city list
                            print("correct area");
                            DocumentSnapshot ds = snapshot.data;
                            List subAreaList = ds.data()["subArea"];
                            return DropdownButtonFormField(
                              value: widget.newLocation.subArea,
                              items: subAreaList.map((e) {
                                return DropdownMenuItem(
                                  child: Text(e.toString()),
                                  value: e.toString(),
                                );
                              }).toList(),
                              onChanged: (newVal) {
                                setState(() {
                                  print(newVal);
                                  widget.newLocation.subArea = newVal;
                                  //_selectedSubArea = null;
                                });
                              },
                            );
                          }
                          break;
                        default:
                          print("incorrect area");
                          return Text('No area available');
                      }
                      // } else {
                      //   return Text('No area available');
                      // }
                    },
                  )
                : Text(''),
          ),
        ],
      ),
    );
  }
}
