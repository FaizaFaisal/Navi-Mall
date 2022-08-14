// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserService {
  final String uid;
  var name = "";
  var phone = "";
  var email = "";
  UserService(this.uid);
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final storage = const FlutterSecureStorage();
  // Add new registered USER -- JOB SEEKER data to collection through function
  Future<void> addUser(
    String name,
    String phone,
    String email,
  ) async {
    return await userCollection
        .doc(uid)
        .set(
          {
            'name': name,
            'email': email,
            'phone': phone,
            'userRole': 'user',
          },
          SetOptions(merge: true),
        )
        .then((value) => print("User added and  merged with existing data!"))
        .catchError((error) => print("Failed to add User: $error"));
  }

  // USER AUTHENCTICATION FOR ACCESS
  checkUserRole() {
    FutureBuilder<DocumentSnapshot>(
      future: userCollection.doc(uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          //userRole = data['userRole'];
          // print(data['userRole']);
          return Text("${data['userRole']}");
        }

        return const Text("loading");
      },
    );
  }

  // LOGOUT
  logout() async {
    await storage.delete(key: "uid");
    await storage.delete(key: "role");
    await storage.deleteAll();
    print("Keys are deleted ");
    await FirebaseAuth.instance.signOut();
  }
}
