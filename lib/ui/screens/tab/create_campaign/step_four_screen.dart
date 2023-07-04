import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../routes/routes.dart';
import '../../../widgets/campaign/steps.dart';

class StepFourScreen extends StatefulWidget {
  const StepFourScreen();

  @override
  _StepFourScreenState createState() => _StepFourScreenState();
}

class _StepFourScreenState extends State<StepFourScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNoController = TextEditingController();
  var _isChecked = "false";
  var baru = false;

  void _navigateToNextScreen() {
    if (_formKey.currentState!.validate()) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        FirebaseFirestore.instance.collection('requests').doc(user.uid).update({
          'phoneNo': _phoneNoController.text,
          'agreement': _isChecked,
        }).then((value) {
          if (_isChecked == "false") {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.r),
              ),
              builder: (_) => Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewPadding.bottom,
                  top: 32.h,
                  left: 16.w,
                  right: 16.w,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 64.h),
                    SvgPicture.asset(
                      'assets/images/check.svg',
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Successful',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Your campaign registration is sent to our admin to review. '
                      '\nNotification will be given to you in dashboard once your campaign is approved or not',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 80.h),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all(
                          Size(
                            double.infinity,
                            56.h,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RouteGenerator.main,
                          (route) => false,
                        );
                      },
                      child: Text('Home'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please agree to the terms and conditions.'),
              ),
            );
          }
        }).catchError((error) {
          // Error handling
          print('Error updating document: $error');
        });
      }
    } else {
      // Field validation failed, show error messages or prompt user to fill in required fields.
      setState(() {
        // Set error flags or show error messages.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32.r),
                    bottomRight: Radius.circular(32.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Start a Campaign',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Complete your personal information to proceed to this charity program',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: 24.h),
                    Steps(3, 4),
                    SizedBox(height: 38.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: TextFormField(
                        controller: _phoneNoController,
                        decoration: InputDecoration(
                          labelText: 'Your Phone Number',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Phone number is required';
                          }

                          // Remove any non-digit characters from the input value
                          final cleanedValue =
                              value.replaceAll(RegExp(r'\D'), '');

                          if (cleanedValue.length < 10 ||
                              cleanedValue.length > 11) {
                            return 'Phone number must be 10 or 11 digits';
                          }

                          // Add any additional phone number validation logic here

                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: baru,
                                onChanged: (value) {
                                  setState(() {
                                    // _isChecked = "true";
                                    baru = !baru;
                                  });
                                },
                              ),
                              Text(
                                'I agree to the terms and conditions',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) => SingleChildScrollView(
                                  child: AlertDialog(
                                    title: Text(
                                      'Terms and Conditions',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    content: Text(
                                      _termsAndConditionsText,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.blue),
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Close'),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'View Terms and Conditions',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.grey),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            minimumSize: MaterialStateProperty.all(
                              Size(
                                160.w,
                                48.h,
                              ),
                            ),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                horizontal: 24.w,
                              ),
                            ),
                          ),
                          onPressed: () {
                            // Previous button functionality
                          },
                          child: Text('Previous'),
                        ),
                        SizedBox(width: 16.w), // Added spacing between buttons
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              minimumSize: MaterialStateProperty.all(
                                Size(
                                  double.infinity,
                                  48.h,
                                ),
                              ),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                  horizontal: 24.w,
                                ),
                              ),
                            ),
                            onPressed: () {
                              _navigateToNextScreen();
                            },
                            child: Text('Publish Now'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _termsAndConditionsText = '''
Terms and Conditions:

1. By participating in this fundraising campaign, you acknowledge and agree to comply with all applicable laws and regulations.

2. The funds raised through this campaign will be used solely for charitable purposes as specified by the campaign organizer.

3. The campaign organizer reserves the right to use the funds raised for any lawful purpose that supports the stated charitable cause.

4. All donations made to this campaign are final and non-refundable.

5. The campaign organizer will provide periodic updates on the progress and impact of the campaign to the donors.

6. The campaign organizer will handle all personal information provided by donors in accordance with applicable privacy laws and regulations.

7. The campaign organizer is not responsible for any loss or damage incurred as a result of participating in this campaign.

8. By making a donation, you consent to the use of your name and likeness for promotional purposes related to this campaign.

9. The campaign organizer reserves the right to modify or cancel the campaign at any time.

10. If you have any questions or concerns regarding this campaign, please contact the campaign organizer directly.

By clicking "I agree," you indicate that you have read, understood, and agree to be bound by these terms and conditions.
''';
}
