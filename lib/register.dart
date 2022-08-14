// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, unused_local_variable

import 'package:flutter/foundation.dart';
import 'package:navi_mall_app/colors.dart' as color;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:navi_mall_app/services/user_service.dart';
import 'package:navi_mall_app/user/home/home.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final storage = FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  var displayName = "";
  var phoneNumber = "";
  var email = "";
  var password = "";
  var confirm = "";

  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  clearText() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    passwordController.clear();
    confirmController.clear();
  }

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

  final confirmtextFieldFocusNode = FocusNode();
  bool confirmobscured = false;

  void _confirmToggleObscured() {
    // confirm Gesture Function for Password
    setState(() {
      confirmobscured = !confirmobscured;
      if (confirmtextFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      confirmtextFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  // Load Progress
  bool visible = false;
  // Flushbar
  Flushbar flush = Flushbar();

  // Function to create a new User
  registration() async {
    if (password == confirm) {
      try {
        // Register Using email and password
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        User? user = FirebaseAuth.instance.currentUser;

        if (kDebugMode) {
          print(userCredential);
        }

        await storage.deleteAll();
        await storage.write(key: "uid", value: userCredential.user?.uid);
        await storage.write(key: "role", value: "user");
        await UserService(user!.uid).addUser(displayName, phoneNumber, email);

        setState(() {
          visible = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green[600],
            //margin: EdgeInsets.all(5.0), // EdgeInsets.symmetric(vertical:12,horizontal:16)
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Icon(
                  Icons.check_circle_outline_outlined,
                  size: 32.0,
                  color: Colors.white70,
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text(
                    "Registerd Successfully . Logged In ..",
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          //print("Password Provided is too Weak");
          setState(() {
            visible = false;
          });
          flush = Flushbar(
            backgroundColor: Colors.white,
            flushbarStyle: FlushbarStyle.FLOATING,
            titleText: Text(
              "Provided Password is too weak",
              style: TextStyle(
                  color: Colors.redAccent[700],
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            flushbarPosition: FlushbarPosition.TOP,
            message: "Please try again !",
            messageSize: 16,
            messageColor: color.AppColor.gray,
            margin: EdgeInsets.all(8),
            borderRadius: BorderRadius.circular(8),
            borderColor: Colors.redAccent[700],
            icon: Icon(
              Icons.error_outline_outlined,
              size: 40.0,
              color: Colors.redAccent[700],
            ),
            duration: Duration(days: 390),
            leftBarIndicatorColor: Colors.redAccent[700],
            mainButton: IconButton(
                icon: Icon(FontAwesomeIcons.xmark,
                    color: color.AppColor.white, size: 20),
                onPressed: () {
                  flush.dismiss(true);
                  clearText(); // result = true
                }),
          )..show(context);
        } else if (e.code == 'email-already-in-use') {
          //print("Account already exists");
          setState(() {
            visible = false;
          });
          flush = Flushbar(
            backgroundColor: Colors.white,
            flushbarStyle: FlushbarStyle.FLOATING,
            titleText: Text(
              "Account already exists",
              style: TextStyle(
                  color: Colors.redAccent[700],
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            flushbarPosition: FlushbarPosition.TOP,
            message: "Please try with another email !",
            messageSize: 16,
            messageColor: color.AppColor.gray,
            margin: EdgeInsets.all(8),
            borderRadius: BorderRadius.circular(8),
            borderColor: Colors.redAccent[700],
            icon: Icon(
              Icons.error_outline_outlined,
              size: 40.0,
              color: Colors.redAccent[700],
            ),
            duration: Duration(days: 390),
            leftBarIndicatorColor: Colors.redAccent[700],
            mainButton: IconButton(
                icon: Icon(FontAwesomeIcons.xmark,
                    color: color.AppColor.white, size: 20),
                onPressed: () {
                  flush.dismiss(true);
                  clearText(); // result = true
                }),
          )..show(context);
        }
      }
    } else {
      //print("Confirm Password and Password doesn't match");
      setState(() {
        visible = false;
      });
      flush = Flushbar(
        backgroundColor: Colors.white,
        flushbarStyle: FlushbarStyle.FLOATING,
        flushbarPosition: FlushbarPosition.TOP,
        messageText: Text(
          "Password doesn't match !",
          style: TextStyle(
              color: Colors.redAccent[700],
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
        margin: EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(8),
        borderColor: Colors.redAccent[700],
        icon: Icon(
          Icons.error_outline_outlined,
          size: 40.0,
          color: Colors.redAccent[700],
        ),
        duration: Duration(days: 390),
        leftBarIndicatorColor: Colors.redAccent[700],
        mainButton: IconButton(
            icon: Icon(FontAwesomeIcons.xmark,
                color: color.AppColor.white, size: 20),
            onPressed: () {
              flush.dismiss(true);
              clearText(); // result = true
            }),
      )..show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
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
      body: SingleChildScrollView(
        reverse: true,
        child: regsiterUI(context),
      ),
    );
  }

  regsiterUI(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Sign Up",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromARGB(255, 84, 112, 85),
                    fontSize: 28,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    "Please create an account to continue",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromARGB(255, 84, 112, 85),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.04),
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 58, 70, 58),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          hintText: "Name",
                          hintStyle: TextStyle(fontSize: 15.0),
                          errorStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 15,
                          ),
                        ),
                        controller: nameController,
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[a-z A-Z]').hasMatch(value)) {
                            return "Enter Name";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Color.fromARGB(255, 58, 70, 58),
                          ),
                          hintText: "Phone",
                          hintStyle: TextStyle(fontSize: 15.0),
                          errorStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 15,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        controller: phoneController,
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[0-9]{8}').hasMatch(value)) {
                            return "Enter Number ";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Color.fromARGB(255, 58, 70, 58),
                          ),
                          hintText: "Email",
                          hintStyle: TextStyle(fontSize: 15.0),
                          errorStyle: TextStyle(
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
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          isDense: true, // Reduces height a bit
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color.fromARGB(255, 58, 70, 58),
                          ),
                          labelText: "Password",
                          labelStyle: TextStyle(fontSize: 15.0),
                          errorStyle: TextStyle(
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
                      SizedBox(height: height * 0.02),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: confirmobscured,
                        focusNode: confirmtextFieldFocusNode,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          isDense: true, // Reduces height a bit
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color.fromARGB(255, 58, 70, 58),
                          ),
                          labelText: "Confirm Password",
                          labelStyle: TextStyle(fontSize: 15.0),
                          errorStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 15,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: _confirmToggleObscured,
                            child: Icon(
                              confirmobscured
                                  ? Icons.visibility_rounded
                                  : Icons.visibility_off_rounded,
                              size: 24,
                              color: Color.fromARGB(255, 58, 70, 58),
                            ),
                          ),
                        ),
                        controller: confirmController,
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[a-z A-Z]').hasMatch(value)) {
                            return "Enter correct Password";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    displayName = nameController.text;
                                    phoneNumber = phoneController.text;
                                    email = emailController.text;
                                    password = passwordController.text;
                                    confirm = confirmController.text;
                                    visible = true;
                                  });
                                  registration();
                                }
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(10.0), // <-- Radius
                                ),
                                fixedSize: const Size(265, 50),
                                primary: Color.fromARGB(255, 7, 81, 6)
                                    .withOpacity(0.4),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
