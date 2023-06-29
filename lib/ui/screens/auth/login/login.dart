import 'package:flutter/material.dart';
import 'package:myfundsuthm/ui/screens/auth/signup/signup.dart';

import '../forgot_password/forgot_btn_widget.dart';

class LoginScreenLatest extends StatelessWidget {
  const LoginScreenLatest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(30),
        child: Column(children: [
          Image.asset(
            "assets/images/Logo.png",
            height: 200,
          ),
          SizedBox(
            height: 30,
          ),
          LoginFormWidget(),
          LoginFooterWidget()
        ]),
      )),
    );
  }
}

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Form(
        child: Column(
          children: [
            TextFormField(
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
                )),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.remove_red_eye_sharp),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            /////////////////////////////////////////////////////////////////////
            //-- FORGOT PASSWORD
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  modalBottomSheet(context);
                },
                child: Text("Forgot Password?"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("LOGIN"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Signuplatest();
            }));
          },
          child: Text.rich(TextSpan(children: [
            TextSpan(
                text: "New User?",
                style: Theme.of(context).textTheme.bodyLarge),
            TextSpan(
                text: " Register here".toUpperCase(),
                style: TextStyle(color: Colors.blue)),
          ])),
        )
      ],
    );
  }
}
