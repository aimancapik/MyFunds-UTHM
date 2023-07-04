import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../models/campaign.dart';
import '../../../../routes/routes.dart';
import '../../../widgets/campaign/category_card.dart';
import '../../../widgets/campaign/campaign_screen_path.dart';

class StartCampaign extends StatefulWidget {
  const StartCampaign();

  @override
  _StartCampaignState createState() => _StartCampaignState();
}

class _StartCampaignState extends State<StartCampaign> {
  String? selectedCampaign;
  bool isFormCompleted = false;

  void saveCampaignType(String campaignType) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid; // Get the user ID

      FirebaseFirestore.instance.collection('requests').doc(userId).set({
        'userId': userId, // Set the user ID in the document
        'campaignType': campaignType
      });
    }
  }

  void deleteRequest() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('requests')
          .doc(user.uid)
          .update({'userId': null, 'campaignType': null});
    }
  }

  Future<bool> _onWillPop() async {
    if (!isFormCompleted) {
      return true; // Allow navigating back without showing the confirmation dialog
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Discard Changes'),
        content: Text('Are you sure you want to discard your changes?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              deleteRequest(); // User confirmed to discard changes
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pop(false); // User canceled, stay on the page
            },
            child: Text('No'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      deleteRequest();
      navigateToHomePage(); // Navigate to the home page
    }

    return confirmed ?? false;
  }

  void navigateToHomePage() {
    Navigator.of(context).pushNamed(RouteGenerator
        .main); // Replace 'RouteGenerator.home' with the actual route name for the home page
  }

  void navigateToNextPage() {
    if (selectedCampaign == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Select Campaign Type',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
              'Please choose a campaign type before going to the next step.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      selectedCampaign = selectedCampaign;
      Navigator.of(context).pushNamed(RouteGenerator.stepOne);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0.w,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        32.r,
                      ),
                      color: Colors.white,
                    ),
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start a Campaign',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          SizedBox(
                            width: 0.7.sw,
                            child: Text(
                              'Choose the type of your fundraising program',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CategoryCard(
                                campaign[0],
                                onTap: () {
                                  setState(() {
                                    selectedCampaign = campaign[0].name;
                                    isFormCompleted = true;
                                  });
                                  saveCampaignType(campaign[0].name);
                                },
                                isSelected:
                                    selectedCampaign == campaign[0].name,
                              ),
                              SizedBox(
                                width: 45.w,
                              ),
                              CategoryCard(
                                campaign[1],
                                onTap: () {
                                  setState(() {
                                    selectedCampaign = campaign[1].name;
                                    isFormCompleted = true;
                                  });
                                  saveCampaignType(campaign[1].name);
                                },
                                isSelected:
                                    selectedCampaign == campaign[1].name,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CategoryCard(
                                campaign[2],
                                onTap: () {
                                  setState(() {
                                    selectedCampaign = campaign[2].name;
                                    isFormCompleted = true;
                                  });
                                  saveCampaignType(campaign[2].name);
                                },
                                isSelected:
                                    selectedCampaign == campaign[2].name,
                              ),
                              SizedBox(
                                width: 45.w,
                              ),
                              CategoryCard(
                                campaign[3],
                                onTap: () {
                                  setState(() {
                                    selectedCampaign = campaign[3].name;
                                    isFormCompleted = true;
                                  });
                                  saveCampaignType(campaign[3].name);
                                },
                                isSelected:
                                    selectedCampaign == campaign[3].name,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CategoryCard(
                                campaign[4],
                                onTap: () {
                                  setState(() {
                                    selectedCampaign = campaign[4].name;
                                    isFormCompleted = true;
                                  });
                                  saveCampaignType(campaign[4].name);
                                },
                                isSelected:
                                    selectedCampaign == campaign[4].name,
                              ),
                            ],
                          ),
                          Spacer(
                            flex: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 96.h,
                  color: Colors.white,
                  child: ClipPath(
                    clipper: CharityScreenPath(),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.blue,
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 72.h,
              left: 0.5.sw - 46.w,
              width: 92.w,
              child: SizedBox(
                width: 92.w,
                height: 92.w,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(CircleBorder()),
                    minimumSize: MaterialStateProperty.all(Size(0, 0)),
                    backgroundColor: MaterialStateProperty.all(
                      Colors.blue,
                    ),
                    elevation: MaterialStateProperty.all(0),
                  ),
                  onPressed: navigateToNextPage,
                  child: Icon(
                    Icons.arrow_forward,
                    size: 48.sp,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
