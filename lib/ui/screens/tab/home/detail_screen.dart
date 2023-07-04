import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfundsuthm/ui/widgets/home/calculator_builder.dart';

import 'MyHomeScreen.dart';

class DetailScreen extends StatelessWidget {
  final ApprovedCard approvedCard;

  const DetailScreen({Key? key, required this.approvedCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Campaign Details'),
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('approvedCampaign')
            .doc() // Provide the document ID here
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text('No data found.'),
            );
          } else {
            // final campaign = snapshot.data!.data() as Map<String, dynamic>?;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 300.h,
                    decoration: BoxDecoration(borderRadius:BorderRadius.circular(20) ),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: Container(
                                width: double.infinity,
                                child: Image.network(
                                  approvedCard.imageURL,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Image.network(
                        approvedCard.imageURL,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(borderRadius:BorderRadius.circular(20) ),
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Text(
                                  'Category: ${approvedCard.campaignType}',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          // Campaign Title
                          Text(
                            approvedCard.campaignTitle,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          // Description
                          Text(
                            approvedCard.description,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          // Raised Amount
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/money.svg',
                                width: 18.w,
                                height: 18.h,
                                color: Colors.green,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                '0% raised of total RM${approvedCard.fundsTarget} goal',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          // Progress Bar
                          // SizedBox(
                          //   height: 4.h,
                          //   child: LinearProgressIndicator(
                          //     value: campaign?['raisedAmount'] != null &&
                          //             campaign?['targetAmount'] != null
                          //         ? (campaign?['raisedAmount'] as int) /
                          //             (campaign?['targetAmount'] as int)
                          //         : 0,
                          //     color: AppColor.kSecondaryColor,
                          //     backgroundColor: AppColor.kProgressBarBackground,
                          //   ),
                          // ),
                          SizedBox(height: 180.h),
                          // Donate Button
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.r),
                                  ),
                                  builder: (_) => CalculatorBuilder(
                                    approvedCard: approvedCard,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.kSecondaryColor,
                                padding: EdgeInsets.symmetric(
                                  vertical: 26.h,
                                  horizontal: 50.w,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                              ),
                              child: Text(
                                'Donate Now',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class AppColor {
  static const Color kSecondaryColor = Colors.blue;
  static const Color kProgressBarBackground = Colors.green;
}
