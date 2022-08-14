import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:navi_mall_app/admin/view_all_mall.dart';
import 'package:navi_mall_app/user/home/home.dart';

class CheckRole extends StatefulWidget {
  const CheckRole({Key? key}) : super(key: key);

  @override
  _CheckRoleState createState() => _CheckRoleState();
}

class _CheckRoleState extends State<CheckRole> {
  final storage = const FlutterSecureStorage();
  Future<String> checkRoleStatus() async {
    String? value = await storage.read(key: "role");
    if (value == "user") {
      // Not logged in and then check role
      return "user";
    }
    return "admin";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkRoleStatus(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (kDebugMode) {
          print("Snapshot \t ${snapshot.data}");
        }
        if (snapshot.data == "user") {
          return const HomeScreen();
        }
        if (snapshot.data == "admin") {
          return const ViewAllMallScreen();
        }
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return Container(
        //     color: Colors.white,
        //     width: MediaQuery.of(context).size.width,
        //     height: MediaQuery.of(context).size.height,
        //     child: Center(
        //       child: CircularProgressIndicator(
        //         color: Colors.blueAccent.shade700,
        //       ),
        //     ),
        //   );
        // }
        return Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.blueAccent.shade700,
            ),
          ),
        );
      },
    );
  }
}
