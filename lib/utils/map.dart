import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geocoding/geocoding.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import 'package:location/location.dart' as loc;

import 'package:navi_mall_app/colors.dart';
import 'package:navi_mall_app/utils/contants.dart';

class CurrentLocationScreen extends StatefulWidget {
  double? lat;
  double? lng;
  bool? isFromEdit;

  CurrentLocationScreen({this.lat, this.lng, this.isFromEdit = false});

  @override
  _CurrentLocationScreenState createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  LatLng? test;

  CameraPosition initialLocation =
      const CameraPosition(target: LatLng(0.0, 0.0));
  Completer<GoogleMapController> mapController = Completer();
  GoogleMapsPlaces places =
      GoogleMapsPlaces(apiKey: AppConstants.google_api_key);

  _onMapCreated(GoogleMapController controller) {
    mapController.complete(controller);
    getCurrentLocation();
  }

  TextEditingController searchTextController = TextEditingController();
  List<Marker> myMarker = [];

  addMarkerFunc(LatLng tappedPoint) async {
    getLocAddress(tappedPoint);
    myMarker = [];
    myMarker.add(Marker(
        markerId: MarkerId(tappedPoint.toString()), position: tappedPoint));
    setState(() {test = tappedPoint;});
  }

  Future<void> getLocAddress(LatLng latlng) async {
    print("my latlng here");
    print("${latlng.latitude}");
    print("${latlng.longitude}");

    final coordinates = Coordinates(latlng.latitude, latlng.latitude);
    var addresses = await Geocoder.google(AppConstants.google_api_key)
        .findAddressesFromCoordinates(coordinates);
    var add = addresses.first;
    searchTextController.text = addresses.first.addressLine!;
    AppConstants.address = searchTextController.text;
    AppConstants.lat = latlng.latitude;
    AppConstants.lng = latlng.longitude;

    setState(() {});
    print("uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu");
    print(addresses.first.addressLine);
  }

  //for place prediction
  Future<void> placePickerFunc() async {
    Prediction? p = await PlacesAutocomplete.show(
      radius: 1000,
      strictbounds: false,
      language: "en",
      context: context,
      onError: (e) {},
      types: [],
      mode: Mode.overlay,
      apiKey: AppConstants.google_api_key,
      components: [
        // Component(Component.country, "se"),
      ],
      hint: "Search City",
    );
    p = await displayPrediction(p!);
  }

  // place Predictor error function
  /*void onError(PlacesAutocompleteResponse response) {
    errorSnackbar(
      "error",
      response.errorMessage,
    );
  }*/

  // convert prediction latlng to address
  Future<Prediction> displayPrediction(
    Prediction prediction,
  ) async {
    if (prediction != null) {
      PlacesDetailsResponse detail =
          await places.getDetailsByPlaceId(prediction.placeId!);
      final lat = detail.result.geometry!.location.lat;
      final lng = detail.result.geometry!.location.lng;
      var cont = await mapController.future;

      cont.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(lat, lng),
            zoom: 15.0,
          ),
        ),
      );
      addMarkerFunc(LatLng(lat, lng));
    }
    return prediction;
  }

  loc.Location location = loc.Location();
  Future getCurrentLocation() async {
    if (widget.isFromEdit!) {
      print("i am from edit");
      var cont = await mapController.future;
      await cont.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(widget.lat!, widget.lng!),
            zoom: 15.0,
          ),
        ),
      );
      setState(() {});
      await addMarkerFunc(LatLng(widget.lat!, widget.lng!));
    } else {
      print("i am from my location");
      await location.getLocation().then((position) async {
        await getLocAddress(LatLng(position.latitude!, position.longitude!));
        var cont = await mapController.future;
        await cont.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude!, position.longitude!),
              zoom: 15.0,
            ),
          ),
        );
        setState(() {});
        await addMarkerFunc(LatLng(position.latitude!, position.longitude!));
      }).catchError((e) {
        print("ERROR While get user location");
        print(e);
      });
    }
  }

  Future getCurrentLatlng() async {
    print("i am from my location");
    await location.getLocation().then((position) async {
      await getLocAddress(LatLng(position.latitude!, position.longitude!));
      var cont = await mapController.future;
      await cont.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude!, position.longitude!),
            zoom: 15.0,
          ),
        ),
      );
      setState(() {});
      await addMarkerFunc(LatLng(position.latitude!, position.longitude!));
    }).catchError((e) {
      print(e);
    });
  }

  // add marker function

  @override
  void initState() {
    super.initState();
    onInit();
  }

  onInit() async {
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 2,
                      color: Colors.grey.withOpacity(.20))
                ],
                color: const Color(0xffd6ddd8),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            child: _locationSearchFormField(),
          )),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: initialLocation,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            onMapCreated: _onMapCreated,
            markers: Set.from(myMarker),
            onTap: addMarkerFunc,
          ),
          Positioned(
            bottom: 5,
            right: 10,
            left: 10,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * .15, vertical: 25),
              child: Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: Get.height * 0.02),
                        child: Text(
                          "save",
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    // Get.back(result: [
                    //   {"Lat": "", "Lng": ""}
                    // ]);

                    Navigator.pop(context, test);
                    /* LocationModel locationModel = LocationModel(
                        address: myAddress,
                        lat: currentLat,
                        lng: currentLng,
                      );
                      Get.back(result: locationModel);*/
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _locationSearchFormField() {
    return Container(
        color: const Color(0xffd6ddd8),
        margin: EdgeInsets.only(
            left: Get.width * .01, right: Get.width * .04, top: 40, bottom: 20),
        child: Row(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              width: Get.width * .15,
              child: MaterialButton(
                shape: const CircleBorder(),
                onPressed: () {
                  Get.back();
                },
                child: const Center(
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    color: Colors.blue,
                    size: 25,
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                readOnly: true,
                controller: searchTextController,
                onChanged: (val) {
                  setState(() {});
                },
                onTap: () {
                  placePickerFunc();
                },
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "Search here",
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.red,
                  ),
                  suffixIcon: searchTextController.text.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              searchTextController.clear();
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 11),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 1.2,
                                color: Colors.blue,
                              ),
                            ),
                            child: Icon(
                              Icons.clear,
                              color: Colors.blue,
                              size: 13,
                            ),
                          ),
                        )
                      : const SizedBox(),
                  fillColor: const Color(0xffF7F8FB),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 5),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(color: Color(0xffF3F4F7)),
                  ),
                  disabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(color: Color(0xffF3F4F7)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(color: Color(0xffF3F4F7)),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    getCurrentLatlng();
                  });
                },
                child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        color: const Color(0xffEEF1F3),
                        border: Border.all(color: const Color(0xffE3E8EF)),
                        borderRadius: BorderRadius.circular(4)),
                    child: Icon(
                      Icons.gps_fixed,
                      size: 32,
                      color: Colors.blue,
                    )))
          ],
        ));
  }
}
