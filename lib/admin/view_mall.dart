// ignore_for_file: sized_box_for_whitespace, non_constant_identifier_names, unused_field, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navi_mall_app/colors.dart' as color;
import 'package:navi_mall_app/model_class/mall_model_list.dart';

class ViewMallScreen extends StatefulWidget {
  final String mall;
  final String photoURL;
  const ViewMallScreen({required this.mall, required this.photoURL});

  @override
  State<ViewMallScreen> createState() => _ViewMallScreenState();
}

class _ViewMallScreenState extends State<ViewMallScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  User? user = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;

  mall_modelClass? _mall_modelcalss;
  var name = "";
  var phone = "";
  var instagram = "";
  var facebook = "";
  var about = "";
  var open_hour = "";
  var close_hour = "";
  @override
  void initState() {
    super.initState();
    name = widget.mall;
    print(name);
    FirebaseFirestore.instance
        .collection('malls')
        .doc(name)
        .get()
        .then((value) {
      var fields = value.data();
      print(fields);
      setState(() {
        phone = '${fields!['phone']}';
        instagram = fields!['instagram'];
        facebook = fields!['facebook'];
        about = fields!['about'];
        open_hour = fields!['open_hour'];
        close_hour = fields!['close_hour'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String profileImg = widget.photoURL;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffd6ddd8),
        elevation: 0,
        centerTitle: true,
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
                CircleAvatar(
                  radius: 80.0,
                  backgroundColor: Color(0xffd6ddd8),
                  backgroundImage: NetworkImage(profileImg),
                ),
                const SizedBox(height: 24),
                getText(context, 'Phone Number'),
                const SizedBox(height: 8),
                TextFormField(
                  // controller: nameController,
                  initialValue: phone,
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
                getText(context, 'Instagram'),
                const SizedBox(height: 8),
                TextFormField(
                  // controller: nameController,
                  initialValue: instagram,
                  onChanged: (value) => instagram = value,
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
                  initialValue: open_hour,
                  onChanged: (value) => open_hour = value,
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
                  initialValue: close_hour,
                  onChanged: (value) => close_hour = value,
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
                      if (_formKey.currentState!.validate()) {}
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

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      //final imageTemporary = File(image.path);
      //uploadFile(imageTemporary);
      //setState(() => this.image = imageTemporary);
      // uploadFile();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to pick the image : $e");
      }
    }
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

  get_mall() {}
}
