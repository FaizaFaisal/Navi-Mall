// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_is_empty

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navi_mall_app/admin/add_store.dart';
import 'package:navi_mall_app/admin/add_trend.dart';
import 'package:navi_mall_app/admin/view_store.dart';
import 'package:navi_mall_app/colors.dart' as color;

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:navi_mall_app/model_class/service_model_list.dart';
import 'dart:developer' as developer;

class ViewStoresListScreen extends StatefulWidget {
  final String name;
  final String photoURL;

  const ViewStoresListScreen({required this.name, required this.photoURL});

  @override
  State<ViewStoresListScreen> createState() => _ViewStoresListScreenState();
}

class _ViewStoresListScreenState extends State<ViewStoresListScreen> {
  List<service_modelClass>? service_lst;
  User? user = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;
  service_modelClass? _service_modelcalss;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    service_lst = [];
    get_stores_services_lst();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: SizedBox(
        child: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 72, 119, 71),
          hoverColor: Color.fromARGB(255, 77, 165, 75),
          splashColor: Color.fromARGB(255, 66, 124, 65),
          heroTag: 'uniqueTag_1',
          child: Icon(
            Icons.add,
            color: color.AppColor.white,
            size: 34,
          ), //child widget inside this button

          onPressed: () {
            if (kDebugMode) {
              print("Button is pressed.");
            }
            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => AddStoreScreen(
                  mall_name: widget.name,
                ))));
          },
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xffd6ddd8),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Stores & Services",
          style: GoogleFonts.roboto(
            textStyle: Theme.of(context).textTheme.headline5,
            fontSize: 20,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      backgroundColor: color.AppColor.homePageBackground,
      body: service_lst!.length > 0
          ? ListView.builder(
          padding: const EdgeInsets.only(
            top: 20,
            bottom: 10,
            right: 10,
            left: 10,
          ),
          itemCount: service_lst!.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 8.0,
              shadowColor: Color.fromARGB(255, 7, 81, 6).withOpacity(0.4),
              child: ListTile(
                tileColor: color.AppColor.greenshade.withOpacity(0.2),
                leading: Image(
                    width: 60,
                    image: NetworkImage(service_lst![index].photoURL)),
                title: Text(
                  service_lst![index].store_name,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.elliptical(10, 5)),
                          color: Color.fromARGB(255, 7, 81, 6)
                              .withOpacity(0.4),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) => AddTrendScreen(
                                  store: service_lst![index].store_name,
                                  mall: widget.name,
                                ))));
                          },
                          icon: Icon(
                            Icons.trending_up,
                            color: color.AppColor.white,
                          ),
                        ),
                      ),
                      // SizedBox(width: 5),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     borderRadius:
                      //         BorderRadius.all(Radius.elliptical(10, 5)),
                      //     color: Color.fromARGB(255, 7, 81, 6)
                      //         .withOpacity(0.4),
                      //   ),
                      //   child: IconButton(
                      //     onPressed: () {
                      //       Navigator.of(context).push(MaterialPageRoute(
                      //           builder: ((context) => ViewStoreScreen(
                      //                 name: service_lst![index].store_name,
                      //               ))));
                      //     },
                      //     icon: Icon(
                      //       Icons.edit,
                      //       color: color.AppColor.white,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(width: 7.5),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.elliptical(10, 5)),
                          color: Color.fromARGB(255, 7, 81, 6)
                              .withOpacity(0.4),
                        ),
                        child: IconButton(
                          onPressed: () {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.QUESTION,
                              headerAnimationLoop: false,
                              animType: AnimType.TOPSLIDE,
                              title: 'Delete Store?',
                              btnOkColor: Colors.redAccent,
                              btnOkText: 'Delete',
                              btnOkIcon: Icons.delete_outlined,
                              btnCancelColor: Colors.blueGrey.shade700,
                              btnCancelText: 'Cancel',
                              desc:
                              'This will delete the store from the mall',
                              descTextStyle: TextStyle(
                                  color: Colors.blueGrey.shade300,
                                  fontSize: 18),
                              showCloseIcon: true,
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {
                                delete_store(
                                    service_lst![index].store_name);
                              },
                            ).show();
                          },
                          icon: Icon(
                            Icons.delete,
                            color: color.AppColor.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          })
          : Center(
          child: Text(
            "No Data Found ",
            style: TextStyle(fontSize: 16),
          )),
    );
  }

  delete_store(String store) {
    try {
      firestoreInstance
          .collection("malls")
          .doc(widget.name)
          .collection("services")
          .get()
          .then((value) {
        try {
          firestoreInstance
              .collection("malls")
              .doc(widget.name)
              .collection("services")
              .doc(store)
              .delete();
        } catch (e) {
          print(e.toString());
        }
      });
    } catch (e) {
      _displaySnackBar(context, "No data Found");
    }
  }

  get_stores_services_lst() {
    service_lst = [];
    //id = [];
    try {
      firestoreInstance
          .collection("malls")
          .doc(widget.name)
          .collection("services")
          .get()
          .then((value) {
        for (int i = 0; i < value.docs.length; i++) {
          try {
            //id!.add(value.docs[i].id.toString());
            firestoreInstance
                .collection("malls")
                .doc(widget.name)
                .collection("services")
                .doc(value.docs[i].id.toString())
                .get()
                .then((value) {
              Map<String, dynamic>? h = value.data();
              if (h != null) {
                _service_modelcalss = service_modelClass.fromJson(h);

                service_lst!.add(_service_modelcalss!);
              }
            }).whenComplete(() {
              developer
                  .log("my data g       " + service_lst!.length.toString());
              setState(() {});
            });
          } catch (e) {
            print(e.toString());
          }
        }
      });
    } catch (e) {
      _displaySnackBar(context, "No data Found");
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
    _scaffoldKey.currentState!.showSnackBar(snackBar);
  }
}