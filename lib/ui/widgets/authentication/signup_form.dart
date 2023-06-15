import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../routes/routes.dart';
import '../../../theme/app_color.dart';
import 'custom_input_field.dart';

class SignupForm extends StatefulWidget {
  const SignupForm();

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  String _errorText = '';

  Future<void> _createUser() async {
    setState(() {
      _isLoading = true;
      _errorText = '';
    });

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      String userId = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'email': _emailController.text.trim(),
        'username': _usernameController.text.trim(),
      });

      // Navigate to the main screen or any other screen after successful signup
      Navigator.of(context).pushReplacementNamed(RouteGenerator.main);
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
        _errorText = e.message!;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorText = 'An error occurred. Please try again later.';
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create New',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: AppColor.kPrimaryColor,
                ),
          ),
          Text(
            'Account',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: AppColor.kPrimaryColor,
                ),
          ),
          SizedBox(
            height: 40.h,
          ),
          CustomInputField(
            hintText: 'Email',
            textInputAction: TextInputAction.next,
            controller: _emailController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          SizedBox(
            height: 8.h,
          ),
          CustomInputField(
            hintText: 'Username',
            textInputAction: TextInputAction.next,
            controller: _usernameController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
          ),
          SizedBox(
            height: 8.h,
          ),
          CustomInputField(
            hintText: 'Password',
            isPassword: true,
            textInputAction: TextInputAction.done,
            controller: _passwordController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 8) {
                return 'Password must be at least 8 characters';
              }
              return null;
            },
          ),
          SizedBox(
            height: 16.h,
          ),
          if (_errorText.isNotEmpty)
            Text(
              _errorText,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          SizedBox(
            height: 50.h,
          ),
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
            onPressed: _isLoading ? null : _submitForm,
            child: _isLoading
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Text(
                    'Create Account',
                  ),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _createUser();
    }
  }
}
