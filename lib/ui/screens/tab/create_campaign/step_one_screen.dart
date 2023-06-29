import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../routes/routes.dart';
import '../../../widgets/campaign/steps.dart';

class StepOneScreen extends StatefulWidget {
  final String? selectedCampaign;

  const StepOneScreen({Key? key, this.selectedCampaign}) : super(key: key);

  @override
  _StepOneScreenState createState() => _StepOneScreenState();
}

class _StepOneScreenState extends State<StepOneScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedRole;
  String? _selectedFaculty;
  TextEditingController _organizationNameController = TextEditingController();
  TextEditingController _personInChargeController = TextEditingController();

  final List<String> _roles = ['Student', 'Staff'];
  final List<String> _faculties = [
    'Kejuruteraan Awam & Alam Bina (FKAAB)',
    'Kejuruteraan Elektrik & Elektronik (FKEE)',
    'Kejuruteraan Mekanikal & Pembuatan (FKMP)',
    'Pegurusan Teknologi & Perniagaan (FPTP)',
    'Pendidikan Teknik dan Vokasional (FPTV)',
    'Sains Komputer & Teknologi Maklumat (FSKTM)',
    'Sains Gunaan & Teknologi (FAST)',
    'Teknologi Kejuruteraan (FTK)',
    'Pusat Pengajian Diploma (PPD)'
  ];

  @override
  void dispose() {
    _organizationNameController.dispose();
    _personInChargeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _selectedRole = _roles[0]; // Initialize with the first option
    _selectedFaculty = _faculties[6]; // Initialize with the 6 option
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
                    'user': null,
                    'organization': null,
                    'faculty': null,
                    'personInCharge': null,
                  }).then((value) {
                    // Navigation to the StartCampaignScreen
                    Navigator.of(context)
                        .pushNamed(RouteGenerator.startCharity);
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

  void _navigateToNextScreen() {
    if (_formKey.currentState!.validate()) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        FirebaseFirestore.instance.collection('requests').doc(user.uid).update({
          'user': _selectedRole,
          'organization': _organizationNameController.text,
          'faculty': _selectedFaculty,
          'personInCharge': _personInChargeController.text,
        }).then((value) {
          // Navigation to the next screen
          Navigator.of(context).pushNamed(RouteGenerator.stepTwo);
        }).catchError((error) {
          // Error handling
          print('Error updating document: $error');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
// Show the discard changes dialog when the user presses the system back button
        _showDiscardChangesDialog();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Start a Campaign',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: 25.h),
                  Text(
                    'Complete your personal information to proceed to this fundraising program',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 25.h),
                  Steps(0, 4),
                  SizedBox(height: 35.h),
                  Text(
                    'Are you a student or staff in UTHM?',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  DropdownButton<String>(
                    value: _selectedRole,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRole = newValue;
                      });
                    },
                    items: _roles.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 25.h),
                  Text(
                    'Name of Organization',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextFormField(
                    controller: _organizationNameController,
                    decoration: InputDecoration(
                      hintText: 'Enter organization name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter organization name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 25.h),
                  Text(
                    'Faculty',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  DropdownButton<String>(
                    value: _selectedFaculty,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedFaculty = newValue;
                      });
                    },
                    items: _faculties
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 25.h),
                  Text(
                    'Person In Charge Name',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextFormField(
                    controller: _personInChargeController,
                    decoration: InputDecoration(
                      hintText: 'Enter person in charge name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter person in charge name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _showDiscardChangesDialog,
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.grey),
                            minimumSize: MaterialStateProperty.all<Size>(
                              Size(double.infinity, 48.h),
                            ),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(horizontal: 24.w),
                            ),
                          ),
                          child: Text(
                            'Previous',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _navigateToNextScreen,
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).primaryColor),
                            minimumSize: MaterialStateProperty.all<Size>(
                              Size(double.infinity, 48.h),
                            ),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(horizontal: 24.w),
                            ),
                          ),
                          child: Text(
                            'Next',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
