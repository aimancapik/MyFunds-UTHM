import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfundsuthm/ui/screens/auth/login/login.dart';

import 'signup_controller.dart';

class Signuplatest extends StatelessWidget {
  const Signuplatest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/Logo.png",
                  height: 200,
                ),
                // FormHeaderWidget(
                //   title: "Ha Register La",
                //   subtitle: "tunggu apa lagi",
                // ),
                SignUpFormWidget(),
                SignupFooterWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignupFooterWidget extends StatelessWidget {
  const SignupFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return LoginScreenLatest();
            }));
          },
          child: Text.rich(TextSpan(children: [
            TextSpan(
                text: "Already have an account?",
                style: Theme.of(context).textTheme.bodyLarge),
            TextSpan(
                text: " Login".toUpperCase(),
                style: TextStyle(color: Colors.blue)),
          ])),
        )
      ],
    );
  }
}

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();

    return Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.username,
                  decoration: InputDecoration(
                      label: Text("Username"),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.person_outline_rounded,
                        color: Colors.black,
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 2.0,
                        color: Colors.black,
                      ))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: controller.email,
                  decoration: InputDecoration(
                      label: Text("Email"),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.email_rounded,
                        color: Colors.black,
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 2.0,
                        color: Colors.black,
                      ))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: controller.phoneNo,
                  decoration: InputDecoration(
                      label: Text("Phone Number"),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.phone_android_rounded,
                        color: Colors.black,
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 2.0,
                        color: Colors.black,
                      ))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: controller.password,
                  decoration: InputDecoration(
                      label: Text("Password"),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.fingerprint_rounded,
                        color: Colors.black,
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 2.0,
                        color: Colors.black,
                      ))),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            SignUpController.instance.registerUser(
                                controller.email.text.trim(),
                                controller.password.text.trim());
                          }
                        },
                        child: Text("Signup"))),
              ],
            )));
  }
}
