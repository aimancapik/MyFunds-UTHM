import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../routes/routes.dart';
import '../../../widgets/campaign/steps.dart';

class StepTwoScreen extends StatefulWidget {
  @override
  _StepTwoScreenState createState() => _StepTwoScreenState();
}

class _StepTwoScreenState extends State<StepTwoScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _campaignTitleController =
      TextEditingController();
  final TextEditingController _recipientsController = TextEditingController();
  final TextEditingController _targetController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;

  Future<void> _showStartDatePicker(BuildContext context) async {
    final DateTime? pickedStartDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedStartDate != null) {
      setState(() {
        _selectedStartDate = pickedStartDate;
        _startDateController.text =
            DateFormat('yyyy-MM-dd').format(_selectedStartDate!);
      });
    }
  }

  Future<void> _showEndDatePicker(BuildContext context) async {
  final DateTime? pickedEndDate = await showDatePicker(
    context: context,
    initialDate: _selectedStartDate ?? DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
  );

  if (pickedEndDate != null) {
    setState(() {
      _selectedEndDate = pickedEndDate;
      _endDateController.text = DateFormat('yyyy-MM-dd').format(_selectedEndDate!);
    });
  }
}


  void _showInvalidDateRangeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invalid Date Range'),
          content: Text('The end date cannot be before the start date.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToNextScreen() {
    if (_formKey.currentState!.validate()) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        FirebaseFirestore.instance.collection('requests').doc(user.uid).update({
          'campaignTitle': _campaignTitleController.text,
          'recipients': _recipientsController.text,
          'fundsTarget': _targetController.text,
          'startDate': _startDateController.text,
          'endDate': _endDateController.text,
        }).then((value) {
          // Navigation to the next screen
          Navigator.of(context).pushNamed(RouteGenerator.stepThree);
        }).catchError((error) {
          // Error handling
          print('Error updating document: $error');
        });
      }
    }
  }

  void _showDiscardChangesDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Discard Changes?'),
          content: Text('Are you sure you want to discard the changes?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  FirebaseFirestore.instance
                      .collection('requests')
                      .doc(user.uid)
                      .update({
                    'campaignTitle': null,
                    'recipients': null,
                    'fundsTarget': null,
                    'startDate': null,
                    'endDate': null,
                  }).then((value) {
                    // Navigation to the StartCampaignScreen
                    Navigator.of(context)
                        .pushNamed(RouteGenerator.stepOne);
                  }).catchError((error) {
                    // Error handling
                    print('Error updating document: $error');
                  });
                }
              },
              child: Text('Discard'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Start a Campaign',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 24.h),
              Text(
                'Complete your personal information to proceed to this charity program',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 24.h),
              Steps(1, 4),
              SizedBox(height: 24.h),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _campaignTitleController,
                      decoration: InputDecoration(
                        labelText: 'Title of Campaign',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the campaign title.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    TextFormField(
                      controller: _recipientsController,
                      decoration: InputDecoration(
                        labelText: 'Whom are the benefit recipients',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the recipients.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _targetController,
                      decoration: InputDecoration(
                        labelText: 'Target',
                        suffixIcon: Icon(Icons.attach_money_rounded),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the funds target.';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            controller: _startDateController,
                            decoration: InputDecoration(
                              labelText: 'Start Date',
                              suffixIcon: Icon(Icons.date_range_rounded),
                            ),
                            onTap: () {
                              _showStartDatePicker(context);
                            },
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            controller: _endDateController,
                            decoration: InputDecoration(
                              labelText: 'End Date',
                              suffixIcon: Icon(Icons.date_range_rounded),
                            ),
                            onTap: () {
                              _showEndDatePicker(context);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.transparent,
                                ),
                                foregroundColor: MaterialStateProperty.all(
                                  Colors.grey,
                                ),
                              ),
                              onPressed: () {
                                // Previous button pressed
                                _showDiscardChangesDialog();
                              },
                              child: Text(
                                'Previous',
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.blue,
                                ),
                                foregroundColor: MaterialStateProperty.all(
                                  Colors.white,
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (_selectedEndDate != null &&
                                      _selectedStartDate != null &&
                                      _selectedEndDate!
                                          .isBefore(_selectedStartDate!)) {
                                    _showInvalidDateRangeDialog();
                                  } else {
                                    _navigateToNextScreen();
                                  }
                                }
                              },
                              child: Text(
                                'Next',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
