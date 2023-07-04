import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../screens/initial/welcome_screen.dart';
import 'MyCampaignScreen.dart';
import 'details.dart';
import 'profile_card.dart';

class ProfileContent extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ProfileContent();

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;

    String email = user?.email ?? '';
    String accountId = user?.uid ?? '';

    return FutureBuilder<String?>(
      future: firestoreService.getEmail(accountId),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.hasError) {
          // Handle the error case
          return Text('Error: ${snapshot.error}');
        } else {
          // Retrieve the email from the snapshot data
          String emailFromFirestore = snapshot.data ?? '';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(flex: 2),
              ProfileCard(),
              SizedBox(height: 40),
              Details(
                title: 'Email address',
                desc: emailFromFirestore,
              ),
              SizedBox(height: 30),
              Details(
                title: 'Account ID',
                desc: accountId,
              ),
              SizedBox(height: 30),
              Details(
                title: 'Version',
                desc: '1.0.0',
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.blue,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(
                    Size(double.infinity, 56),
                  ),
                ),
                onPressed: () {
                  // Open "MyCampaign" screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyCampaignScreen(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons
                        .campaign), // Replace with desired icon for "MyCampaign"
                    SizedBox(width: 8),
                    Text('MyCampaign'),
                  ],
                ),
              ),
              SizedBox(height: 10), // Add spacing between buttons
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.blue,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(
                    Size(double.infinity, 56),
                  ),
                ),
                onPressed: () {
                  logout();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/logout.svg',
                    ),
                    SizedBox(width: 8),
                    Text('Logout'),
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

  Future<void> logout() async {
    try {
      await _auth.signOut();
      Get.offAll(() => WelcomeScreen());
    } catch (e) {
      // Handle any errors that occur during sign out
      print('Error during logout: $e');
    }
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



// Container(
//                 height: 340.h,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(16.r),
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: AppColor.kPlaceholder1,
//                         offset: Offset(0, 4),
//                         blurRadius: 15,
//                       )
//                     ]),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Expanded(
//                       child: Padding(
//                         padding: EdgeInsets.all(8.0.w),
//                         child: Stack(
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8.r),
//                                 color: AppColor.kPlaceholder1,
//                               ),
//                               child: Center(
//                                 child: Image.asset(
//                                   'assets/images/dermakilat.png',
//                                   width: 500.w,
//                                   height: 300.h,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                                 bottom: 8.w,
//                                 right: 8.w,
//                                 child: Container(
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 16.w, vertical: 8.h),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(4.r),
//                                     color: AppColor.kForthColor,
//                                   ),
//                                   child: Text(
//                                     'Culture & arts',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ))
//                           ],
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                         child: Padding(
//                       padding: EdgeInsets.only(
//                         bottom: 16.h,
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             width: 250.w,
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 8.w,
//                             ),
//                             child: Text(
//                               'Bantu Derma Kilat Anak Yatim',
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .titleLarge!
//                                   .copyWith(
//                                     color: Colors.blue,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                             ),
//                           ),
//                           Divider(),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               Column(
//                                 children: [
//                                   Text(
//                                     '\RM187.50',
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .titleLarge!
//                                         .copyWith(
//                                           color: Colors.blue,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                   ),
//                                   Text(
//                                     'Raised',
//                                     style: TextStyle(
//                                       color: AppColor.kTextColor1,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               // Percentage Indicatior
//                               CircularPercentIndicator(
//                                 radius: 32.0,
//                                 lineWidth: 10.0,
//                                 percent: 0.75,
//                                 center: new Text("75%"),
//                                 progressColor: Colors.green,
//                               ),
//                               Column(
//                                 children: [
//                                   Text(
//                                     '\RM250.00',
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .titleLarge!
//                                         .copyWith(
//                                           color: Colors.blue,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                   ),
//                                   Text(
//                                     'Target',
//                                     style: TextStyle(
//                                       color: AppColor.kTextColor1,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               // Edit Campaign Button
//                               // ElevatedButton.icon(
//                               //     style: ButtonStyle(
//                               //       backgroundColor:
//                               //           MaterialStateProperty.all<Color>(Colors.blue),
//                               //     ),
//                               //     onPressed: onTap,
//                               //     icon: Icon(Icons.edit),
//                               //     label: Text('Edit')),
//                             ],
//                           )
//                         ],
//                       ),
//                     ))
//                   ],
//                 ),
//               ),