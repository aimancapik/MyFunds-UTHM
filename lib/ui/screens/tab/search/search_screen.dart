import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myfundsuthm/models/result.dart';

import '../../../../theme/app_animation.dart';
import '../../../../theme/app_color.dart';
import '../../../widgets/category.dart';
import '../../../widgets/search/intro_card.dart';
import '../../../widgets/search/result_card.dart';

class DetailCampaign {
  final String campaignTitle;
  final String fundsTarget;
  final String description;
  final String faculty;
  final String startDate;
  final String campaignType;
  final String organization;
  final String phoneNo;
  final String endDate;
  final String personInCharge;
  final String recipients;

  DetailCampaign({
    required this.campaignTitle,
    required this.fundsTarget,
    required this.description,
    required this.faculty,
    required this.organization,
    required this.phoneNo,
    required this.endDate,
    required this.personInCharge,
    required this.recipients,
    required this.startDate,
    required this.campaignType,
  });

  Map<String, dynamic> toJson() => {
        'campaignTitle': campaignTitle,
        'fundsTarget': fundsTarget,
        'campaignType': campaignType,
        'description': description,
        'phoneNo': phoneNo,
        'endDate': endDate,
        'personInCharge': personInCharge,
        'recipients': recipients,
        'organization': organization,
        'startDate': startDate,
        'faculty': faculty,
      };

  static DetailCampaign fromJson(Map<String, dynamic> json) => DetailCampaign(
        campaignTitle: json['campaignTitle'],
        fundsTarget: json['fundsTarget'],
        campaignType: json['campaignType'],
        description: json['description'],
        phoneNo: json['phoneNo'],
        endDate: json['endDate'],
        personInCharge: json['personInCharge'],
        recipients: json['recipients'],
        startDate: json['startDate'],
        faculty: json['faculty'],
        organization: json['organization'],
      );
}

class SearchScreen extends StatefulWidget {
  const SearchScreen();

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController controller;
  bool isSearching = false;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  Widget _buildResult() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Showing search result \'${controller.text}\'',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('requests').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong! ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else {
                final campaignDocs = snapshot.data!.docs;

                final filteredCampaigns = campaignDocs
                    .where((doc) =>
                        doc['campaignTitle']
                            .toString()
                            .toLowerCase()
                            .contains(controller.text.toLowerCase()) ||
                        doc['description']
                            .toString()
                            .toLowerCase()
                            .contains(controller.text.toLowerCase()))
                    .toList();

                return Column(
                  children: filteredCampaigns.map((doc) {
                    final campaignData = doc.data() as Map<String, dynamic>;
                    final campaign = DetailCampaign.fromJson(campaignData);

                    return Column(
                      children: [
                        ResultCard(
                          campaign.campaignTitle as Result,
                          campaign.description,
                          campaign.fundsTarget,
                          campaign.faculty,
                          campaign.startDate,
                          campaign.campaignType,
                          campaign.organization,
                          campaign.phoneNo,
                          campaign.endDate,
                          campaign.personInCharge,
                          campaign.recipients,
                        ),
                        SizedBox(
                          height: 32.h,
                        )
                      ],
                    );
                  }).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearching(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Category(),
        SizedBox(
          height: 16.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0.w,
          ),
          child: IntroCard(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: AnimatedSwitcher(
                duration: AppAnimation.kAnimationDuration,
                switchInCurve: AppAnimation.kAnimationCurve,
                switchOutCurve: Curves.easeInOutBack,
                child: !isSearching
                    ? Text(
                        'Explore',
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      )
                    : Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSearching = false;
                              });
                            },
                            child: SizedBox(
                              width: 24.w,
                              child: SvgPicture.asset(
                                'assets/images/back.svg',
                                width: 24.w,
                                color: AppColor.kTitle,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Search Result',
                              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                    color: AppColor.kTitle,
                                    fontWeight: FontWeight.bold,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            width: 24.w,
                          )
                        ],
                      ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: TextField(
                controller: controller,
                onTap: () {
                  setState(() {
                    isSearching = true;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Donate for ...',
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            !isSearching ? _buildSearching(context) : _buildResult(),
          ],
        ),
      ),
    );
  }
}
