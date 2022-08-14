// ignore_for_file: prefer_const_constructors

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navi_mall_app/user/home/setting_screen.dart';
import 'package:navi_mall_app/user/home/home_body_content.dart';
import 'package:navi_mall_app/pallete.dart';
import 'package:navi_mall_app/user/home/save_parking.dart';
import 'package:navi_mall_app/colors.dart' as color;
import 'package:navi_mall_app/utils/map.dart';
import 'package:navi_mall_app/utils/polyline.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  PageController _pageController = new PageController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffd6ddd8),
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
          "NaviMall",
          style: GoogleFonts.playfairDisplay(
            textStyle: Theme.of(context).textTheme.headline5,
            fontSize: 25,
            color: Color.fromARGB(255, 41, 49, 42),
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      backgroundColor: Colors.white,
//       drawer: Drawer(
//         backgroundColor: Colors.white,
//         child: ListView(
// // Important: Remove any padding from the ListView.

//           padding: EdgeInsets.zero,

//           children: [
//             const UserAccountsDrawerHeader(
//               currentAccountPicture: CircleAvatar(
//                 backgroundImage: NetworkImage(
//                     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpE4_IvmDpxj73ggwKkjGjhv7czUCglwKgBw&usqp=CAU'),
//               ),
//               accountEmail: Text(
//                 'jane.doe@example.com',
//                 style: TextStyle(color: Colors.white),
//               ),
//               accountName: Text(
//                 'Jane Doe',
//                 style: TextStyle(fontSize: 24.0, color: Colors.white),
//               ),
//               decoration: BoxDecoration(
//                 color: Color.fromARGB(255, 156, 167, 133),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.account_circle_outlined),
//               title: const Text(
//                 'My profile',
//                 style: TextStyle(
//                     fontSize: 22.0, color: Color.fromARGB(255, 97, 129, 62)),
//               ),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.store),
//               title: const Text(
//                 'Send FeedBack',
//                 style: TextStyle(fontSize: 22.0),
//               ),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.chat),
//               title: const Text(
//                 'Contact us',
//                 style: TextStyle(fontSize: 22.0),
//               ),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             const Divider(
//               height: 10,
//               thickness: 1,
//             ),
//             ListTile(
//               leading: const Icon(Icons.logout),
//               title: const Text(
//                 'Logout',
//                 style: TextStyle(fontSize: 22.0, color: Color(0xff91a55e)),
//               ),
//               onTap: () {
// // Navigator.pushReplacement(

// // context,

// // MaterialPageRoute<void>(

// // builder: (BuildContext context) => const MyHomePage(

// // title: 'Apartments',

// // ),

// // ),

// // );
//               },
//             ),
//           ],
//         ),
//       ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            HomeBodyContentScreen(),
            PolyLine(),
            SaveParkingScreen(),
            SettingScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        showElevation: true,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              activeColor: Color.fromARGB(255, 89, 119, 90),
              title: Text('Home'),
              inactiveColor: Color.fromARGB(255, 97, 90, 90),
              icon: Icon(Icons.home)),
          BottomNavyBarItem(
              activeColor: Color.fromARGB(255, 89, 119, 90),
              title: Text('Map'),
              inactiveColor: Colors.grey,
              icon: Icon(CupertinoIcons.location)),
          BottomNavyBarItem(
              activeColor: Color.fromARGB(255, 89, 119, 90),
              title: Text('Parking'),
              inactiveColor: Colors.grey,
              icon: Icon(FontAwesomeIcons.p)),
          BottomNavyBarItem(
              activeColor: Color.fromARGB(255, 89, 119, 90),
              title: Text('Settings'),
              inactiveColor: Colors.grey,
              icon: Icon(Icons.settings)),
        ],
      ),
    );
  }
}
