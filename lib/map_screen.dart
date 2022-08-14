import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:navi_mall_app/location_controller.dart';
import 'package:navi_mall_app/location_search_dialogue.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late CameraPosition _cameraPosition;
  GoogleMapController? _mapController;
  @override
  void initState() {
    super.initState();
    _cameraPosition =
        CameraPosition(target: LatLng(26.215901, 50.668999), zoom: 18);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (locationController) {
        return Scaffold(
          body: Stack(
            children: [
              GoogleMap(
              indoorViewEnabled: true,
                onMapCreated: (GoogleMapController mapController) {
                  mapController = mapController;

                },
                initialCameraPosition: _cameraPosition,
              ),
              Positioned(
                top: 100,
                left: 10,
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    Get.dialog(
                        LocationSearchDialog(mapController: _mapController));
                  },
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 25,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            '${locationController.pickPlaceMark.name ?? ''}'
                            '${locationController.pickPlaceMark.locality ?? ''}'
                            '${locationController.pickPlaceMark.postalCode ?? ''}'
                            '${locationController.pickPlaceMark.country ?? ''}',
                            style: TextStyle(fontSize: 20),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.search,
                          size: 25,
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
