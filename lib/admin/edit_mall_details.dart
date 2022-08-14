// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navi_mall_app/colors.dart' as color;
import 'package:navi_mall_app/admin/view_mall.dart';
import 'package:navi_mall_app/admin/view_stores_list.dart';

class EditMallDetailsScreen extends StatefulWidget {
  final String photoURL;
  final String name;

  const EditMallDetailsScreen({required this.photoURL, required this.name});

  @override
  State<EditMallDetailsScreen> createState() => _EditMallDetailsScreenState();
}

class _EditMallDetailsScreenState extends State<EditMallDetailsScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic documents = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firestoreInstance.collection('malls').get().then((myDocuments) {
      print("${myDocuments.docs.length}");
      setState(() {
        documents = "${myDocuments.docs.length}";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffd6ddd8),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Edit",
          style: GoogleFonts.roboto(
            textStyle: Theme.of(context).textTheme.headline5,
            fontSize: 25,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Container(
        padding:
        const EdgeInsets.only(top: 20, bottom: 20, left: 12, right: 12),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              CircleAvatar(
                maxRadius: 160,
                backgroundColor: Color.fromARGB(0, 171, 36, 36),
                child: Image.network(
                  widget.photoURL,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 20),
              Text(
                widget.name,
                style: GoogleFonts.roboto(
                    fontSize: 23, fontWeight: FontWeight.w500),
              ),
              Text(
                'No.of Stores and Services : ' + documents,
                style: GoogleFonts.roboto(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20),
              // ElevatedButton.icon(
              //   onPressed: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: ((context) => ViewMallScreen(
              //               mall: widget.name,
              //               photoURL: widget.photoURL,
              //             ))));
              //   },
              //   icon: Icon(
              //     Icons.edit,
              //     color: color.AppColor.white,
              //   ),
              //   label: Text(
              //     'Mall Info',
              //     style: GoogleFonts.roboto(
              //         color: color.AppColor.white,
              //         fontSize: 22,
              //         fontWeight: FontWeight.w600),
              //   ),
              //   style: ElevatedButton.styleFrom(
              //     fixedSize: Size(265, 55),
              //   ),
              // ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => ViewStoresListScreen(
                          name: widget.name, photoURL: widget.photoURL)),
                    ),
                  );
                },
                icon: Icon(
                  Icons.edit,
                  color: color.AppColor.white,
                ),
                label: Text(
                  'Stores and Services',
                  style: GoogleFonts.roboto(
                      color: color.AppColor.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(265, 55),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}