// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:navi_mall_app/map_screen.dart';
import 'package:get/get.dart';
import '../../location_controller.dart';

class ViewMap extends StatefulWidget {
  const ViewMap({Key? key}) : super(key: key);

  @override
  State<ViewMap> createState() => _ViewMapState();
}

class _ViewMapState extends State<ViewMap> {
  @override
  Widget build(BuildContext context) {
    Get.put(LocationController());
    return MapScreen();
  }
}
