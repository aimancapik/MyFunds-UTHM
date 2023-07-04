import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../routes/routes.dart';

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
  final _phoneController = TextEditingController();
  bool _passwordVisible = false;

  bool _isLoading = false;
  String _errorText = '';

  String? _validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your email';
    }
    // Email validation using regular expression
    bool isValidEmail = RegExp(
            r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$')
        .hasMatch(value);
    if (!isValidEmail) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validateUsername(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your username';
    }
    // Add additional username validation logic if needed
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your phone number';
    }
    // Phone number validation using regular expression
    bool isValidPhoneNumber = RegExp(r'^\d{10}$').hasMatch(value);
    if (!isValidPhoneNumber) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    // Add additional password validation logic if needed
    return null;
  }

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
        'userId': userId,
        'email': _emailController.text.trim(),
        'username': _usernameController.text.trim(),
        'phone': _phoneController.text.trim(),
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
    _phoneController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create new',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Colors.blue,
                ),
          ),
          Text(
            'Account',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Colors.blue,
                ),
          ),
          SizedBox(
            height: 40.h,
          ),
          TextFormField(
            decoration: InputDecoration(
              label: Text("Email"),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue)),
              prefixIcon: Icon(
                Icons.email_rounded,
                color: Colors.blue[100],
              ),
              labelStyle: TextStyle(
                color: Colors.blue[100],
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                width: 2.0,
                color: Colors.blueAccent,
              )),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
              hintText: 'Email',
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
            ),
            textInputAction: TextInputAction.next,
            controller: _emailController,
            validator: _validateEmail,
          ),
          SizedBox(
            height: 8.h,
          ),
          TextFormField(
            decoration: InputDecoration(
              label: Text("Username"),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue)),
              prefixIcon: Icon(
                Icons.person_2_rounded,
                color: Colors.blue[100],
              ),
              labelStyle: TextStyle(
                color: Colors.blue[100],
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                width: 2.0,
                color: Colors.blueAccent,
              )),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
              hintText: 'Username',
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
            ),
            textInputAction: TextInputAction.next,
            controller: _usernameController,
            validator: _validateUsername,
          ),
          SizedBox(
            height: 8.h,
          ),
          TextFormField(
            decoration: InputDecoration(
              label: Text("Phone No"),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue)),
              prefixIcon: Icon(
                Icons.phone_android_rounded,
                color: Colors.blue[100],
              ),
              labelStyle: TextStyle(
                color: Colors.blue[100],
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                width: 2.0,
                color: Colors.blueAccent,
              )),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
              hintText: 'Phone No',
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
            ),
            textInputAction: TextInputAction.next,
            controller: _phoneController,
            validator: _validatePhoneNumber,
          ),
          SizedBox(
            height: 8.h,
          ),
          TextFormField(
            decoration: InputDecoration(
              label: Text("Password"),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue)),
              prefixIcon: Icon(
                Icons.fingerprint_rounded,
                color: Colors.blue[100],
              ),
              labelStyle: TextStyle(
                color: Colors.blue[100],
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                width: 2.0,
                color: Colors.blueAccent,
              )),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
              hintText: 'Password',
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility_off : Icons.visibility,
                  color: Colors.blue[100], // Set color for the suffix icon
                ),
                onPressed: _togglePasswordVisibility,
              ),
            ),
            textInputAction: TextInputAction.done,
            controller: _passwordController,
            validator: _validatePassword,
            obscureText: !_passwordVisible, // Hide or show password
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
            height: 30.h,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.blue,
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
