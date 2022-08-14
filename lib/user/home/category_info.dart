// ignore_for_file: unused_local_variable, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navi_mall_app/colors.dart' as color;
import 'dart:developer' as developer;

import 'package:navi_mall_app/user/home/view_section_stores.dart';

class CategoryInfoScreen extends StatefulWidget {
  const CategoryInfoScreen({Key? key}) : super(key: key);

  @override
  State<CategoryInfoScreen> createState() => _CategoryInfoScreenState();
}

class _CategoryInfoScreenState extends State<CategoryInfoScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 5, vsync: this);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.AppColor.homePageBackground,
        elevation: 1,
        centerTitle: true,
        leading: BackButton(
          color: Colors.black87,
          onPressed: () {
            //Navigator.pop(context);
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Categories",
          style: GoogleFonts.roboto(
            textStyle: Theme.of(context).textTheme.headline5,
            fontSize: 25,
            color: Color.fromARGB(255, 84, 112, 85),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: color.AppColor.homePageBackground,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),
            TabBar(
                isScrollable: true,
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: color.AppColor.buttons,
                labelStyle: const TextStyle(
                  fontSize: 18,
                ),
                // ignore: prefer_const_literals_to_create_immutables
                tabs: [
                  categoryItem(Icons.shopping_bag, 'Shopping',
                      Color.fromARGB(255, 77, 168, 92)),
                  categoryItem(Icons.dining, 'Dining',
                      Color.fromARGB(255, 113, 125, 70)),
                  categoryItem(Icons.attractions, 'Attractions',
                      Color.fromARGB(255, 187, 114, 85)),
                  categoryItem(
                      Icons.event, 'Events', Color.fromARGB(255, 158, 185, 76)),
                  categoryItem(
                      Icons.wash, 'Services', Color.fromARGB(255, 122, 96, 45)),
                ]),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                height: double.maxFinite,
                color: color.AppColor.homePageBackground,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView(
                      padding:
                          EdgeInsets.only(top: 5, bottom: 5, left: 3, right: 3),
                      children: [
                        getCategorySectionItem(
                            Icons.money,
                            'Banks & Financial Services',
                            Color.fromARGB(187, 186, 104, 60),
                            Color.fromARGB(182, 238, 245, 212)),
                        Divider(thickness: 0.5, color: color.AppColor.gray),
                        getCategorySectionItem(
                            Icons.book,
                            'Books / Stationery / Toys / Games ',
                            Color.fromARGB(255, 74, 98, 83),
                            Color.fromARGB(71, 128, 204, 136)),
                        Divider(thickness: 0.5, color: color.AppColor.gray),
                        getCategorySectionItem(
                            Icons.home,
                            'Electronics / Home Appliances',
                            Color.fromARGB(141, 8, 88, 60),
                            Color.fromARGB(182, 238, 245, 212)),
                        Divider(thickness: 0.5, color: color.AppColor.gray),
                        getCategorySectionItem(
                            Icons.girl,
                            'Fashion / Accessories / Handbags / Shoes',
                            Color.fromARGB(187, 90, 102, 91),
                            Color.fromARGB(208, 220, 225, 201)),
                        Divider(thickness: 0.5, color: color.AppColor.gray),
                        getCategorySectionItem(
                            Icons.light,
                            'Household / Furniture / Carpets',
                            Color.fromARGB(255, 118, 173, 110),
                            Color.fromARGB(88, 202, 246, 202)),
                        Divider(thickness: 0.5, color: color.AppColor.gray),
                        getCategorySectionItem(
                            Icons.breakfast_dining,
                            'Hypermarket',
                            Color.fromARGB(141, 8, 88, 60),
                            Color.fromARGB(182, 238, 245, 212)),
                        Divider(thickness: 0.5, color: color.AppColor.gray),
                        getCategorySectionItem(
                            Icons.watch,
                            'Jewellery & Watches',
                            Color.fromARGB(186, 235, 131, 75),
                            Color.fromARGB(182, 238, 245, 212)),
                        Divider(thickness: 0.5, color: color.AppColor.gray),
                        getCategorySectionItem(
                            Icons.beach_access,
                            'Lingerie / Swimwear',
                            Color.fromARGB(187, 90, 102, 91),
                            Color.fromARGB(208, 220, 225, 201)),
                        Divider(thickness: 0.5, color: color.AppColor.gray),
                        getCategorySectionItem(
                            Icons.hourglass_empty_rounded,
                            'Optics / Sunglasses',
                            Color.fromARGB(141, 8, 88, 60),
                            Color.fromARGB(182, 238, 245, 212)),
                        Divider(thickness: 0.5, color: color.AppColor.gray),
                        getCategorySectionItem(
                            Icons.local_pharmacy,
                            'Pharmacies / Health/ Cosmetics / Perfumes',
                            Color.fromARGB(187, 186, 104, 60),
                            Color.fromARGB(182, 238, 245, 212)),
                        Divider(thickness: 0.5, color: color.AppColor.gray),
                      ],
                    ),
                    ListView(
                      padding:
                          EdgeInsets.only(top: 5, bottom: 5, left: 3, right: 3),
                      children: [
                        getCategorySectionItem(
                            Icons.food_bank,
                            'Arabic cuisine ',
                            Color.fromARGB(187, 186, 104, 60),
                            Color.fromARGB(182, 238, 245, 212)),
                        Divider(thickness: 0.5, color: color.AppColor.gray),
                        getCategorySectionItem(
                            Icons.restaurant_sharp,
                            'Asian',
                            Color.fromARGB(255, 74, 98, 83),
                            Color.fromARGB(71, 128, 204, 136)),
                        Divider(thickness: 0.5, color: color.AppColor.gray),
                        getCategorySectionItem(
                            Icons.restaurant_menu,
                            'International',
                            Color.fromARGB(187, 90, 102, 91),
                            Color.fromARGB(208, 220, 225, 201)),
                        Divider(thickness: 0.5, color: color.AppColor.gray),
                        getCategorySectionItem(
                            Icons.motorcycle_rounded,
                            'Fast food',
                            Color.fromARGB(255, 118, 173, 110),
                            Color.fromARGB(88, 202, 246, 202)),
                        Divider(thickness: 0.5, color: color.AppColor.gray),
                        getCategorySectionItem(
                            Icons.coffee,
                            'Cafe',
                            Color.fromARGB(186, 235, 131, 75),
                            Color.fromARGB(182, 238, 245, 212)),
                        Divider(thickness: 0.5, color: color.AppColor.gray),
                      ],
                    ),
                    ListView(
                      padding:
                          EdgeInsets.only(top: 5, bottom: 5, left: 3, right: 3),
                      children: [
                        getCategorySectionItem(
                            Icons.movie,
                            'Cinema',
                            Color.fromARGB(187, 186, 104, 60),
                            Color.fromARGB(182, 238, 245, 212)),
                        Divider(thickness: 0.5, color: color.AppColor.gray),
                        getCategorySectionItem(
                            Icons.theater_comedy,
                            'Other attractions',
                            Color.fromARGB(255, 118, 173, 110),
                            Color.fromARGB(88, 202, 246, 202)),
                        Divider(thickness: 0.5, color: color.AppColor.gray),
                      ],
                    ),
                    ListView(
                      padding:
                          EdgeInsets.only(top: 5, bottom: 5, left: 3, right: 3),
                      children: [
                        getCategorySectionItem(
                            Icons.event,
                            'Trending Events happening now',
                            Color.fromARGB(187, 186, 104, 60),
                            Color.fromARGB(182, 238, 245, 212)),
                        Divider(thickness: 0.5, color: color.AppColor.gray),
                      ],
                    ),
                    ListView(
                      padding:
                          EdgeInsets.only(top: 5, bottom: 5, left: 3, right: 3),
                      children: [
                        getCategorySectionItem(
                            Icons.family_restroom,
                            'Bathroom',
                            Color.fromARGB(187, 186, 104, 60),
                            Color.fromARGB(182, 238, 245, 212)),
                        Divider(thickness: 0.5, color: color.AppColor.gray),
                        getCategorySectionItem(
                            Icons.local_taxi,
                            'Taxi gate',
                            Color.fromARGB(255, 74, 98, 83),
                            Color.fromARGB(71, 128, 204, 136)),
                        Divider(thickness: 0.5, color: color.AppColor.gray),
                        getCategorySectionItem(
                            Icons.atm,
                            'ATM',
                            Color.fromARGB(141, 8, 88, 60),
                            Color.fromARGB(182, 238, 245, 212)),
                        Divider(thickness: 0.5, color: color.AppColor.gray),
                        getCategorySectionItem(
                            Icons.info_rounded,
                            'Information center',
                            Color.fromARGB(141, 8, 88, 60),
                            Color.fromARGB(182, 238, 245, 212)),
                        Divider(thickness: 0.5, color: color.AppColor.gray),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  categoryItem(IconData category_icon, String text, Color color_icon) {
    return Column(
      children: [
        Container(
          height: 80,
          width: 85,
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17),
            ),
            child: Icon(
              category_icon,
              size: 35,
              color: color_icon,
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          text,
          style: GoogleFonts.lato(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: color.AppColor.matteBlack),
        ),
      ],
    );
  }

  getCategorySectionItem(IconData section_icon, String section,
      Color icon_color, Color container_color) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ViewSectionStores(
              section: section,
            ),
          ),
        );
      },
      child: ListTile(
        leading: Container(
          height: 120,
          width: 85,
          decoration:
              BoxDecoration(color: container_color, shape: BoxShape.circle),
          child: Icon(
            section_icon,
            size: 28,
            color: icon_color,
          ),
        ),
        title: Text(
          section,
          style: GoogleFonts.lato(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: color.AppColor.matteBlack),
        ),
      ),
    );
  }
}
