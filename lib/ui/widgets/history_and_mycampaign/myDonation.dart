import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/app_color.dart';

enum DonationSortOrder {
  HighestAmount,
  Latest,
}

class MyDonationPage extends StatefulWidget {
  @override
  _MyDonationPageState createState() => _MyDonationPageState();
}

class _MyDonationPageState extends State<MyDonationPage> {
  DonationSortOrder _sortOrder = DonationSortOrder.Latest;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // Remove back button
        title: Text('MyDonations',style:TextStyle(fontWeight: FontWeight.bold) ,),
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: _toggleSortOrder,
          ),
          _buildSortIndicator(),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple], // Change colors as desired
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('history')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final donationHistory = snapshot.data?.docs ?? [];

            if (donationHistory.isEmpty) {
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/activity.svg',
                      width: 120.w,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      'There is no latest activity',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColor.kForthColor,
                              ),
                    ),
                    SizedBox(
                      width: 200.w,
                      child: Text(
                        'There is no activity right now, start donate and spread your love with others.',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: AppColor.kForthColor,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            }

       donationHistory.sort((a, b) {
  if (_sortOrder == DonationSortOrder.HighestAmount) {
    final valueA = double.tryParse(a['value'] as String) ?? 0;
    final valueB = double.tryParse(b['value'] as String) ?? 0;
    return valueB.compareTo(valueA);
  } else {
    return a.id.compareTo(b.id); // Invert the comparison order
  }
});



            return ListView.builder(
              itemCount: donationHistory.length,
              itemBuilder: (context, index) {
                final donationData =
                    donationHistory[index].data() as Map<String, dynamic>?;

                if (donationData == null) {
                  return SizedBox.shrink();
                }

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: Colors.white.withOpacity(0.8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      donationData['campaignTitle'] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Organization: ${donationData['organizer']}',
                    ),
                    trailing: Text(
                      'RM${donationData['value']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildSortIndicator() {
    IconData iconData;
    if (_sortOrder == DonationSortOrder.HighestAmount) {
      iconData = Icons.sort_by_alpha;
    } else {
      iconData = Icons.access_time;
    }

    return Padding(
      padding: EdgeInsets.only(right: 16),
      child: Icon(
        iconData,
        color: Colors.white,
      ),
    );
  }

  void _toggleSortOrder() {
    setState(() {
      _sortOrder = _sortOrder == DonationSortOrder.HighestAmount
          ? DonationSortOrder.Latest
          : DonationSortOrder.HighestAmount;
    });
  }
}
