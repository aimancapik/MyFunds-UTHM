import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfundsuthm/ui/screens/auth/forgetpw_screen.dart';

class ForgotPasswordMailScreen extends StatelessWidget {
  const ForgotPasswordMailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(30),
        child: Center(
          child: Column(children: [
            SizedBox(
              height: 30 * 4,
            ),
            SvgPicture.asset(
              "assets/images/sendemail.svg",
              height: 250,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Enter Your Email",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(
              "So you can reset your password",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 20,
            ),
            ResetPasswordForm(),
            // Form(
            //     child: Column(
            //   children: [
            //     TextFormField(
            //       decoration: InputDecoration(
            //         label: Text("Email"),
            //         border: OutlineInputBorder(),
            //         hintText: "example@mail.com",
            //         prefixIcon: Icon(
            //           Icons.email_rounded,
            //           color: Colors.black,
            //         ),
            //         labelStyle: TextStyle(
            //           color: Colors.black,
            //         ),
            //         focusedBorder: OutlineInputBorder(
            //           borderSide: BorderSide(
            //             width: 2.0,
            //             color: Colors.black,
            //           ),
            //         ),
            //       ),
            //     ),
            //     SizedBox(
            //       height: 20,
            //     ),
            //     SizedBox(
            //       width: double.infinity,
            //       child: ElevatedButton(
            //         onPressed: () {},
            //         child: Text("SUBMIT"),
            //       ),
            //     ),
            //   ],
            // ))
          ]),
        ),
      ),
    ));
  }
}
