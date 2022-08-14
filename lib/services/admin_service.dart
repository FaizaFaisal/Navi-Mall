import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AdminService {
  final String uid;
  AdminService(this.uid);
  final CollectionReference mallCollection =
      FirebaseFirestore.instance.collection('malls');
  final storage = const FlutterSecureStorage();
  Future<void> addMall(
    String name,
    String phone,
    String web,
    String insta,
    String facebook,
    String open,
    String close,
    String about,
    GeoPoint location,
  ) async {
    return await mallCollection
        .doc(name)
        .set(
          {
            'name': name,
            'phone': phone,
            'website': web,
            'instagram': insta,
            'facebook': facebook,
            'open_hour': open,
            'close_hour': close,
            'about': about,
            'location': location,
          },
          SetOptions(merge: true),
        )
        .then((value) => print("Mall added and  merged with existing data!"))
        .catchError((error) => print("Failed to add User: $error"));
  }
}
