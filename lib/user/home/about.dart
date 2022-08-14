// ignore_for_file: unused_import, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navi_mall_app/colors.dart' as color;
import 'package:google_fonts/google_fonts.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffd6ddd8),
        elevation: 0,
        centerTitle: true,
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
      body: Container(
        padding:
            const EdgeInsets.only(top: 20, bottom: 10, left: 12, right: 12),
        decoration: BoxDecoration(border: Border.all(color: Colors.white)),
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                child: Text(
                  ' About us ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: color.AppColor.mainText,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const Divider(color: Colors.black87),
              SizedBox(height: height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 2),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 20),
                      child: Text(
                        'NaviMall is a mobile application that strives to provide a better experience for mall visitors in Bahrain.\n The most popular malls are gathered under one platform with an outstanding features to help you enjoy your visit and simply explore malls all across the kingdom of Bahrain.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: color.AppColor.subText,
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
