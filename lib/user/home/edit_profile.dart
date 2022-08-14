// ignore_for_file: unused_field
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navi_mall_app/pallete.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navi_mall_app/colors.dart' as color;
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();
  var name = "";
  var phone = "";
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      var fields = value.data();
      nameController.text = fields!['name'] as String;
      phoneController.text = fields['phone'] as String;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffd6ddd8),
        elevation: 0,
        centerTitle: true,
        // leading: BackButton(
        //   color: Colors.black87,
        //   onPressed: () {
        //     //Navigator.pop(context);
        //     Navigator.of(context).pop();
        //   },
        // ),
        title: Text(
          "NaviMall",
          style: GoogleFonts.playfairDisplay(
            textStyle: Theme.of(context).textTheme.headline5,
            fontSize: 25,
            color: Color.fromARGB(255, 41, 49, 42),
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(138, 213, 251, 207),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 150,
                    color: Color.fromARGB(146, 45, 84, 44),
                  ),
                ),
                const SizedBox(height: 15),
                getText(context, 'Name'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: nameController,
                  // initialValue: name,
                  // onChanged: (value) => name = value,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    errorStyle:
                    const TextStyle(color: Colors.redAccent, fontSize: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                getText(context, 'Phone'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: phoneController,
                  // initialValue: phone,
                  // onChanged: (value) => phone = value,
                  style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    errorStyle:
                    const TextStyle(color: Colors.redAccent, fontSize: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(user!.uid)
                            .update({'name': name, 'phone': phone});
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
                                  color: Colors.white, fontSize: 20))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getText(BuildContext context, String label) => Text(
    label,
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      // color: color.AppColor.welcomeImageContainer),
    ),
  );
}