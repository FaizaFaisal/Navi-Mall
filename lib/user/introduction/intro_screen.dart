// ignore_for_file: prefer_const_constructors

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navi_mall_app/user/introduction/intro_screen_part.dart';
import 'package:navi_mall_app/login.dart';
import 'package:navi_mall_app/user/introduction/welcome_screen.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<Widget> pages = [
    const WelcomeScreen(),
    const IntroScreen(),
  ];

  PageController controller = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  var _currPageValue = 0.0;
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        _currPageValue = controller.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            alignment: Alignment.bottomCenter,
            width: width,
            height: height,
            padding:
                const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.3), BlendMode.srcOver),
                  child: const Image(
                    image: AssetImage('assets/images/intro.png'),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  "The majority of Bahrain's malls are easily accessible to you on one platform",
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.playfairDisplay(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 84, 112, 85)),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                // DotsIndicator(
                //   dotsCount: 2,
                //   position: _currPageValue,
                //   decorator: DotsDecorator(
                //     size: const Size.square(9.0),
                //     activeSize: const Size(18.0, 9.0),
                //     activeShape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(5.0)),
                //   ),
                // ),
                SizedBox(
                  height: height * 0.02,
                ),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        ),
                        child: Text(
                          'Skip',
                          style: GoogleFonts.playfairDisplay(
                            textStyle: Theme.of(context).textTheme.headline5,
                            // fontSize: 28,
                            //fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => IntroScreenPart2(),
                          ),
                        ),
                        icon: const Icon(CupertinoIcons.arrow_right),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
