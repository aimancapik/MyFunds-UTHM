import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../theme/app_color.dart';
import '../../widgets/authentication/custom_input_field.dart';

class ForgetPwScreen extends StatelessWidget {
  const ForgetPwScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kPrimaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: 1.sh -
                MediaQuery.of(context).viewPadding.bottom -
                MediaQuery.of(context).viewPadding.top,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/Logo.png',
                  width: 250,
                ),
                SizedBox(
                  height: 2,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0.w,
                    ),
                    child: Center(
                      child: Container(
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
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Forget',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                    color: AppColor.kPrimaryColor,
                                  ),
                            ),
                            Text(
                              'Password?',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                    color: AppColor.kPrimaryColor,
                                  ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Text(
                              'Enter your email associated with your account and we\'ll '
                              'send an email with instructions to reset your password.',
                              style: TextStyle(
                                color: AppColor.kTextColor1,
                              ),
                            ),
                            SizedBox(
                              height: 64.h,
                            ),
                            ResetPasswordForm(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ResetPasswordForm extends StatefulWidget {
  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  void _resetPassword(BuildContext context, String email) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        List<String> signInMethods =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
        if (signInMethods.isEmpty) {
          _showSnackBar(context, 'Email not found');
        } else {
          await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
          _showSnackBar(context, 'Password reset email sent');
        }
      } catch (e) {
        _showSnackBar(context, 'Failed to send password reset email');
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomInputField(
            hintText: 'email address',
            textInputAction: TextInputAction.done,
            controller: _emailController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          SizedBox(
            height: 24.h,
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
            onPressed: _isLoading
                ? null
                : () => _resetPassword(context, _emailController.text.trim()),
            child: _isLoading
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Text(
                    'Submit',
                  ),
          ),
        ],
      ),
    );
  }
}
