// ignore_for_file: unnecessary_const, prefer_const_constructors, prefer_final_fields, unused_field, prefer_collection_literals, unused_element

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:navi_mall_app/admin/location_service.dart';

class OpenLocationPickerScreen extends StatefulWidget {
  const OpenLocationPickerScreen({Key? key}) : super(key: key);

  @override
  State<OpenLocationPickerScreen> createState() =>
      _OpenLocationPickerScreenState();
}

class _OpenLocationPickerScreenState extends State<OpenLocationPickerScreen> {
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController _originController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();

  Set<Marker> _markers = Set<Marker>();
  Set<Polygon> _polygons = Set<Polygon>();
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polygonLatLngs = <LatLng>[];

  int _polygonIdCounter = 1;
  int _polylineIdCounter = 1;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(26.2341, 50.6520),
    zoom: 14.4746,
  );
  @override
  void initState() {
    super.initState();
    _setMarker(LatLng(26.2341, 50.6520));
  }

  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('marker'),
          position: point,
        ),
      );
    });
  }

  void _setPolygon() {
    final String polygonIdVal = 'polygon_$_polygonIdCounter';
    _polygonIdCounter++;

    _polygons.add(
      Polygon(
        polygonId: PolygonId(polygonIdVal),
        points: polygonLatLngs,
        strokeWidth: 2,
        fillColor: Colors.transparent,
      ),
    );
  }

  void _setPolyline(List<PointLatLng> points) {
    final String polylineIdVal = 'polyline_$_polylineIdCounter';
    _polylineIdCounter++;

    _polylines.add(
      Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 2,
        color: Colors.blue,
        points: points
            .map(
              (point) => LatLng(point.latitude, point.longitude),
            )
            .toList(),
      ),
    );
  }

  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(26.1336, 50.5379),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  // static final Marker _kGooglePlexMarker = Marker(
  //   markerId: MarkerId('_KGooglePlex'),
  //   infoWindow: InfoWindow(title: 'Google Plex'),
  //   icon: BitmapDescriptor.defaultMarker,
  //   position: LatLng(26.2341, 50.6520),
  // );

  // static final Marker _kLakeMarker = Marker(
  //   markerId: MarkerId('_KLake'),
  //   infoWindow: InfoWindow(title: 'Lake'),
  //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  //   position: LatLng(26.1336, 50.5379),
  // );

  // static final Polyline _kPolyline = Polyline(
  //     polylineId: PolylineId('_kLine'),
  //     // ignore: prefer_const_literals_to_create_immutables
  //     points: [
  //       LatLng(26.2341, 50.6520),
  //       LatLng(26.1336, 50.5379),
  //     ],
  //     width: 1,
  //     color: Colors.amberAccent);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _originController,
                      decoration: InputDecoration(hintText: ' Origin'),
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                    TextFormField(
                      controller: _destinationController,
                      decoration: InputDecoration(hintText: ' Destination'),
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () async {
                  var directions = await LocationService().getDirections(
                    _originController.text,
                    _destinationController.text,
                  );
                  _goToPlace(
                    directions['start_location']['lat'],
                    directions['start_location']['lng'],
                    directions['bounds_ne'],
                    directions['bounds_sw'],
                  );

                  _setPolyline(directions['polyline_decoded']);
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              markers: _markers,
              polygons: _polygons,
              polylines: _polylines,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: (point) {
                setState(() {
                  polygonLatLngs.add(point);
                  _setPolygon();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToPlace(
    // Map<String, dynamic> place,
    double lat,
    double lng,
    Map<String, dynamic> boundsNe,
    Map<String, dynamic> boundsSw,
  ) async {
    // final double lat = place['geometry']['location']['lat'];
    // final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12),
      ),
    );

    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
            northeast: LatLng(boundsNe['lat'], boundsNe['lng']),
          ),
          25),
    );
    _setMarker(LatLng(lat, lng));
  }
}
