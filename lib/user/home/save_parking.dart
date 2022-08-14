// ignore_for_file: prefer_const_constructors, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navi_mall_app/pallete.dart';

class SaveParkingScreen extends StatefulWidget {
  const SaveParkingScreen({Key? key}) : super(key: key);

  @override
  State<SaveParkingScreen> createState() => _SaveParkingScreenState();
}

class _SaveParkingScreenState extends State<SaveParkingScreen> {
  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        children: [
          Form(
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(75),
                    border: Border.all(
                      color: Color.fromARGB(255, 84, 112, 85),
                    ),
                  ),
                  child: Icon(
                    FontAwesomeIcons.p,
                    size: 75,
                    color: Color.fromARGB(255, 84, 112, 85),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Text(
                      'Level ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromARGB(255, 41, 49, 42)),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, left: 5),
                        child: TextFormField(
                          maxLines: 1,
                          // controller: eduController,
                          // initialValue: education,
                          // onChanged: (value) => education = value,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            constraints:
                            BoxConstraints(maxWidth: 15, maxHeight: 40),
                            isDense: true,
                            errorStyle: TextStyle(
                                color: Colors.redAccent, fontSize: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Text(
                      'Mall ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromARGB(255, 41, 49, 42)),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, left: 5),
                        child: TextFormField(
                          maxLines: 1,
                          // controller: eduController,
                          // initialValue: education,
                          // onChanged: (value) => education = value,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            constraints:
                            BoxConstraints(maxWidth: 15, maxHeight: 40),
                            isDense: true,
                            errorStyle: TextStyle(
                                color: Colors.redAccent, fontSize: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Text(
                      'Zone ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromARGB(255, 41, 49, 42)),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, left: 5),
                        child: TextFormField(
                          maxLines: 1,
                          // controller: eduController,
                          // initialValue: education,
                          // onChanged: (value) => education = value,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            constraints:
                            BoxConstraints(maxWidth: 15, maxHeight: 40),
                            isDense: true,
                            errorStyle: TextStyle(
                                color: Colors.redAccent, fontSize: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
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
                          child: Text("Generate Ticket",
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
}