import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';

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
  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userId = user.uid;
        final userDoc =
            FirebaseFirestore.instance.collection('users').doc(userId);
        final userData = await userDoc.get();
        if (userData.exists) {
          final userDataMap = userData.data() as Map<String, dynamic>;
          setState(() {
            firstNameController.text = userDataMap['firstName'] ?? '';
            lastNameController.text = userDataMap['lastName'] ?? '';
            usernameController.text = userDataMap['username'] ?? '';
            phoneNumberController.text = userDataMap['phoneNumber'] ?? '';
            profileImageUrl = userDataMap['profileImage'];
          });
        }
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
          height: 16,
        ),
        SizedBox(
          width: 120,
          height: 120,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                  color: Colors.blue,
                ),
                child: Center(
                  child: selectedImage != null
                      ? Image.file(
                          selectedImage!,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        )
                      : (profileImageUrl != null
                          ? Image.network(
                              profileImageUrl!,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            )
                          : SvgPicture.asset(
                              'assets/images/image_placeholder.svg',
                              width: 32,
                            )),
                ),
              ),
              Positioned(
                right: -12,
                bottom: -12,
                child: GestureDetector(
                  onTap: () {
                    // Open image picker
                    openImagePicker();
                  },
                  child: SvgPicture.asset(
                    'assets/images/edit.svg',
                    width: 32,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Spacer(),
        Row(
          children: [
            Expanded(
              child: ProfileInputField(
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
              width: 16,
            ),
            Expanded(
              child: ProfileInputField(
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
        ProfileInputField(
          title: 'Username',
          initialValue: usernameController.text,
          onChanged: (value) {
            setState(() {
              usernameController.text = value;
            });
          },
        ),
        Spacer(),
        ProfileInputField(
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
              Colors.blue,
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  8,
                ),
              ),
            ),
            minimumSize: MaterialStateProperty.all(
              Size(
                double.infinity,
                56,
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
          height: 40,
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
        final userDoc =
            FirebaseFirestore.instance.collection('users').doc(userId);

        // Create an update data map
        final Map<String, dynamic> updateData = {
          'username': username,
          'phoneNumber': phoneNumber,
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
          final firebase_storage.Reference ref = firebase_storage
              .FirebaseStorage.instance
              .ref()
              .child('profile_images/$imageName');
          final firebase_storage.UploadTask uploadTask =
              ref.putFile(selectedImage!);
          final firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
          final imageUrl = await taskSnapshot.ref.getDownloadURL();
          updateData['profileImage'] = imageUrl;
        }

        await userDoc.set(updateData, SetOptions(merge: true));
        print('User information updated successfully.');

        // Navigate back to the profile page
        Navigator.pop(context);
      }
    } catch (e) {
      print('Error updating user information: $e');
    }
  }

  void openImagePicker() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }
}

class ProfileInputField extends StatelessWidget {
  const ProfileInputField({
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
          height: 2,
        ),
        Stack(
          children: [
            TextField(
              onChanged: onChanged,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Enter $title',
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black,
                    ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
