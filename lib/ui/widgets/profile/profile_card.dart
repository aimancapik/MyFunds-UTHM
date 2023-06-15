import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../bloc/profile/profile_bloc.dart';
import '../../../theme/app_color.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard();

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  String? userId;
  String? username;
  String? phoneNumber;
  String? profileImage;

  @override
  void initState() {
    super.initState();
    getCurrentUserId();
    fetchUserProfile();
  }

  void getCurrentUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userId = user.uid;
      });
    }
  }

  Future<void> fetchUserProfile() async {
    if (userId != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('users').doc(userId!).get();

      if (snapshot.exists) {
        Map<String, dynamic> userData = snapshot.data()!;
        setState(() {
          username = userData['username'];
          phoneNumber = userData['phone'];
          profileImage = userData['profileImage'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 80.w,
          width: 80.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: AppColor.kBlue,
          ),
          child: (profileImage != null)
              ? Image.network(
                  profileImage!,
                  width: 80.w,
                  height: 80.w,
                  fit: BoxFit.cover,
                )
              : Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 40.sp,
                ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username ?? '',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                phoneNumber ?? '',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: AppColor.kTextColor1,
                    ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => BlocProvider.of<ProfileBloc>(context).add(SetEdit()),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 8.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: AppColor.kPlaceholder2,
            ),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 14.sp,
              color: AppColor.kTextColor1,
            ),
          ),
        ),
      ],
    );
  }
}
