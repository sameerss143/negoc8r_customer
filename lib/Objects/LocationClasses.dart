// @JsonSerializable()
// class City {
//   City(this.id, this.name);
//   final int id;
//   final String name;
//   factory City.fromJson(Map<int, String> json) => _$CityFromJson(json);
//   Map<int, String> toJson() => _$CityToJson(this);
// }
// @JsonSerializable()
// class CityOld {
//   CityOld(this.id, this.name);
//   final int id;
//   final String name;

//   // named constructor
//   CityOld.fromJson(Map<String, dynamic> json)
//       : id = json['id'],
//         name = json['name'];
//   // method
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//     };
//   }
// }

// class AreaOld {
//   int id;
//   String name;
// }
class Location {
  String city;
  String area;
  String subArea;

  Location({this.city, this.area, this.subArea});

  void setData({String city, String area, String subArea}) {
    this.city = city;
    this.area = area;
    this.subArea = subArea;
  }

  String getLocationText() {
    if (this.city != null && this.area != null && this.subArea != null) {
      return '${this.city} > ${this.area} > ${this.subArea}';
    } else {
      return 'Please Select Location.';
    }
  }
}
