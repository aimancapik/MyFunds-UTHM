import 'package:myfundsuthm/theme/app_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../bloc/profile/profile_bloc.dart';
import '../../../widgets/profile/edit_content.dart';
import '../../../widgets/profile/profile_content.dart';
import '../../../widgets/profile/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(
              32.r,
            ),
            bottomRight: Radius.circular(
              32.r,
            ),
          ),
        ),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedSwitcher(
                    duration: AppAnimation.kAnimationDuration,
                    switchInCurve: AppAnimation.kAnimationCurve,
                    reverseDuration: Duration(milliseconds: 0),
                    child: (state is ProfileInitial || (state is ProfileHome))
                        ? Text(
                            'Profile Page',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          )
                        : ProfileHeader(),
                  ),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: AppAnimation.kAnimationDuration,
                      switchInCurve: AppAnimation.kAnimationCurve,
                      reverseDuration: Duration(milliseconds: 0),
                      child: (state is ProfileInitial || state is ProfileHome)
                          ? ProfileContent()
                          : EditContent(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
