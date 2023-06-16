import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';

import '../../../theme/app_color.dart';

class EditContent extends StatefulWidget {
  const EditContent();

  @override
  _EditContentState createState() => _EditContentState();
}

class _EditContentState extends State<EditContent> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  File? selectedImage;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc('your_user_id')
          .get();

      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        setState(() {
          firstNameController.text = userData['firstName'];
          lastNameController.text = userData['lastName'];
          usernameController.text = userData['username'];
          phoneNumberController.text = userData['phoneNumber'];
        });
      }
    } catch (e) {
      print('Error retrieving user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 16.h,
        ),
        SizedBox(
          width: 120.w,
          height: 120.w,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 120.w,
                width: 120.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    8.r,
                  ),
                  color: AppColor.kBlue,
                ),
                child: Center(
                  child: selectedImage != null
                      ? Image.file(
                          selectedImage!,
                          width: 120.w,
                          height: 120.w,
                          fit: BoxFit.cover,
                        )
                      : SvgPicture.asset(
                          'assets/images/image_placeholder.svg',
                          width: 32.w,
                        ),
                ),
              ),
              Positioned(
                right: -12.w,
                bottom: -12.w,
                child: GestureDetector(
                  onTap: () {
                    // Open image picker
                    openImagePicker();
                  },
                  child: SvgPicture.asset(
                    'assets/images/edit.svg',
                    width: 32.w,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        Spacer(),
        Row(
          children: [
            Expanded(
              child: CharityInputField(
                title: 'First Name',
                initialValue: firstNameController.text,
                onChanged: (value) {
                  setState(() {
                    firstNameController.text = value;
                  });
                },
              ),
            ),
            SizedBox(
              width: 16.w,
            ),
            Expanded(
              child: CharityInputField(
                title: 'Last Name',
                initialValue: lastNameController.text,
                onChanged: (value) {
                  setState(() {
                    lastNameController.text = value;
                  });
                },
              ),
            ),
          ],
        ),
        
        Spacer(),
        CharityInputField(
          title: 'Username',
          initialValue: usernameController.text,
          onChanged: (value) {
            setState(() {
              usernameController.text = value;
            });
          },
        ),
        Spacer(),
        CharityInputField(
          title: 'Phone Number',
          initialValue: phoneNumberController.text,
          onChanged: (value) {
            setState(() {
              phoneNumberController.text = value;
            });
          },
        ),
        Spacer(),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              AppColor.kPrimaryColor,
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  8.r,
                ),
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
            final String firstName = firstNameController.text;
            final String lastName = lastNameController.text;
            final String username = usernameController.text;
            final String phoneNumber = phoneNumberController.text;

            updateUserInformation(firstName, lastName, username, phoneNumber);
          },
          child: Text(
            'Save Change',
          ),
        ),
        SizedBox(
          height: 40.h,
        ),
      ],
    );
  }

  void updateUserInformation(
    String firstName,
    String lastName,
    String username,
    String phoneNumber,
  ) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userId = user.uid;
        final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

        // Create an update data map
        final Map<String, dynamic> updateData = {
          'username': username,
          'phone': phoneNumber,
        };

        // Add first name if not empty
        if (firstName.isNotEmpty) {
          updateData['firstName'] = firstName;
        }

        // Add last name if not empty
        if (lastName.isNotEmpty) {
          updateData['lastName'] = lastName;
        }

        // Upload image if selected
        if (selectedImage != null) {
          final imageName = DateTime.now().millisecondsSinceEpoch.toString();
          final firebase_storage.Reference ref =
              firebase_storage.FirebaseStorage.instance.ref().child('profile_images/$imageName');
          final firebase_storage.UploadTask uploadTask = ref.putFile(selectedImage!);
          final firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
          final imageUrl = await taskSnapshot.ref.getDownloadURL();
          updateData['profileImage'] = imageUrl;
        }

        await userDoc.update(updateData);
        print('User information updated successfully.');
      }
    } catch (e) {
      print('Error updating user information: $e');
    }
  }

  void openImagePicker() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }
}

class CharityInputField extends StatelessWidget {
  const CharityInputField({
    required this.title,
    required this.initialValue,
    required this.onChanged,
  });

  final String title;
  final String initialValue;
  final void Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(),
        ),
        SizedBox(
          height: 2.h,
        ),
        Stack(
          children: [
            TextField(
              onChanged: onChanged,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColor.kPlaceholder2,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    8.r,
                  ),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Enter $title',
                hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColor.kTextColor1,
                    ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 8.h,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
