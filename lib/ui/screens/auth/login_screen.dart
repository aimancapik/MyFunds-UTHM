import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfundsuthm/ui/screens/auth/forgot_password/forgot_btn_widget.dart';
import 'package:myfundsuthm/ui/screens/auth/signup_screen.dart';

import '../../../routes/routes.dart';
import '../../../theme/app_color.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/Logo.png',
                width: 250,
              ),
              SizedBox(
                height: 24.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(
                        16.w,
                        24.h,
                        16.w,
                        16.h,
                      ),
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.symmetric(
                        horizontal: 16.0.w,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          16.r,
                        ),
                      ),
                      child: Column(
                        children: [
                          LoginForm(),
                          SizedBox(
                            height: 32.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return SignupScreen();
                              }));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\'t have account? ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Colors.blue,
                                      ),
                                ),
                                Text(
                                  'Create new account',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppColor.kAccentColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 24.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          16.r,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(
                              0.5,
                            ),
                            offset: Offset(
                              0,
                              2.h,
                            ),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: LoginForm(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  String _email = '';
  String _password = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return emailRegex.hasMatch(email);
  }

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void _showSuccessMessage(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Login successful'),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showErrorMessage(BuildContext context, String errorMessage) {
    final snackBar = SnackBar(
      content: Text(errorMessage),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _signInWithEmailAndPassword(BuildContext context) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      final User? user = userCredential.user;
      if (user != null) {
        _showSuccessMessage(context);
        Navigator.of(context).pushReplacementNamed(RouteGenerator.main);
      }
    } catch (e) {
      final errorMessage = e.toString();
      _showErrorMessage(context, errorMessage);
      print('Login error: $errorMessage');
    }
  }

  void _submitForm(BuildContext context) {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      _signInWithEmailAndPassword(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sign in',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Colors.blue,
                ),
          ),
          Text(
            'to continue',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Colors.blue,
                ),
          ),
          SizedBox(
            height: 40.h,
          ),
          TextFormField(
            // controller: emailController
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
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
            ),
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email';
              }
              if (!_isValidEmail(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _email = value;
              });
            },
          ),
          SizedBox(
            height: 15,
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
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: _togglePasswordVisibility,
              ),
            ),
            obscureText: !_passwordVisible,
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              } else if (value.length < 8) {
                return 'Password must be at least 8 characters long';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _password = value;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  modalBottomSheet(context);
                },
                child: Text(
                  'Forgot password?',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColor.kAccentColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40.h,
          ),
          Center(
            child: ElevatedButton(
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
              onPressed: () => _submitForm(context),
              child: Text(
                'Sign in',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
