// ignore_for_file: unused_import, unnecessary_import

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:navi_mall_app/user/introduction/intro_screen.dart';
import 'package:navi_mall_app/user/introduction/intro_screen_part.dart';
import 'package:navi_mall_app/user/introduction/welcome_screen.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class IntroPageBody extends StatefulWidget {
  const IntroPageBody({Key? key}) : super(key: key);

  @override
  State<IntroPageBody> createState() => _IntroPageBodyState();
}

class _IntroPageBodyState extends State<IntroPageBody> {
  List<Widget> pages = [
    const WelcomeScreen(),
    const IntroScreen(),
    const IntroScreenPart2(),
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

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PageView.builder(
                itemCount: 3,
                controller: controller,
                onPageChanged: (page) {
                  setState(() {
                    _selectedIndex = page;
                  });
                },
                itemBuilder: (context, position) {
                  return pages[position];
                }),
          ),
          // Positioned(
          //   left: 0.0,
          //   right: 0.0,
          //   bottom: 0.0,
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: CirclePageIndicator(
          //       itemCount: pages.length,
          //       currentPageNotifier: _currentPageNotifier,
          //     ),
          //   ),
          // ),
          DotsIndicator(
            dotsCount: 3,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: Colors.lightGreen.shade900,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          ),
        ],
      ),
    );
  }
}
