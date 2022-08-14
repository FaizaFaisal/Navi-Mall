// ignore_for_file: unused_field, non_constant_identifier_names, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:navi_mall_app/admin/open_location_picker.dart';
import 'package:navi_mall_app/colors.dart' as color;
import 'package:image_picker/image_picker.dart';
import 'dart:developer' as developer;

import 'dart:async';

import 'package:navi_mall_app/services/admin_service.dart';
import 'package:navi_mall_app/utils/map.dart';

class AddMallScreen extends StatefulWidget {
  const AddMallScreen({Key? key}) : super(key: key);

  @override
  State<AddMallScreen> createState() => _AddMallScreenState();
}

class _AddMallScreenState extends State<AddMallScreen> {
  String nameFile = "";
  LatLng? latLng;
  double? lat;
  double? lng;
  GeoPoint final_geo = GeoPoint(0, 0);
  User? user = FirebaseAuth.instance.currentUser;
  firebase_storage.UploadTask? task;
  File? image;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final firestoreInstance = FirebaseFirestore.instance;
  late final urlDownload;
  bool profile_img = false;

  String profileImg =
      "https://pbs.twimg.com/profile_images/1304985167476523008/QNHrwL2q_400x400.jpg";

  final _formKey = GlobalKey<FormState>();
  var name = "";
  var phone = "";
  var web = "";
  var insta = "";
  var facebook = "";
  var about = "";
  var open_hours = "";
  var close_hours = "";
  GeoPoint location = GeoPoint(0, 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffd6ddd8),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Insert Mall",
          style: GoogleFonts.roboto(
            textStyle: Theme.of(context).textTheme.headline5,
            fontSize: 20,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      backgroundColor: color.AppColor.homePageBackground,
      body: Container(
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Stack(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 100.0,
                        backgroundColor: Color(0xffd6ddd8),
                        child: image != null
                            ? Image.file(image!, fit: BoxFit.cover)
                            : Text('Upload Image'),
                        //backgroundImage: NetworkImage(profileImg),
                      ),
                      Positioned(
                        bottom: 20.0,
                        right: 20.0,
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: ((builder) => bottomSheet()),
                            );
                          },
                          child: ClipOval(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              color: Color.fromARGB(255, 7, 81, 6)
                                  .withOpacity(0.4),
                              child: const Icon(
                                Icons.add_a_photo,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                getText(context, 'Name'),
                const SizedBox(height: 8),
                TextFormField(
                  // controller: nameController,
                  initialValue: name,
                  keyboardType: TextInputType.text,
                  onChanged: (value) => name = value,
                  decoration: InputDecoration(
                    errorStyle:
                        const TextStyle(color: Colors.redAccent, fontSize: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                getText(context, 'Phone Number'),
                const SizedBox(height: 8),
                TextFormField(
                  // controller: nameController,
                  initialValue: phone,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) => phone = value,
                  decoration: InputDecoration(
                    errorStyle:
                        const TextStyle(color: Colors.redAccent, fontSize: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                getText(context, 'Website'),
                const SizedBox(height: 8),
                TextFormField(
                  // controller: nameController,
                  initialValue: web,
                  keyboardType: TextInputType.url,
                  onChanged: (value) => web = value,
                  decoration: InputDecoration(
                    errorStyle:
                        const TextStyle(color: Colors.redAccent, fontSize: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                getText(context, 'Instagram'),
                const SizedBox(height: 8),
                TextFormField(
                  // controller: nameController,
                  initialValue: insta,
                  keyboardType: TextInputType.url,
                  onChanged: (value) => insta = value,
                  decoration: InputDecoration(
                    errorStyle:
                        const TextStyle(color: Colors.redAccent, fontSize: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                getText(context, 'Facebook'),
                const SizedBox(height: 8),
                TextFormField(
                  // controller: nameController,
                  initialValue: facebook,
                  keyboardType: TextInputType.url,
                  onChanged: (value) => facebook = value,
                  decoration: InputDecoration(
                    errorStyle:
                        const TextStyle(color: Colors.redAccent, fontSize: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                getText(context, 'Opening Hour'),
                const SizedBox(height: 8),
                TextFormField(
                  // controller: nameController,
                  initialValue: open_hours,
                  onChanged: (value) => open_hours = value,
                  decoration: InputDecoration(
                    errorStyle:
                        const TextStyle(color: Colors.redAccent, fontSize: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                getText(context, 'Closing Hours'),
                const SizedBox(height: 8),
                TextFormField(
                  // controller: nameController,
                  initialValue: close_hours,
                  onChanged: (value) => close_hours = value,
                  decoration: InputDecoration(
                    errorStyle:
                        const TextStyle(color: Colors.redAccent, fontSize: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                getText(context, 'About'),
                const SizedBox(height: 8),
                TextFormField(
                  // controller: nameController,
                  initialValue: about,
                  onChanged: (value) => about = value,
                  decoration: InputDecoration(
                    errorStyle:
                        const TextStyle(color: Colors.redAccent, fontSize: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  maxLines: 2,
                ),

                ElevatedButton(
                  onPressed: () {
                    _navigateAndDisplaySelection(context);
                  },
                  child: const Text('Pick location'),
                ),

                //
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        uploadFile(image!);
                        AdminService(user!.uid).addMall(name, phone, web, insta,
                            facebook, open_hours, close_hours, about, final_geo);
                        AwesomeDialog(
                            context: context,
                            animType: AnimType.SCALE,
                            headerAnimationLoop: true,
                            dialogType: DialogType.SUCCES,
                            showCloseIcon: true,
                            title: 'Success',
                            desc: 'Mall Added Successfully ',
                            btnOkOnPress: () {
                              debugPrint('OnClcik');
                            },
                            btnOkIcon: Icons.check_circle,
                            onDissmissCallback: (type) {
                              debugPrint('Dialog Dissmiss from callback $type');
                            }).show();

                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 7, 81, 6).withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text("Save",
                              style: GoogleFonts.lato(
                                  fontSize: 22, color: color.AppColor.white))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CurrentLocationScreen()),
    );
    setState(() => {"latLng":result});
    final_geo = GeoPoint(result.latitude, result.longitude);
    setState(() => {"final_geo": final_geo});
    //GeoPoint point = new GeoPoint(lat, lng);
    developer.log("${result.latitude}");
    developer.log("final_geo");
    developer.log(final_geo.toString());

    print(result);
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
      //uploadFile(imageTemporary);
    } on PlatformException catch (e) {
      print("Failed to pick the image : $e");
    }
  }

  /// Upload Profile ///////////////////////////////////////
  Future uploadFile(File image) async {
    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child("malls/$name/mall_logo_Img");

      firebase_storage.UploadTask uploadTask = ref.putFile(image);
      uploadTask.whenComplete(() {
        print('File Uploaded');
        ref.getDownloadURL().then((fileURL) {
          print(fileURL);

          firestoreInstance
              .collection("malls")
              .doc(name)
              .update({"photoURL": fileURL.toString()}).whenComplete(() {
            setState(() {
              profile_img = true;
              profileImg = fileURL.toString();
            });

            _displaySnackBar(context, "Image uploaded Successfully");
          }).catchError((e) {
            _displaySnackBar(context, "Something Went Wrong! Try Again");
          });
        });
      }).catchError((e) {
        _displaySnackBar(context, "Something Went Wrong! Try Again");
      });
    } catch (e) {
      _displaySnackBar(context, "Image uploading fail");
      print(e.toString());
    }
  }

  /// Show Snackbar ////////////////////////////////////////////////////////////////
  _displaySnackBar(BuildContext context, String msg) {
    final snackBar = SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        msg,
        style: TextStyle(fontSize: 25, color: Colors.white),
      ),
      duration: Duration(seconds: 7),
    );
    _scaffoldKey.currentState!.showSnackBar(snackBar);
  }

  Widget getText(BuildContext context, String label) => Text(
        label,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color.fromARGB(255, 41, 49, 42)),
      );
  Widget bottomSheet() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.14,
      width: MediaQuery.of(context).size.width * 0.25,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose profile picture",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () => pickImage(ImageSource.gallery),
                icon: Icon(
                  Icons.image_outlined,
                  size: 30,
                  color: color.AppColor.white,
                ),
                label: Text('Gallery',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: color.AppColor.white)),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 7, 81, 6).withOpacity(0.4),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              ElevatedButton.icon(
                onPressed: () => pickImage(ImageSource.camera),
                icon: Icon(
                  Icons.camera_alt_outlined,
                  size: 30,
                  color: color.AppColor.white,
                ),
                label: Text('Camera',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: color.AppColor.white)),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 7, 81, 6).withOpacity(0.4),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
