// ignore_for_file: prefer_const_constructors, unused_field, non_constant_identifier_names
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navi_mall_app/colors.dart' as color;
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ViewStoreScreen extends StatefulWidget {
  final String name;
  const ViewStoreScreen({Key? key, required this.name}) : super(key: key);

  @override
  State<ViewStoreScreen> createState() => _ViewStoreScreenState();
}

class _ViewStoreScreenState extends State<ViewStoreScreen> {
  String? _chosenCategory;
  String? _chosenSection;
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
  var store_name = "";
  var phone = "";
  var location = "";
  var about = "";
  var open_hours = "";
  var close_hours = "";
  var mallName = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mallName = widget.name;
  }

  List<String> category = [
    'Shopping',
    'Dining',
    'Attractions',
    'Events',
    'Services',
  ];
  List<String> shop_section = [
    'Books/Stationery/Toys/Games',
    'Electronics/Home Appliances',
    'Fashion/Accessories/Handbags/Shoes',
    'HouseHold/Furniture/Carpets',
    'Hypermarket',
    'Jewellery & Watches',
    'Optics/Sunglasses',
    'Pharmacies/Health/Cosmetics/Perfumes'
  ];
  List<String> dine_section = [
    'Arabic cuisine',
    'Asian',
    'International',
    'Fast food',
    'Cafe'
  ];
  List<String> attract_section = [
    'Cinema ',
    'Other attractions',
  ];
  List<String> events_section = [
    'Trending',
  ];
  List<String> service_section = [
    'Bathroom',
    'Taxi gate',
    'Banks & Financial Services',
    'Information center'
  ];
  List<String> section = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffd6ddd8),
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.name,
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
                  initialValue: store_name,
                  onChanged: (value) => store_name = value,
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
                  keyboardType: TextInputType.number,
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
                getText(context, 'Location'),
                const SizedBox(height: 8),
                TextFormField(
                  // controller: nameController,
                  initialValue: location,
                  keyboardType: TextInputType.streetAddress,
                  onChanged: (value) => location = value,
                  decoration: InputDecoration(
                    errorStyle:
                        const TextStyle(color: Colors.redAccent, fontSize: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                getText(context, 'Category'),
                const SizedBox(height: 8),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    errorStyle:
                        const TextStyle(color: Colors.redAccent, fontSize: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  focusColor: Colors.white,
                  value: _chosenCategory,
                  //elevation: 5,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                  iconEnabledColor: Colors.black,
                  hint: Text(
                    "Please choose a Category",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  isExpanded: true,
                  items: category.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? category) {
                    if (category == 'Shopping') {
                      section = shop_section;
                    } else if (category == 'Dining') {
                      section = dine_section;
                    } else if (category == 'Attractions') {
                      section = attract_section;
                    } else if (category == 'Events') {
                      section = events_section;
                    } else if (category == 'Services') {
                      section = service_section;
                    }
                    setState(() {
                      _chosenSection = null;
                      _chosenCategory = category;
                    });
                  },
                ),
                const SizedBox(height: 24),
                getText(context, 'Section'),
                const SizedBox(height: 8),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    errorStyle:
                        const TextStyle(color: Colors.redAccent, fontSize: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  focusColor: Colors.white,
                  value: _chosenSection,
                  //elevation: 5,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                  iconEnabledColor: Colors.black,

                  hint: Text(
                    "Please choose a section",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  isExpanded: true,
                  items: section.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? p) {
                    setState(() {
                      _chosenSection = p;
                    });
                  },
                ),
                const SizedBox(height: 24),
                getText(context, 'Opening Hour'),
                const SizedBox(height: 8),
                TextFormField(
                  // controller: nameController,
                  keyboardType: TextInputType.datetime,
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
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    onTap: () {
                      if (store_name != '' &&
                          phone != '' &&
                          location != '' &&
                          _chosenCategory != '' &&
                          _chosenSection != '' &&
                          open_hours != '' &&
                          close_hours != '' &&
                          about != '') {
                        uploadFile(image!);
                        adding_store(widget.name);
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

  /// opening job ////////////////////////////////////////////////////////
  Future<String?> adding_store(String mallName) async {
    try {
      firestoreInstance
          .collection("malls")
          .doc(mallName)
          .collection("services")
          .doc(store_name)
          .set({
        "store_name": store_name,
        "phone": phone,
        "location": location,
        "category": _chosenCategory,
        "section": _chosenSection,
        "open_hours": open_hours,
        "close_hours": close_hours,
        "about": about,
      }).then((value) {
        AwesomeDialog(
            context: context,
            animType: AnimType.SCALE,
            headerAnimationLoop: true,
            dialogType: DialogType.SUCCES,
            showCloseIcon: true,
            title: 'Success',
            desc: 'Store added Successfully ',
            btnOkOnPress: () {
              debugPrint('OnClcik');
            },
            btnOkIcon: Icons.check_circle,
            onDissmissCallback: (type) {
              debugPrint('Dialog Dissmiss from callback $type');
            }).show();
      });
    } catch (e) {
      _displaySnackBar(context, "No data Found");
    }
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

  ///
  /// Upload Profile ///////////////////////////////////////
  Future uploadFile(File image) async {
    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child("malls/$mallName/store/$store_name/store_Img");

      firebase_storage.UploadTask uploadTask = ref.putFile(image);
      uploadTask.whenComplete(() {
        print('File Uploaded');
        ref.getDownloadURL().then((fileURL) {
          print(fileURL);

          firestoreInstance
              .collection("malls")
              .doc(mallName)
              .collection('services')
              .doc(store_name)
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
