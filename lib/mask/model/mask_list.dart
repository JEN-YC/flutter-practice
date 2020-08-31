import 'package:google_maps_flutter/google_maps_flutter.dart';

class MaskList {
  List<Mask> _results = [];
  MaskList.fromJson(Map<String, dynamic> parsedJson, String city) {
    List<Mask> temp = [];
    for (int i = 0; i < parsedJson['features'].length; i++) {
      Mask item = Mask(parsedJson['features'][i]);
      if (item.address.contains(city)) temp.add(item);
    }
    _results = temp;
  }
  List<Mask> get results => _results;
}

class Mask {
  String name;
  String address;
  String id;
  String phone;
  String updateTime;
  int adultMask;
  int childMask;
  double latitude;
  double longitude;
  Marker marker;
  Mask(result) {
    name = result['properties']['name'].toString();
    address = result['properties']['address'];
    id = result['properties']['id'];
    phone = result['properties']['phone'];
    adultMask = result['properties']['mask_adult'];
    childMask = result['properties']['mask_child'];
    updateTime = result['properties']['updated'];
    latitude = result['geometry']['coordinates'][1];
    longitude = result['geometry']['coordinates'][0];
  }

  @override
  String toString() {
    return ''''$id, $name, $address''';
  }
}
