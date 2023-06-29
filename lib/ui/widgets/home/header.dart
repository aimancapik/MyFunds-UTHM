import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../theme/app_color.dart';

class Header extends StatelessWidget {
  const Header();

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    void showNotificationPopup(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Align(
            alignment: Alignment.topRight,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notification Popup',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec hendrerit sem sit amet turpis lobortis ullamcorper. Proin pulvinar odio quis tincidunt facilisis. Vestibulum posuere nisi eget dui porttitor, ut commodo lectus convallis.',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    SizedBox(height: 12.h),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Close'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('users').doc(user!.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            final String username = userData['username'] ?? '';

            return Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hello!'),
                      Text(
                        username,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: AppColor.kTitle,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showNotificationPopup(context);
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: AppColor.kPlaceholder2,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/images/noti.svg',
                            width: 16.w,
                          ),
                        ),
                      ),
                      Positioned(
                        right: -2.w,
                        top: -2.w,
                        child: Container(
                          width: 8.w,
                          height: 8.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
