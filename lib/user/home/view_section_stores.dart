// ignore_for_file: use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navi_mall_app/colors.dart' as color;
import 'package:navi_mall_app/model_class/service_model_list.dart';
import 'dart:developer' as developer;

class ViewSectionStores extends StatefulWidget {
  final String section;
  const ViewSectionStores({required this.section});

  @override
  State<ViewSectionStores> createState() => _ViewSectionStoresState();
}

class _ViewSectionStoresState extends State<ViewSectionStores> {
  service_modelClass? _service_modelcalss;
  List<service_modelClass>? service_lst;
  @override
  void initState() {
    super.initState();
    print(widget.section);
    get_service_search(widget.section);
    service_lst = [];
  }

  final firestoreInstance = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: color.AppColor.homePageBackground,
          elevation: 1,
          centerTitle: true,
          leading: BackButton(
            color: Colors.black87,
            onPressed: () {
              //Navigator.pop(context);
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            "Area of Interest",
            style: GoogleFonts.playfairDisplay(
              textStyle: Theme.of(context).textTheme.headline5,
              fontSize: 25,
              color: Colors.black87,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        backgroundColor: color.AppColor.homePageBackground,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Expanded(
            child: service_lst!.length > 0
                ? ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return getStore(service_lst![index].photoURL,
                          service_lst![index].store_name);
                    })
                : Center(
                    child: Text(
                    "No Data Found ",
                    style: TextStyle(fontSize: 18),
                  )),
          ),
        ));
  }

  getStore(String image, String name) {
    return SizedBox(
      width: 80,
      height: 80,
      child: ListTile(
        leading: Image(width: 70, height: 70, image: AssetImage(image)),
        title: Text(
          name,
          style: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: ElevatedButton(
          onPressed: () {},
          child: Text(
            'View',
            style: GoogleFonts.lato(
              fontSize: 18,
              color: color.AppColor.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
          ),
        ),
      ),
    );
  }

  /// Get  data against title ////////////////////////////////////////////////////////
  Future<String?> get_service_search(String section) async {
    service_lst = [];

    try {
      firestoreInstance.collection("malls").get().then((value) {
        for (int i = 0; i < value.docs.length; i++) {
          try {
            firestoreInstance
                .collection("malls")
                .doc(value.docs[i].id.toString())
                .collection("services")
                .where('section', isEqualTo: section)
                .get()
                .then((v) {
              v.docs.forEach((doc) {
                Map<String, dynamic>? h = doc.data();
                if (h != null) {
                  print(" doc \n");
                  print(h);
                  _service_modelcalss = service_modelClass.fromJson(h);

                  service_lst!.add(_service_modelcalss!);
                }
              });
            }).whenComplete(() {
              developer
                  .log("my data g       " + service_lst!.length.toString());
              setState(() {
                print(service_lst);
              });
            });
          } catch (e) {
            print(e.toString());
          }
        }
      });
    } catch (e) {
      _displaySnackBar(context, "No Business Found");
    }
  }

  /// Show Snackbar ////////////////////////////////////////////////////////////////
  _displaySnackBar(BuildContext context, String msg) {
    final snackBar = SnackBar(
      backgroundColor: Colors.black,
      content: new Text(
        msg,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
      duration: Duration(seconds: 7),
    );
    var _scaffoldKey;
    _scaffoldKey.currentState!.showSnackBar(snackBar);
  }
}
