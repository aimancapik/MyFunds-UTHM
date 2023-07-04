import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../widgets/category.dart';
import '../../../widgets/home/header_and_notification.dart';
import 'detail_screen.dart';

class ApprovedCard {
  final String campaignTitle;
  final String fundsTarget;
  final String agreement;
  final String imageURL;
  final String description;
  final String endDate;
  final String faculty;
  final String organization;
  final String personInCharge;
  final String phoneNo;
  final String campaignType;

  ApprovedCard({
    required this.campaignTitle,
    required this.fundsTarget,
    required this.agreement,
    required this.imageURL,
    this.description = '',
    this.endDate = '',
    this.faculty = '',
    this.organization = '',
    this.personInCharge = '',
    this.phoneNo = '',
    this.campaignType = '',
  });

  static ApprovedCard fromJson(Map<String, dynamic> json) => ApprovedCard(
        campaignTitle: json['campaignTitle'],
        fundsTarget: json['fundsTarget'],
        agreement: json['agreement'],
        imageURL: json['imageURL'],
        description: json['description'],
        endDate: json['endDate'],
        faculty: json['faculty'],
        organization: json['organization'],
        personInCharge: json['personInCharge'],
        phoneNo: json['phoneNo'],
        campaignType: json['campaignType'],
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
  String selectedCategory = 'All'; // Initialize with default category 'All'

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

  Stream<List<ApprovedCard>> readAllCampaign() => FirebaseFirestore.instance
      .collection('approvedCampaign')
      .where('campaignType', isEqualTo: selectedCategory) // Add category filter
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => ApprovedCard.fromJson(doc.data()))
          .toList());

  void updateCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
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
                    color: Colors.blue,
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
              Category(updateCategory: updateCategory),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(20),
                child: Text('Featured Campaign'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0.w,
                ),
                child: StreamBuilder<List<ApprovedCard>>(
                  stream: readAllCampaign(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong! ${snapshot.error}');
                    } else if (!snapshot.hasData) {
                      return LoadingIndicator(
                        indicatorType: Indicator.ballSpinFadeLoader,
                        colors: const [Colors.blue],
                        strokeWidth: 2,
                        backgroundColor: Colors.transparent,
                        pathBackgroundColor: Colors.blueAccent,
                      );
                    } else {
                      final campaign = snapshot.data!;

                      return campaign.isEmpty
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
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: campaign.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 10.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                              approvedCard: campaign[index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Card(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Container(
                                              height: 150,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                  top: Radius.circular(12.0),
                                                ),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    campaign[index].imageURL,
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    campaign[index]
                                                        .campaignTitle,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                  SizedBox(height: 4.0),
                                                  Text(
                                                    'Target: RM${campaign[index].fundsTarget}',
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
