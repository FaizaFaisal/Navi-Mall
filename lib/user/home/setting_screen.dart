// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:navi_mall_app/login.dart';
import 'package:navi_mall_app/services/user_service.dart';
import 'package:navi_mall_app/user/home/about.dart';
import 'package:navi_mall_app/user/home/edit_profile.dart';
import 'package:navi_mall_app/user/home/feedback.dart';
import 'package:navi_mall_app/user/home/reset_password.dart';
import 'package:navi_mall_app/colors.dart' as color;
import 'package:navi_mall_app/user/introduction/welcome_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   leading: Icon(Icons.arrow_back_ios),
      // ),
      backgroundColor: color.AppColor.homePageBackground,
      body: Container(
        padding:
            const EdgeInsets.only(top: 16, bottom: 10, left: 12, right: 12),
        decoration: BoxDecoration(border: Border.all(color: Colors.white)),
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Settings',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromARGB(255, 41, 49, 42),
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 24.0,
                  ),
                  SizedBox(width: 15),
                  Text(
                    'Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromARGB(221, 62, 123, 61),
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Divider(color: Colors.black87),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Edit Profile',
                    style: TextStyle(
                        color: Color.fromARGB(255, 41, 49, 42),
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreen(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Change Password',
                    style: TextStyle(
                        color: Color.fromARGB(255, 41, 49, 42),
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ResetPasswordScreen(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      )),
                ],
              ),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.more_outlined,
                    size: 24.0,
                  ),
                  SizedBox(width: 15),
                  Text(
                    'More',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromARGB(221, 62, 123, 61),
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Divider(color: Colors.black87),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'About',
                    style: TextStyle(
                        color: Color.fromARGB(255, 41, 49, 42),
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AboutScreen(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Send Feedback',
                    style: TextStyle(
                        color: Color.fromARGB(255, 41, 49, 42),
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const FeedbackScreen())));
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      )),
                ],
              ),
              SizedBox(height: 26),
              SizedBox(
                height: 100,
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                  onPressed: () {
                    UserService(user!.uid).logout();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (Route<dynamic> route) => route.isFirst);
                  },
                  icon: Icon(
                    Icons.logout,
                    size: 20,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
