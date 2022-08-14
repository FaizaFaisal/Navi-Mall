// ignore_for_file: unnecessary_import, sized_box_for_whitespace, prefer_const_constructors, unnecessary_new, empty_catches

import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navi_mall_app/admin/view_all_mall.dart';
import 'package:navi_mall_app/forgot_password.dart';
import 'package:navi_mall_app/register.dart';
import 'package:navi_mall_app/services/user_service.dart';
import 'package:navi_mall_app/user/home/home.dart';
import 'package:navi_mall_app/colors.dart' as color;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  var email = "";
  var password = "";
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  final textFieldFocusNode = FocusNode();
  bool _obscured = false;

  void _toggleObscured() {
    // Gesture Function for Password
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  clearText() {
    emailController.clear();
    passwordController.clear();
  }

  Flushbar flush = new Flushbar();

  // Create storage
  final storage = new FlutterSecureStorage();

  userLogin() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (kDebugMode) {
        print(userCredential.user?.uid);
      }

      try {
        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) async {
          if (documentSnapshot.exists) {
            dynamic role = documentSnapshot.get('userRole'); // get User Role
            if (kDebugMode) {
              print(role);
            }
            if (role != 'user') {
              setState(() {
                isLoading = false;
              });
              await storage.deleteAll();
              await storage.write(key: "uid", value: userCredential.user?.uid);
              await storage.write(key: "role", value: "admin");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: color.AppColor.white,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
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
                          "Logged In Successfully",
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

              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ViewAllMallScreen()));
            } else {
              setState(() {
                isLoading = false;
              });
              await storage.deleteAll();
              await storage.write(key: "uid", value: userCredential.user?.uid);
              await storage.write(key: "role", value: "user");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: color.AppColor.white,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
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
                          "Logged In Successfully",
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

              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            }
          } else {
            if (kDebugMode) {
              print('Document does not exist on the database');
            }
          }
        });
      } catch (e) {}
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          isLoading = false;
        });
        flush = Flushbar(
          backgroundColor: Colors.red,
          flushbarStyle: FlushbarStyle.FLOATING,
          titleText: Text(
            "No user found for this email",
            style: TextStyle(
                color: color.AppColor.white,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
          flushbarPosition: FlushbarPosition.TOP,
          message: "Please try again !",
          messageSize: 16,
          messageColor: Colors.white70,
          margin: EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(8),
          icon: Icon(
            Icons.info_outline,
            size: 40.0,
            color: Colors.white,
          ),
          duration: Duration(days: 1),
          //leftBarIndicatorColor: color.AppColor.welcomeImageContainer,
          mainButton: IconButton(
              icon: Icon(FontAwesomeIcons.xmark,
                  color: color.AppColor.white, size: 15),
              onPressed: () {
                flush.dismiss(true); // result = true
                clearText();
              }),
        )..show(context);
      } else if (e.code == 'wrong-password') {
        setState(() {
          isLoading = false;
        });
        flush = Flushbar(
          backgroundColor: Colors.red,
          flushbarStyle: FlushbarStyle.FLOATING,
          messageText: Text(
            "Wrong Password Try Again !",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          flushbarPosition: FlushbarPosition.TOP,
          margin: EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(8),
          icon: Icon(
            Icons.error_outline_outlined,
            size: 40.0,
            color: Colors.white,
          ),
          duration: Duration(days: 1),
          mainButton: IconButton(
              icon: Icon(FontAwesomeIcons.xmark,
                  color: color.AppColor.white, size: 15),
              onPressed: () {
                flush.dismiss(true); // result = true
              }),
        )..show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffd6ddd8),
        elevation: 0,
        centerTitle: true,
        leading: BackButton(
          color: Colors.black87,
          onPressed: () {
            //Navigator.pop(context);
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "NaviMall",
          style: GoogleFonts.playfairDisplay(
            textStyle: Theme.of(context).textTheme.headline5,
            fontSize: 25,
            color: Colors.black87,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: loginUI(context, height, width),
    );
  }

  loginUI(BuildContext context, height, width) {
    return SingleChildScrollView(
      reverse: true,
      child: Container(
        color: Colors.white,
        height: height,
        width: width,
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Welcome!',
                  style: GoogleFonts.roboto(
                    textStyle: Theme.of(context).textTheme.headline1,
                    fontSize: 26,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 84, 112, 85),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'To continue using the app, \n Please login first.',
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    textStyle: Theme.of(context).textTheme.headline1,
                    fontSize: 20,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 84, 112, 85),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Image(
                  image: AssetImage('assets/images/person_icon.png'),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            Expanded(
              child: Container(
                height: height,
                child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: Color.fromARGB(255, 58, 70, 58),
                            ),
                            hintText: "Email",
                            hintStyle: const TextStyle(fontSize: 15.0),
                            focusColor: Colors.lightGreen.shade900,
                            errorStyle: const TextStyle(
                              color: Colors.redAccent,
                              fontSize: 15,
                            ),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                    .hasMatch(value)) {
                              return "Enter correct Email";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: height * 0.02),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: _obscured,
                          focusNode: textFieldFocusNode,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            isDense: true, // Reduces height a bit
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Color.fromARGB(255, 58, 70, 58),
                            ),
                            focusColor: Colors.lightGreen.shade900,
                            hintText: "Password",
                            hintStyle: const TextStyle(fontSize: 15.0),
                            errorStyle: const TextStyle(
                              color: Colors.redAccent,
                              fontSize: 15,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: _toggleObscured,
                              child: Icon(
                                _obscured
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded,
                                size: 24,
                                color: Color.fromARGB(255, 58, 70, 58),
                              ),
                            ),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r'^[a-z A-Z]').hasMatch(value)) {
                              return "Enter correct Password";
                            } else {
                              return null;
                            }
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) =>
                                      (const ForgotPasswordScreen()),
                                ));
                              },
                              child: Text(
                                "Forgot Password?",
                                style: GoogleFonts.roboto(
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal,
                                  color: const Color(0xFF5D7461),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              fit: FlexFit.tight,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      email = emailController.text;
                                      password = passwordController.text;
                                      isLoading = true;
                                    });
                                    userLogin();
                                  }
                                },
                                child: isLoading
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          const CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 24),
                                          const Text('Please Wait...'),
                                        ],
                                      )
                                    : Text(
                                        "SIGN IN",
                                        style: GoogleFonts.roboto(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // <-- Radius
                                  ),
                                  //shape: StadiumBorder(),
                                  fixedSize: const Size(265, 50),
                                  primary: Color.fromARGB(255, 7, 81, 6)
                                      .withOpacity(0.4),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?",
                                style: TextStyle(
                                    fontSize: 18, color: Color(0xFF5D7461))),
                            SizedBox(width: width * 0.001),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) =>
                                        (const RegisterScreen()),
                                  ));
                                },
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 24, 26, 24)),
                                ))
                          ],
                        )
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
