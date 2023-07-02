import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../theme/app_color.dart';
import '../../../widgets/category.dart';
import '../../../widgets/home/header_and_notification.dart';

class ApprovedCard {
  final String campaignTitle;
  final String fundsTarget;
  final String approved;

  ApprovedCard({
    required this.campaignTitle,
    required this.fundsTarget,
    required this.approved,
  });

  Map<String, dynamic> toJson() => {
        'campaignTitle': campaignTitle,
        'fundsTarget': fundsTarget,
        'agreement': approved,
      };

  static ApprovedCard fromJson(Map<String, dynamic> json) => ApprovedCard(
        campaignTitle: json['campaignTitle'],
        fundsTarget: json['fundsTarget'],
        approved: json['agreement'],
      );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ScrollController controller;
  double position = 0.0;
  final double oneCardWidth = 256.w;

  @override
  void initState() {
    controller = ScrollController();
    controller.addListener(() {
      setState(() {
        position = controller.offset;
      });
    });
    super.initState();
  }

  Stream<List<ApprovedCard>> readAllCampaign() {
    final dummyCard = ApprovedCard(
      campaignTitle: 'Dummy Campaign',
      fundsTarget: '1000',
      approved: 'false',
    
    );

    return FirebaseFirestore.instance
        .collection('requests')
        .snapshots()
        .map((snapshot) => [
              dummyCard,
              ...snapshot.docs
                  .map((doc) => ApprovedCard.fromJson(doc.data()))
                  .toList(),
            ]);

            
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32.r),
              bottomRight: Radius.circular(32.r),
            ),
          ),
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).viewPadding.top,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0.w,
                ),
                child: Container(
                  width: double.infinity,
                  height: 150.h,
                  decoration: BoxDecoration(
                    color: AppColor.kPrimaryColor,
                    borderRadius: BorderRadius.circular(
                      12.r,
                    ),
                  ),
                  child: Center(
                    child: Stack(
                      children: [
                        SvgPicture.asset('assets/images/mask_diamond.svg'),
                        Center(
                          child: Image.asset(
                            'assets/images/Logo.png',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Category(),
              SizedBox(height: 10),
              Container(padding: EdgeInsets.all(20), child: Text('Featured Campaign')),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0.w,
                ),
                child: SingleChildScrollView(
                  child: StreamBuilder<List<ApprovedCard>>(
                    stream: readAllCampaign(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong! ${snapshot.error}');
                      } else if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      } else {
                        final campaign = snapshot.data!;

                        final filteredCampaigns = campaign.where((card) => card.approved == 'false').toList();

                        return filteredCampaigns.isEmpty
                            ? SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: Center(
                                  child: Text(
                                    'Sorry, there are no campaigns at the moment.',
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: GridView.builder(
                                  padding: EdgeInsets.zero,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1.5,
                                    crossAxisSpacing: 10.0,
                                    mainAxisSpacing: 10.0,
                                  ),
                                  itemCount: filteredCampaigns.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            color: Colors.grey, // Placeholder color
                                            // Replace the placeholder image path with your actual image path
                                            child: SvgPicture.asset(
                                              'assets/images/image_placeholder.svg',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(height: 8.0),
                                          Text(
                                            filteredCampaigns[index].campaignTitle,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10.0,
                                            ),
                                          ),
                                          SizedBox(height: 8.0),
                                          Text(
                                            'Target: \RM${filteredCampaigns[index].fundsTarget}',
                                            style: TextStyle(fontSize: 8.0),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
