import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navi_mall_app/user/introduction/intro_screen.dart';
import 'package:navi_mall_app/login.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
                      Color.fromARGB(255, 255, 255, 255).withOpacity(0.4),
                      BlendMode.srcOver),
                  child: const Image(
                    image: AssetImage('assets/images/welcome.png'),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  "Welcome to NaviMall",
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.playfairDisplay(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 84, 112, 85)),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                // // Positioned(
                // //   left: 0.0,
                // //   right: 0.0,
                // //   bottom: 0.0,
                // //   child: Padding(
                // //     padding: const EdgeInsets.all(8.0),
                // //     child: CirclePageIndicator(
                // //       itemCount: pages.length,
                // //       currentPageNotifier: _currentPageNotifier,
                // //     ),
                // //   ),
                // // ),
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
                            builder: (context) => IntroScreen(),
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
