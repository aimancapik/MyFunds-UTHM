import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../../routes/routes.dart';
import '../../../../theme/app_color.dart';
import '../../../widgets/campaign/steps.dart';

class StepThreeScreen extends StatefulWidget {
  StepThreeScreen();

  @override
  _StepThreeScreenState createState() => _StepThreeScreenState();
}

class _StepThreeScreenState extends State<StepThreeScreen> {
  String? imagePath;
  String? imageURL;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();

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
                    'description': null,
                    'imageURL': null,
                  }).then((value) {
                    // Navigation to the step two
                    Navigator.of(context).pushNamed(RouteGenerator.stepTwo);
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

  Future<String?> _uploadImageToFirebase() async {
    if (imagePath != null) {
      final file = File(imagePath!);
      final fileName = file.path.split('/').last;
      final destination = 'campaign_thumbnails/$fileName';

      try {
        final ref = firebase_storage.FirebaseStorage.instance.ref(destination);
        await ref.putFile(file);
        final imageURL = await ref.getDownloadURL();
        return imageURL;
      } catch (error) {
        print('Error uploading image: $error');
      }
    }
    return null;
  }

  void _navigateToNextScreen() async {
    if (_formKey.currentState!.validate()) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final imageURL = await _uploadImageToFirebase();

        FirebaseFirestore.instance.collection('requests').doc(user.uid).update({
          'description': _descriptionController.text,
          'imageURL': imageURL,
          
        }).then((value) {
          // Navigation to the next screen
          Navigator.of(context).pushNamed(RouteGenerator.stepFour);
        }).catchError((error) {
          // Error handling
          print('Error updating document: $error');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              Text(
                'Start a Campaign',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 24.h),
              Text(
                'Complete your personal information to proceed to this fundraising program',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 24.h),
              Steps(2, 4),
              SizedBox(height: 24.h),
              Text(
                'Upload a photo as a thumbnail',
              ),
              SizedBox(height: 8.h),
              DottedBorder(
                color: AppColor.kPlaceholder1,
                strokeWidth: 2.sp,
                borderType: BorderType.RRect,
                radius: Radius.circular(8.r),
                dashPattern: [15, 10],
                child: GestureDetector(
                  onTap: () async {
                    final picker = ImagePicker();
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.gallery);

                    if (pickedFile != null) {
                      setState(() {
                        imagePath = pickedFile.path;
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(30),
                    width: double.infinity,
                    child: Center(
                      child: Container(
                        width: 130.w,
                        height: 130.w,
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32.r),
                          color: AppColor.kPlaceholder2,
                        ),
                        child: imagePath != null
                            ? Image.file(
                                File(imagePath!),
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/image.svg',
                                    width: 32.w,
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    'Tap to select an image',
                                    style: TextStyle(
                                      color: AppColor.kTextColor2,
                                      fontSize: 12.sp,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Description',
              ),
              SizedBox(height: 8.h),
              Form(
                key: _formKey,
                child: Container(
                  height: 200.h,
                  child: TextFormField(
                    controller: _descriptionController,
                    maxLines: null,
                    textAlignVertical: TextAlignVertical.top,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColor.kPlaceholder2,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide.none,
                      ),
                      hintStyle:
                          Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: AppColor.kTextColor1,
                              ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Row(
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
                          AppColor.kPlaceholder1,
                        ),
                      ),
                      onPressed: () {
                        _showDiscardChangesDialog();
                      },
                      child: Text(
                        'Previous',
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          Colors.blue,
                        ),
                      ),
                      onPressed: () {
                        _navigateToNextScreen();
                      },
                      child: Text(
                        'Next',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
