// ignore_for_file: sized_box_for_whitespace, unnecessary_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navi_mall_app/login.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  var newPassword = "";
  // Create a text controller and use it to retrieve the current value
  // of the TextField.

  final newPasswordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    newPasswordController.dispose();
    super.dispose();
  }

  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
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
      body: resetPasswordUI(context),
    );
  }

  changePassword() async {
    try {
      await currentUser!.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.transparent,
          behavior: SnackBarBehavior.floating,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_rounded,
                size: 40.0,
                color: Colors.green[900],
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Text(
                  "Your Password has been changed. Login again !",
                  style: TextStyle(
                      color: Colors.teal[900],
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      );
    } catch (e) {}
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  resetPasswordUI(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 22),
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              children: [
                Text(
                  "Reset Password",
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
              child: const Text(
                "Your new password must be different from previous used passwords.",
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextFormField(
                autofocus: false,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password ',
                  hintText: 'Enter New Password',
                  labelStyle: TextStyle(fontSize: 20.0),
                  border: OutlineInputBorder(),
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
                ),
                controller: newPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Password';
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // <-- Radius
                ),
                //shape: StadiumBorder(),
                fixedSize: Size(MediaQuery.of(context).size.width, 50),
                primary: Color.fromARGB(255, 7, 81, 6).withOpacity(0.4),
              ),
              onPressed: () {
                // Validate returns true if the form is valid, otherwise false.
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    newPassword = newPasswordController.text;
                  });
                  changePassword();
                }
              },
              child: const Text(
                'Reset Password',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}