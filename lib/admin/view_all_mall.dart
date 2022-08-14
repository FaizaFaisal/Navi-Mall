// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navi_mall_app/admin/add_mall.dart';
import 'package:navi_mall_app/colors.dart' as color;
import 'package:navi_mall_app/admin/edit_mall_details.dart';
import 'package:navi_mall_app/login.dart';
import 'package:navi_mall_app/model_class/mall_model_list.dart';
import 'package:navi_mall_app/services/user_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'dart:developer' as developer;

class ViewAllMallScreen extends StatefulWidget {
  const ViewAllMallScreen({Key? key}) : super(key: key);

  @override
  State<ViewAllMallScreen> createState() => _ViewAllMallScreenState();
}

class _ViewAllMallScreenState extends State<ViewAllMallScreen> {
  var name = "";
  User? user = FirebaseAuth.instance.currentUser;

  List<mall_modelClass>? mall_lst;
  final firestoreInstance = FirebaseFirestore.instance;

  mall_modelClass? _mall_modelcalss;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      var fields = value.data();
      setState(() {
        name = fields!['name'];

        print(name);
      });
    });

    mall_lst = [];
    get_malls();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 72, 119, 71),
        hoverColor: Color.fromARGB(255, 77, 165, 75),
        splashColor: Color.fromARGB(255, 66, 124, 65),
        heroTag: 'uniqueTag',
        child: Icon(
          Icons.add,
          color: color.AppColor.white,
          size: 34,
        ), //child widget inside this button

        onPressed: () {
          if (kDebugMode) {
            print("Button is pressed.");
          }
          Navigator.of(context)
              .push(MaterialPageRoute(builder: ((context) => AddMallScreen())));
        },
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xffd6ddd8),
        elevation: 0,
        centerTitle: false,
        title: Text(
          "Welcome," + name,
          style: GoogleFonts.roboto(
            textStyle: Theme.of(context).textTheme.headline5,
            fontSize: 20,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              UserService(user!.uid).logout();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (Route<dynamic> route) => route.isFirst);
            },
            icon: Icon(Icons.logout),
            color: color.AppColor.white,
          ),
        ],
      ),
      backgroundColor: color.AppColor.homePageBackground,
      body: mall_lst!.length > 0
          ? ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: mall_lst!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => EditMallDetailsScreen(
                              photoURL: mall_lst![index].photoURL,
                              name: mall_lst![index].name,
                            ))));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 70,
                      width: double.infinity,
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(61, 124, 152, 126),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                color: Colors.white,
                                child: Image(
                                  width: 100,
                                  image:
                                      NetworkImage(mall_lst![index].photoURL),
                                ),
                              ),
                              SizedBox(width: 24),
                              Text(
                                mall_lst![index].name,
                                style: GoogleFonts.lato(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 100),
                              IconButton(
                                onPressed: () async {
                                  final number = mall_lst![index].phone;
                                  launchUrlString('tel://$number');
                                },
                                icon: Icon(
                                  FontAwesomeIcons.phone,
                                  color: Color.fromARGB(255, 7, 81, 6)
                                      .withOpacity(0.4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              })
          : Center(
              child: Text(
              "No Data Found ",
              style: TextStyle(fontSize: 18),
            )),
    );
  }

  /// Get applied user ////////////////////////////////////////////////////////
  get_malls() async {
    mall_lst = [];
    try {
      firestoreInstance.collection("malls").get().then((value) {
        for (int i = 0; i < value.docs.length; i++) {
          try {
            firestoreInstance
                .collection("malls")
                .doc(value.docs[i].id.toString())
                .get()
                .then((value) {
              Map<String, dynamic>? h = value.data();
              if (h != null) {
                _mall_modelcalss = mall_modelClass.fromJson(h);

                mall_lst!.add(_mall_modelcalss!);
              }
            }).whenComplete(() {
              developer.log("my data g       " + mall_lst!.length.toString());
              setState(() {});
            });
          } catch (e) {
            print(e.toString());
          }
        }
      });
    } catch (e) {
      _displaySnackBar(context, "No user Found");
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
