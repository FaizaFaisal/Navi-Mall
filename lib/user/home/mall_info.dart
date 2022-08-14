// ignore_for_file: unnecessary_const, prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navi_mall_app/colors.dart' as color;
import 'package:getwidget/getwidget.dart';
import 'package:navi_mall_app/user/home/map.dart';
import 'package:navi_mall_app/utils/polyline.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class MallInfoScreen extends StatefulWidget {
  final String name;
  final String photoURL;
  final String open_hour;
  final String close_hour;
  final String facebook;
  final String phone;
  final String instagram;
  final String website;
  final String about;
  const MallInfoScreen(
      {required this.name,
        required this.photoURL,
        required this.open_hour,
        required this.close_hour,
        required this.facebook,
        required this.phone,
        required this.instagram,
        required this.website,
        required this.about});

  @override
  State<MallInfoScreen> createState() => _MallInfoScreenState();
}

class _MallInfoScreenState extends State<MallInfoScreen> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.AppColor.homePageBackground,
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
          widget.name,
          style: GoogleFonts.playfairDisplay(
            textStyle: Theme.of(context).textTheme.headline5,
            fontSize: 25,
            color: Colors.black87,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      backgroundColor: color.AppColor.homePageBackground,
      body: ListView(
        children: [
          Stack(
            children: [
              Image(
                  image: NetworkImage(widget.photoURL),
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover),
              Positioned(
                // The Positioned widget is used to position the text inside the Stack widget
                bottom: 10,
                left: 10,

                child: Container(
                  // We use this Container to create a black box that wraps the white text so that the user can read the text even when the image is white
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black87.withOpacity(0.4),
                  padding: const EdgeInsets.all(8),

                  child: Row(
                    children: [
                      Text(
                        widget.open_hour,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.lightBlue),
                      ),
                      const SizedBox(width: 5),
                      const SizedBox(
                        child: Text(
                          '-',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        widget.close_hour,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Link(
                target: LinkTarget.blank,
                uri: Uri.parse(widget.facebook),
                builder: (context, followLink) => GFIconButton(
                  shape: GFIconButtonShape.circle,
                  onPressed: followLink,
                  icon: const Icon(FontAwesomeIcons.facebook),
                  color: const Color(0xff3b5998),
                ),
              ),
              const SizedBox(width: 10),
              Link(
                target: LinkTarget.blank,
                uri: Uri.parse(''),
                builder: (context, followLink) => GFIconButton(
                  shape: GFIconButtonShape.pills,
                  onPressed: () async {
                    await FlutterLaunch.launchWhatsapp(
                        phone: widget.phone, message: '');
                  },
                  icon: const Icon(FontAwesomeIcons.whatsapp),
                  color: GFColors.SUCCESS,
                ),
              ),
              const SizedBox(width: 10),
              Link(
                target: LinkTarget.blank,
                uri: Uri.parse(widget.instagram),
                builder: (context, followLink) => GFIconButton(
                    shape: GFIconButtonShape.pills,
                    color: const Color(0xffFCAF45),
                    icon: const Icon(FontAwesomeIcons.instagram),
                    onPressed: followLink),
              ),
              const SizedBox(width: 10),
              Link(
                target: LinkTarget.blank,
                uri: Uri.parse(widget.website),
                builder: (context, followLink) => GFButton(
                  onPressed: followLink,
                  shape: GFButtonShape.pills,
                  type: GFButtonType.outline2x,
                  color: GFColors.INFO,
                  child: Text('Website',
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              widget.about,
              style: GoogleFonts.lato(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => {
              Navigator.of(context).push(
              MaterialPageRoute(
              builder: (context) => PolyLine(),
              ),
              )
            },
            child: Text(
              'View Map ',
              style: GoogleFonts.lato(fontSize: 18, color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
              fixedSize: Size(100, 45),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}