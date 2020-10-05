//import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;

class CustomerLocation extends StatefulWidget {
  // final String _locationFileURL =
  //     'https://firebasestorage.googleapis.com/v0/b/negoc8r-dev.appspot.com/o/Reference%2FLocations%2Flocations.json?alt=media&token=137b5af3-4322-4a03-bc44-f79f0d521e65';

  //var _jsonFile;

  CustomerLocation({Key key}) : super(key: key);

  @override
  _CustomerLocationState createState() => _CustomerLocationState();
}

class _CustomerLocationState extends State<CustomerLocation> {
  String _selectedCity;
  String _selectedArea;
  String _selectedSubArea;

  // var _jsonFile;
  List data = List();

  @override
  void initState() {
    //_readLocationJson();
    super.initState();
    _selectedCity = null;
    _selectedArea = null;
    _selectedSubArea = null;
  }

  // _readLocationJson() async {
  //   var response = await http.get(widget._locationFileURL);
  //   //print(response.toString());
  //   //Timer.periodic(Duration(seconds: 1), (timer) {
  //   _jsonFile = json.decode(response.body);
  //   //print(_jsonFile.toString());
  //   //});
  //   data = _jsonFile;
  //   //print('number of cities: ${data.length} \t City: ${data[0]["city"]}');

  //   //data.map((e) => {print(e["city"])});

  //   //print(_jsonFile.toString());
  //   // for (var city in _jsonFile) {
  //   //   //var area = city['area'];
  //   //   print(
  //   //     '#' + city['id'].toString() + city['city'],
  //   //   );
  //   //   for (var area in city['area']) {
  //   //     print('## ' + area['name']);
  //   //     for (var subArea in area['subArea']) {
  //   //       print('### ' + subArea['name']);
  //   //     }
  //   //   }

  //   //print('#' + city.toString());

  //   // for (city['area'] in city) {
  //   // print('#' + area['id'].toString() + area['name']);
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    //final json = JsonDecoder().convert(data);
    //var jsonObj = _readJsonFile();

    //_city = (jsonObj).map<City>((item) => City.fromJson(item)).toList();
    //_selectedCity = _city[0].name;
    //List _jsonFile = _readLocationJson();

    User _user = FirebaseAuth.instance.currentUser;

    bool isCitySelected = false;
    if (_selectedCity != null) {
      isCitySelected = true;
    } else {
      isCitySelected = false;
    }

    bool isAreaSelected = false;
    if (_selectedArea != null) {
      isAreaSelected = true;
    } else {
      isAreaSelected = false;
    }

    return Scaffold(
      appBar: new AppBar(
        title: Text('Set Location'),
      ),
      body: Form(
        child: Column(
          children: [
            //get city list
            // new DropdownButton(
            //   hint: Text('Select City'),
            //   value: _selectedCity,
            //   // items: data.map((item) {
            //   //   return new DropdownMenuItem(
            //   //     child: new Text(item["city"]),
            //   //     value: item["city"],
            //   //   );
            //   // }).toList(),
            //   items: () => _getCityList(),
            //   // LocationItems.getCitiies();
            //   // _city.map(
            //   //   (City map) {
            //   //     return new DropdownMenuItem<String>(
            //   //       value: map.name,
            //   //       child: new Text(map.name,
            //   //           style: new TextStyle(color: Colors.black)),
            //   //     );
            //   //   },
            //   // ).toList(),
            //   onChanged: (newVal) {
            //     setState(() {
            //       _selectedCity = newVal;
            //     });
            //   },
            // ),

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
                        value: _selectedCity,
                        items: cityList.map((e) {
                          return DropdownMenuItem(
                            child: Text(e.toString()),
                            value: e.toString(),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          setState(() {
                            print(newVal);
                            _selectedCity = newVal;
                            _selectedArea = null;
                            _selectedSubArea = null;
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
                          .doc(_selectedCity)
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
                                  value: _selectedArea,
                                  items: areaList.map((e) {
                                    return DropdownMenuItem(
                                      child: Text(e.toString()),
                                      value: e.toString(),
                                    );
                                  }).toList(),
                                  onChanged: (newVal) {
                                    setState(() {
                                      print(newVal);
                                      _selectedArea = newVal;
                                      _selectedSubArea = null;
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
                  : Text(''),
            ),

            //subArea
            Container(
              child: isAreaSelected
                  ? new FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('refLocation')
                          .doc(_selectedCity)
                          .collection('area')
                          .doc(_selectedArea)
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
                                value: _selectedSubArea,
                                items: subAreaList.map((e) {
                                  return DropdownMenuItem(
                                    child: Text(e.toString()),
                                    value: e.toString(),
                                  );
                                }).toList(),
                                onChanged: (newVal) {
                                  setState(() {
                                    print(newVal);
                                    _selectedSubArea = newVal;
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

            //Areas in city selected

            //   return DropdownButtonFormField(
            //     items: null,
            //     onChanged: (value) {},
            //   );
            // }),
            // new StreamBuilder<QueryDocumentSnapshot>(
            //   stream: FirebaseFirestore.instance
            //       .collection('refLocation')
            //       .doc("city")
            //       .snapshots(),
            //   builder: (context, snapshot) {
            //     //fill dropdown items
            //     if (!snapshot.hasData) {
            //       return Text('Data Loading');
            //     } else {
            //       //create list
            //       //List<DropdownMenuItem> cityList = [];

            //       DocumentSnapshot cityObj = snapshot.data;
            //       List<String> cityListString = cityObj.data()["city"];

            //       for (String city in cityListString) {
            //         print(city);
            //       }

            //       if (cityListString != null) {
            //         return DropdownButtonFormField(
            //           items: cityListString.map(
            //             (String e) {
            //               return DropdownMenuItem(
            //                 child: Text(e),
            //                 value: e,
            //               );
            //             },
            //           ).toList(),
            //           onChanged: (newVal) {
            //             setState(() {
            //               _selectedCity = newVal;
            //             });
            //           },
            //         );
            //       } else {
            //         return Text("No city");
            //       }
            //     }
            //   },
            // ),
            RaisedButton(
              child: Text(
                'Update Location',
              ),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('customer')
                    .doc(_user.uid)
                    .collection('myLocation')
                    .doc('currentLocation')
                    .set(
                  {
                    "city": _selectedCity,
                    "area": _selectedArea,
                    "subArea": _selectedSubArea,
                  },
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  getAreaDropdown() {
    //print('in area dropdown $_selectedCity');
    if (_selectedCity != null) {
      new FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('refLocation')
            .doc(_selectedCity)
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
                return DropdownButtonFormField(
                  value: _selectedCity,
                  items: areaList.map((e) {
                    return DropdownMenuItem(
                      child: Text(e.toString()),
                      value: e.toString(),
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    setState(() {
                      print(newVal);
                      _selectedArea = newVal;
                      _selectedSubArea = null;
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
      );
    }
  }

  // Future<List<DropdownMenuItem<String>>> _getCityList() async {
  //   print("in city list");
  //   // int length = data.length;
  //   // print("$length");
  //   // List<DropdownMenuItem> cityList;
  //   // for (int i = 0; i < length; i++) {
  //   //   cityList[i] = new DropdownMenuItem(
  //   //     value: data[i]["city"],
  //   //     child: Text(data[i]["city"]),
  //   //   );
  //   // }
  //   DocumentSnapshot city = await FirebaseFirestore.instance
  //       .collection('/refLocation/city')
  //       .doc('city')
  //       .get()
  //       .then((value) => null);

  //   if (city != null) {
  //     List<String> cityList = city.data()["city"];
  //     return cityList.map((e) {
  //       return DropdownMenuItem(
  //         child: Text(e),
  //         value: e,
  //       );
  //     }).toList();
  //   } else {
  //     return null;
  //   }
  // }
  //return cityList;
  //List<String> cityList = [];
  //print('in city list');

  //fetch city list from json

  //print(response.toString());
  //var _jsonFile = json.decode(response.body);
  //var _jsonObj = JsonDecoder().convert(_jsonFile);

  //print(widget._jsonFile['city'].toString());
  //return widget._jsonFile['city'];
  //_city = (_jsonFile).map<var>((item) => Region.fromJson(item)).toList();
  //List<DropdownMenuItem<dynamic>> itemCityList = [];
  // int i = 0;
  // for (var city in widget._jsonFile['city']) {
  //   print(city.toString());
  //   itemCityList[i] = new DropdownMenuItem(
  //     child: Text(city),
  //     value: city.toString(),
  //   );
  //   i++;
  // }

  //return itemCityList;
  // return widget._jsonFile['city']
  //     .map(
  //       (e) => DropdownMenuItem(
  //         child: Text(
  //           e['city'].toString(),
  //         ),
  //         value: e['city'].toString(),
  //       ),
  //     )
  //     .toList();
  // Future<List<String>> _getCityList() {
  //   DocumentSnapshot cityObj =
  //       FirebaseFirestore.instance.collection('refLocation').doc("city");

  //   return cityObj.data()["city"];
  // }

  // _getCityListQuery() {
  //   return FirebaseFirestore.instance
  //       .collection('refLocation')
  //       .doc('city')
  //       .get();
  // }
}
