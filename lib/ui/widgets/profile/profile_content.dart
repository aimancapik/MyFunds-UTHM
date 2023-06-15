import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/app_color.dart';
import 'details.dart';
import 'profile_card.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Spacer(),
        ProfileCard(),
        Spacer(),
        Details(
          title: 'Email address',
          desc: 'aimancapik@gmail.com',
        ),
        Spacer(),
        Details(
          title: 'Account ID',
          desc: '47-92768AC009',
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
}
