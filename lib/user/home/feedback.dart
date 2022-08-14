// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navi_mall_app/colors.dart' as color;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  late final _ratingController;
  late double _rating;

  double _userRating = 3.0;
  int _ratingBarMode = 1;
  double _initialRating = 2.0;
  bool _isRTLMode = false;
  bool _isVertical = false;

  IconData? _selectedIcon;

  @override
  void initState() {
    super.initState();
    _ratingController = TextEditingController(text: '3.0');
    _rating = _initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xffd6ddd8),
        elevation: 0,
        // leading: BackButton(
        //   color: Colors.black87,
        //   onPressed: () {
        //     //Navigator.pop(context);
        //     Navigator.of(context).pop();
        //   },
        // ),
        title: Text(
          "NaviMall",
          style: GoogleFonts.playfairDisplay(
            textStyle: Theme.of(context).textTheme.headline5,
            fontSize: 25,
            color: Color.fromARGB(255, 41, 49, 42),
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      backgroundColor: color.AppColor.homePageBackground,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding:
            const EdgeInsets.only(top: 40, left: 15, right: 15, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'How would you rate the accuracy of our maps?',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(height: 25),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  unratedColor: Colors.grey.shade300,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    if (kDebugMode) {
                      print(rating);
                    }
                  },
                ),
                SizedBox(height: 25),
                Text(
                  'Did we improve your shopping experience?',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(height: 25),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  unratedColor: Colors.grey.shade300,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    if (kDebugMode) {
                      print(rating);
                    }
                  },
                ),
                SizedBox(height: 25),
                Text(
                  'Was our navigation clear and easy to follow?',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(height: 25),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  unratedColor: Colors.grey.shade300,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 32,
                  ),
                  onRatingUpdate: (rating) {
                    if (kDebugMode) {
                      print(rating);
                    }
                  },
                ),
                SizedBox(height: 25),
                Text(
                  'Was our app intuiative and easy to use ?',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(height: 25),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  unratedColor: Colors.grey.shade300,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    if (kDebugMode) {
                      print(rating);
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 7, 81, 6).withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text("Save",
                              style: GoogleFonts.lato(
                                  color: Colors.white, fontSize: 20))),
                    ),
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