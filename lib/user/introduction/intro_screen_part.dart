// ignore_for_file: unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navi_mall_app/login.dart';

class IntroScreenPart2 extends StatefulWidget {
  const IntroScreenPart2({Key? key}) : super(key: key);

  @override
  State<IntroScreenPart2> createState() => _IntroScreenPart2State();
}

class _IntroScreenPart2State extends State<IntroScreenPart2> {
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
                    image: AssetImage('assets/images/locator.png'),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  "Get the fastest route to your favorite stores, search for a certain store, and many more.",
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
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        ),
                        child: Text(
                          'Get Started',
                          style: GoogleFonts.roboto(
                            textStyle: Theme.of(context).textTheme.headline5,
                            color: Colors.white,
                            //fontSize: 26,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10.0), // <-- Radius
                          ),
                          //shape: StadiumBorder(),
                          primary:
                              Color.fromARGB(255, 7, 81, 6).withOpacity(0.4),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.01,
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
