import 'package:get/get.dart';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_webservice/places.dart';
import 'package:navi_mall_app/location_service.dart';

class LocationController extends GetxController {
  Placemark _pickPlaceMark = Placemark();
  Placemark get pickPlaceMark => _pickPlaceMark;
  List<Prediction> _predictionList = [];

  Future<List<Prediction>> searchLocation(
      BuildContext context, String text) async {
    if (text != null && text.isNotEmpty) {
      http.Response response = await getLocationData(text);
      var data = jsonDecode(response.body.toString());
      print("my status is" + data["status"]);
      if (data['status'] == 'OK') {
        _predictionList = [];
        data['predictions'].forEach((prediction) =>
            _predictionList.add(Prediction.fromJson(prediction)));
      } else {
        //ApiChecker.checkApi(response);
      }
    }
    return _predictionList;
  }
}
