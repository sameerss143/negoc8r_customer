// @JsonSerializable()
// class City {
//   City(this.id, this.name);
//   final int id;
//   final String name;
//   factory City.fromJson(Map<int, String> json) => _$CityFromJson(json);
//   Map<int, String> toJson() => _$CityToJson(this);
// }
// @JsonSerializable()
class City {
  City(this.id, this.name);
  final int id;
  final String name;

  // named constructor
  City.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];
  // method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Area {
  int id;
  String name;
}
