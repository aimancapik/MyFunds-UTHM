import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myfundsuthm/ui/widgets/history_and_mycampaign/myDonation.dart';

import '../../../routes/routes.dart';
import 'home/MyHomeScreen.dart';
import 'profile/proflle_screen.dart';
import 'search/search_screen.dart';

final List<Widget> pages = [
  HomeScreen(),
  SearchScreen(),
  Scaffold(
    backgroundColor: Colors.blue,
  ),
  MyDonationPage(),
  ProfileScreen(),
];

class TabScreen extends StatefulWidget {
  const TabScreen();

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  late int tabIndex;

  @override
  void initState() {
    tabIndex = 0;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: SizedBox(
        child: BottomNavigationBar(
          iconSize: 24.w,
          backgroundColor: Colors.blue,
          currentIndex: tabIndex,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          onTap: (index) async {
            setState(() {
              tabIndex = index;
            });
            if (index == 2) {
              await Navigator.of(context)
                  .pushNamed(RouteGenerator.startCharity);

              setState(() {
                tabIndex = 0;
              });
            }
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          enableFeedback: true,
          items: [
            BottomNavigationBarItem(
              activeIcon: Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.withOpacity(0.5),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/category.svg',
                    width: 24.w,
                    // color: Colors.white,
                  ),
                ),
              ),
              label: '',
              icon: SvgPicture.asset(
                'assets/images/category.svg',
                width: 24.w,
                // color: AppColor.kTextColor1,
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.withOpacity(0.5),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/search.svg',
                    width: 24.w,
                    // color: Colors.white,
                  ),
                ),
              ),
              label: '',
              icon: SvgPicture.asset(
                'assets/images/search.svg',
                width: 24.w,
                // color: AppColor.kTextColor1,
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueAccent,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/add.svg',
                    width: 24.w,
                  ),
                ),
              ),
              label: '',
              icon: Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.lightBlueAccent,
                        offset: Offset(
                          0,
                          2.h,
                        ),
                        blurRadius: 5,
                      )
                    ]),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/add.svg',
                    width: 24.w,
                  ),
                ),
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.withOpacity(0.5),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/swap.svg',
                    width: 24.w,
                    // color: Colors.white,
                  ),
                ),
              ),
              label: '',
              icon: SvgPicture.asset(
                'assets/images/swap.svg',
                width: 24.w,
                // color: AppColor.kTextColor1,
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.withOpacity(0.5),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/profile.svg',
                    width: 24.w,
                    // color: Colors.white,
                  ),
                ),
              ),
              label: '',
              icon: SvgPicture.asset(
                'assets/images/profile.svg',
                width: 24.w,
                // color: AppColor.kTextColor1,
              ),
            ),
          ],
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: pages.elementAt(tabIndex),
      ),
    );
  }
}
