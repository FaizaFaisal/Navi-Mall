// ignore_for_file: prefer_const_constructors, unnecessary_import, unused_import, sized_box_for_whitespace, non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navi_mall_app/model_class/trend_model_list.dart';
import 'package:navi_mall_app/user/home/category_info.dart';
import 'package:navi_mall_app/colors.dart' as color;
import 'package:navi_mall_app/colors.dart';
import 'package:navi_mall_app/user/home/mall_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:navi_mall_app/admin/edit_mall_details.dart';
import 'package:navi_mall_app/login.dart';
import 'package:navi_mall_app/model_class/mall_model_list.dart';
import 'package:navi_mall_app/services/user_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'dart:developer' as developer;
import 'package:share_plus/share_plus.dart';

class HomeBodyContentScreen extends StatefulWidget {
  const HomeBodyContentScreen({Key? key}) : super(key: key);

  @override
  State<HomeBodyContentScreen> createState() => _HomeBodyContentScreenState();
}

class _HomeBodyContentScreenState extends State<HomeBodyContentScreen> {
  var name = "";
  User? user = FirebaseAuth.instance.currentUser;

  List<mall_modelClass>? mall_lst;
  final firestoreInstance = FirebaseFirestore.instance;

  mall_modelClass? _mall_modelcalss;

  List<trend_modelClass>? trend_lst;

  trend_modelClass? _trend_modelcalss;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController searchController = TextEditingController();
  mall_modelClass? mallSearchResponse;
  int _currentIndex = 0;

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
    trend_lst = [];
    get_malls();
    get_trend();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.AppColor.homePageBackground,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 16),
        children: [
          Container(
            color: color.AppColor.gray.withOpacity(0.1),
            width: double.infinity,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  child: TextField(
                    controller: searchController,
                    cursorColor: color.AppColor.matteBlack,
                    style: GoogleFonts.lato(),
                    decoration: InputDecoration(
                      hintText:
                          'Search for shopping center, brands, stores ...',
                      hintStyle: TextStyle(color: color.AppColor.gray),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: color.AppColor.matteBlack,
                        ),
                        onPressed: () {
                          get_mall_search(searchController.text.trim());
                          print("Click");
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        borderSide:
                            BorderSide(width: 1, color: color.AppColor.gray),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        borderSide: BorderSide(
                            width: 5,
                            color: color.AppColor.matteBlack.withOpacity(0.1)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Container(
            color: color.AppColor.homePageBackground,
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Malls',
                          style: GoogleFonts.lato(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(221, 62, 123, 61))),
                    ],
                  ),
                ),
                Container(
                  height: 165,
                  width: MediaQuery.of(context).size.width,
                  //color: color.AppColor.gray.withOpacity(0.2),
                  padding: const EdgeInsets.all(2),
                  child: mall_lst!.length > 0
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.all(12.0),
                          itemCount: mall_lst!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => MallInfoScreen(
                                        name: mall_lst![index].name,
                                        about: mall_lst![index].about,
                                        close_hour: mall_lst![index].close_hour,
                                        website: mall_lst![index].website,
                                        facebook: mall_lst![index].facebook,
                                        photoURL: mall_lst![index].photoURL,
                                        instagram: mall_lst![index].name,
                                        phone: mall_lst![index].phone,
                                        open_hour: mall_lst![index].open_hour,
                                      ),
                                    ));
                                  },
                                  child: Card(
                                    shadowColor: color.AppColor.buttons,
                                    //elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                        color: color.AppColor.gray
                                            .withOpacity(0.2),
                                        width: 2,
                                      ),
                                    ),
                                    child: Image(
                                      height: 125,
                                      width: 125,
                                      image: NetworkImage(
                                          mall_lst![index].photoURL),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4),
                              ],
                            );
                          })
                      : Center(
                          child: Text(
                          "No Data Found ",
                          style: TextStyle(fontSize: 18),
                        )),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 10,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: color.AppColor.gray.withOpacity(0.1),
              ),
            ),
          ),
          Container(
            color: color.AppColor.homePageBackground,
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Categories',
                          style: GoogleFonts.lato(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(221, 62, 123, 61))),
                    ],
                  ),
                ),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  color: color.AppColor.gray.withOpacity(0.1),
                  padding: const EdgeInsets.all(5),
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      categoryItem(Icons.shopping_bag, 'Shopping',
                          Color.fromARGB(255, 77, 168, 92)),
                      categoryItem(Icons.dining, 'Dining',
                          Color.fromARGB(255, 113, 125, 70)),
                      categoryItem(Icons.attractions, 'Attractions',
                          Color.fromARGB(255, 187, 114, 85)),
                      categoryItem(Icons.event, 'Events',
                          Color.fromARGB(255, 158, 185, 76)),
                      categoryItem(Icons.wash, 'Services',
                          Color.fromARGB(255, 122, 96, 45)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 10,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: color.AppColor.gray.withOpacity(0.1),
              ),
            ),
          ),
          // Trending List
          Container(
            color: color.AppColor.homePageBackground,
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Text('Trending',
                          style: GoogleFonts.lato(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(221, 62, 123, 61))),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 6,
                ),
                Expanded(
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    //color: color.AppColor.gray.withOpacity(0.2),
                    child: trend_lst!.length >= 1
                        ? ListView.builder(
                            shrinkWrap: true,
                            reverse: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  Container(
                                    color: color.AppColor.gray.withOpacity(0.1),
                                    child: ListTile(
                                      title: Text(
                                        trend_lst![index].storeName,
                                        style: GoogleFonts.lato(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Text(
                                        trend_lst![index].mallName,
                                        style: GoogleFonts.lato(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Card(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        // side: BorderSide(
                                        //   color: color.AppColor.gray.withOpacity(0.2),
                                        //   width: 1,
                                        // ),
                                      ),
                                      child: Image(
                                        height: 180,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        image: NetworkImage(
                                            trend_lst![index].photoURL),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          final box = context.findRenderObject()
                                              as RenderBox?;
                                          Share.share(
                                              trend_lst![index].description,
                                              subject: 'Shared',
                                              sharePositionOrigin: box!
                                                      .localToGlobal(
                                                          Offset.zero) &
                                                  box.size);
                                        },
                                        icon: Icon(
                                          Icons.share,
                                          color: color.AppColor.white,
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Navigate',
                                          style: GoogleFonts.roboto(
                                            color: color.AppColor.white,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          shape: StadiumBorder(),
                                          primary: Color.fromARGB(255, 7, 81, 6)
                                              .withOpacity(0.4),
                                          //primary: color.AppColor.buttons,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: color.AppColor.gray.withOpacity(0.2),
                                    thickness: 1.5,
                                  ),
                                ],
                              );
                            })
                        : Center(
                            child: Text(
                            "No Data Found ",
                            style: TextStyle(fontSize: 18),
                          )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  categoryItem(IconData category_icon, String text, Color color_icon) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => (const CategoryInfoScreen()),
            ));
          },
          child: Container(
            height: 100,
            width: 105,
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
              child: Icon(
                category_icon,
                size: 65,
                color: color_icon,
              ),
            ),
          ),
        ),
        SizedBox(height: 4),
        InkWell(
          onTap: () {},
          child: Text(
            text,
            style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: color.AppColor.matteBlack),
          ),
        ),
      ],
    );
  }

  get_trend() async {
    trend_lst = [];
    try {
      await FirebaseFirestore.instance
          .collection('malls')
          .get()
          .then((querySnapshot) async {
        for (var result in querySnapshot.docs) {
          if (result.exists) {
            await FirebaseFirestore.instance
                .collection("malls")
                .doc(result.id)
                .collection("trending")
                .get()
                .then((querySnapshot) {
              for (var result in querySnapshot.docs) {
                Map<String, dynamic>? h = result.data();
                if (h != null) {
                  _trend_modelcalss = trend_modelClass.fromJson(h);

                  trend_lst!.add(_trend_modelcalss!);
                }
                print(result.data());
              }
            });
          } else {
            _displaySnackBar(context, "No data Found");
          }
        }
      });
      // firestoreInstance.collection("malls").get().then((value) {
      //   for (int i = 0; i < value.docs.length; i++) {
      //     try {
      //       firestoreInstance
      //           .collection("malls")
      //           .doc(value.docs[i].id.toString())
      //           .collection("trending")
      //           .doc(value.docs[i].id.toString())
      //           .get()
      //           .then((value) {
      //         Map<String, dynamic>? h = value.data();
      //         if (h != null) {
      //           _trend_modelcalss = trend_modelClass.fromJson(h);

      //           trend_lst!.add(_trend_modelcalss!);
      //         }
      //       }).whenComplete(() {
      //         developer.log("my job     " + trend_lst!.length.toString());
      //         setState(() {});
      //       });
      //     } catch (e) {
      //       print(e.toString());
      //     }
      //   }
      // });
    } catch (e) {
      _displaySnackBar(context, "No user Found");
    }
  }

  /// Get  data against title ////////////////////////////////////////////////////////
  Future<String?> get_mall_search(String keyword) async {
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
                mallSearchResponse = mall_modelClass.fromJson(h);
                if (mallSearchResponse!.name.trim() == keyword.trim()) {
                  mall_lst!.add(mallSearchResponse!);
                }
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
      _displaySnackBar(context, "No Business Found");
    }
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
