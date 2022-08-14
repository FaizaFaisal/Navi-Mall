// ignore_for_file: prefer_const_constructors, unnecessary_import, sized_box_for_whitespace

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navi_mall_app/login.dart';
import 'package:navi_mall_app/colors.dart' as color;

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  var email = "";

  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    super.dispose();
  }

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: color.AppColor.subText,
          content: Text(
            "Email has been sent",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: color.AppColor.homePageBackground),
          ),
        ),
      );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: color.AppColor.subText,
            content: Text(
              "User Not found",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: color.AppColor.homePageBackground),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xffd6ddd8),
        elevation: 0,
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
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  "Forgot Password",
                  style: TextStyle(
                      color: Color.fromARGB(221, 62, 123, 61),
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Enter the email associated with your account and we'll send an email with instructions to reset your password.",
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: height * 0.01),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: Color.fromARGB(255, 45, 46, 45),
                            ),
                            hintText: "Email Address",
                            hintStyle: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w400),
                            errorStyle: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 15,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Email';
                            } else if (!value.contains('@')) {
                              return 'Please Enter Valid Email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: height * 0.02),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                email = emailController.text;
                              });
                              resetPassword();
                            }
                          },
                          child: Text(
                            'Send Instructions',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            //shape: OutlineInputBorder(),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // <-- Radius
                            ),
                            //shape: StadiumBorder(),
                            fixedSize:
                                Size(MediaQuery.of(context).size.width, 50),
                            primary:
                                Color.fromARGB(255, 7, 81, 6).withOpacity(0.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
