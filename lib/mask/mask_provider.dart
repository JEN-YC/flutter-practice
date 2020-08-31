import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/mask/model/mask_list.dart';

class MaskProvider {
  final Client _client;
  final _url =
      'https://raw.githubusercontent.com/kiang/pharmacies/master/json/points.json';
  MaskProvider({Client client}) : _client = client ?? Client();

  Future<MaskList> fetchMaskData(String city) async {
    final response = await _client.get(_url);
    if (response.statusCode == 200) {
      return MaskList.fromJson(json.decode(response.body), city);
    } else {
      throw Exception('Failed to get mask data');
    }
  }
}
