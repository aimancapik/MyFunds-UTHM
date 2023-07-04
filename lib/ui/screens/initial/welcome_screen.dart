import 'package:flutter/material.dart';
import 'package:myfundsuthm/constant/image_strings.dart';
import 'package:myfundsuthm/ui/screens/auth/login_screen.dart';

import '../auth/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        padding: EdgeInsets.all(35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(tlogoapp, height: height * 0.6),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return LoginScreen();
                      }));
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      foregroundColor: Colors.blue,
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.blue),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text(
                      "LOGIN",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return SignupScreen();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue.shade900,
                      side: BorderSide(color: Colors.blue.shade900),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text("SIGNUP",style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
