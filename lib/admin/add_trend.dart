import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:navi_mall_app/colors.dart' as color;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddTrendScreen extends StatefulWidget {
  final String mall;
  final String store;
  const AddTrendScreen({required this.mall, required this.store});

  State<AddTrendScreen> createState() => _AddTrendScreenState();
}

class _AddTrendScreenState extends State<AddTrendScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String nameFile = "";
  var description = "";
  var mall = "";
  var store = "";
  firebase_storage.UploadTask? task;
  File? image;
  late final urlDownload;
  bool profile_img = false;

  String profileImg =
      "https://pbs.twimg.com/profile_images/1304985167476523008/QNHrwL2q_400x400.jpg";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xffd6ddd8),
            elevation: 0,
            centerTitle: true,
            title: Text(
              widget.store,
              style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.headline5,
                fontSize: 25,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
            ),
            actions: [
              // IconButton(
              //     onPressed: () {
              //       AwesomeDialog(
              //         context: context,
              //         dialogType: DialogType.QUESTION,
              //         headerAnimationLoop: false,
              //         animType: AnimType.TOPSLIDE,
              //         title: 'Delete Trending?',
              //         btnOkColor: Colors.redAccent,
              //         btnOkText: 'Delete',
              //         btnOkIcon: Icons.delete_outlined,
              //         btnCancelColor: Colors.blueGrey.shade700,
              //         btnCancelText: 'Cancel',
              //         desc: 'This will delete the trending from the mall',
              //         descTextStyle: TextStyle(
              //             color: Colors.blueGrey.shade300, fontSize: 18),
              //         showCloseIcon: true,
              //         btnCancelOnPress: () {},
              //         btnOkOnPress: () {
              //           firestoreInstance
              //               .collection("malls")
              //               .doc(mall)
              //               .collection('trending')
              //               .doc(store)
              //               .delete();
              //         },
              //       ).show();
              //     },
              //     icon: Icon(
              //       Icons.delete,
              //       color: color.AppColor.white,
              //       size: 25,
              //     )),
            ]),
        backgroundColor: color.AppColor.homePageBackground,
        body: Container(
          padding:
          const EdgeInsets.only(top: 20, bottom: 20, left: 12, right: 12),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: color.AppColor.homePageBackground,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
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
                getText(context, 'Mall'),
                const SizedBox(height: 8),
                TextFormField(
                  // controller: nameController,
                  readOnly: true,
                  initialValue: widget.mall,
                  onChanged: (value) => mall = value,
                  decoration: InputDecoration(
                    errorStyle:
                    const TextStyle(color: Colors.redAccent, fontSize: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                getText(context, 'Store'),
                const SizedBox(height: 8),
                TextFormField(
                  // controller: nameController,

                  initialValue: widget.store,
                  keyboardType: TextInputType.text,
                  onChanged: (value) => store = value,
                  decoration: InputDecoration(
                    errorStyle:
                    const TextStyle(color: Colors.redAccent, fontSize: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                getText(context, 'Description'),
                const SizedBox(height: 8),
                TextFormField(
                  // controller: nameController,

                  initialValue: description,
                  style: TextStyle(color: Colors.black87),
                  keyboardType: TextInputType.text,
                  onChanged: (value) => description = value,
                  decoration: InputDecoration(
                    errorStyle:
                    const TextStyle(color: Colors.redAccent, fontSize: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    onTap: () {
                      if (widget.mall != '' && widget.store != '') {
                        uploadFile(image!, widget.mall, widget.store);
                        addTrending(widget.mall, widget.store);
                        AwesomeDialog(
                            context: context,
                            animType: AnimType.SCALE,
                            headerAnimationLoop: true,
                            dialogType: DialogType.SUCCES,
                            showCloseIcon: true,
                            title: 'Success',
                            desc: ' Updated Successfully ',
                            btnOkOnPress: () {
                              debugPrint('OnClcik');
                              Navigator.pop(context);
                            },
                            btnOkIcon: Icons.check_circle,
                            onDissmissCallback: (type) {
                              debugPrint('Dialog Dissmiss from callback $type');
                            }).show();
                        // Navigator.pop(context);
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
        ));
  }

  addTrending(mallName, storeName) {
    firestoreInstance
        .collection("malls")
        .doc(mallName)
        .collection('trending')
        .doc(storeName)
        .set({
      "mallName": mallName,
      "storeName": storeName,
      "description": description,
    })
        .then((value) => print("Trending Updated"))
        .catchError((error) => print("Failed to update trending: $error"));
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
  Future uploadFile(File image, mallName, storeName) async {
    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child("malls/$mallName/store/$storeName/trend_Img");

      firebase_storage.UploadTask uploadTask = ref.putFile(image);
      uploadTask.whenComplete(() {
        print('File Uploaded');
        ref.getDownloadURL().then((fileURL) {
          print(fileURL);

          firestoreInstance
              .collection("malls")
              .doc(mallName)
              .collection('trending')
              .doc(storeName)
              .update({
            "photoURL": fileURL.toString(),
          }).whenComplete(() {
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
            "Choose  picture",
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