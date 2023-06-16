import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../theme/app_color.dart';
import 'details.dart';
import 'profile_card.dart';

class ProfileContent extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();

  ProfileContent();

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    String email = user?.email ?? '';
    String accountId = user?.uid ?? '';

    return FutureBuilder<String?>(
      future: firestoreService.getEmail(accountId),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while retrieving data from Firestore
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Handle the error case
          return Text('Error: ${snapshot.error}');
        } else {
          // Retrieve the email from the snapshot data
          String emailFromFirestore = snapshot.data ?? '';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              ProfileCard(),
              Spacer(),
              Details(
                title: 'Email address',
                desc: emailFromFirestore,
              ),
              Spacer(),
              Details(
                title: 'Account ID',
                desc: accountId,
              ),
              Spacer(),
              Details(
                title: 'Version',
                desc: '1.0.0',
              ),
              Spacer(),
              Spacer(),
              Spacer(),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    AppColor.kPrimaryColor,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        8.r,
                      ),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(
                    Size(
                      double.infinity,
                      56.h,
                    ),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/logout.svg',
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      'Logout',
                    ),
                  ],
                ),
              ),
              Spacer(),
            ],
          );
        }
      },
    );
  }
}

class FirestoreService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<String?> getEmail(String userId) async {
    DocumentSnapshot snapshot = await usersCollection.doc(userId).get();
    if (snapshot.exists) {
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

      if (data != null) {
        return data['email'];
      }
    }
    return null;
  }
}
