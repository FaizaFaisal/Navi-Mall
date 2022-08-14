// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navi_mall_app/location_controller.dart';
import 'package:navi_mall_app/check_role.dart';
import 'package:navi_mall_app/pallete.dart';
import 'package:navi_mall_app/user/introduction/welcome_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final storage = const FlutterSecureStorage();
  Future<bool> checkLoginStatus() async {
    String? value = await storage.read(key: "uid");
    if (value == null) {
      // Not logged in
      return false;
    }
    return true; //Logged In
  }

  @override
  Widget build(BuildContext context) {
    Get.put(LocationController());

    return FutureBuilder(
      future: null,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return GetMaterialApp(
          routes: {},
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            brightness: Brightness.light,
            primaryColor: Palette.kToDark,
            primarySwatch: Palette.kToDark,
            // accentColor: Colors.white.withOpacity(1),
            // accentColorBrightness: Brightness.light),
          ),
          home: FutureBuilder(
              future: checkLoginStatus(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                // not LoggedIn
                if (snapshot.data == true) {
                  return CheckRole();
                }
                return WelcomeScreen(); // Login UI
              }),
        );
      },
    );
  }
}
