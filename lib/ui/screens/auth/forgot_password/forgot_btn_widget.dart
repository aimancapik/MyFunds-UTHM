import 'package:flutter/material.dart';
import 'package:myfundsuthm/ui/screens/auth/forgot_password/otp.dart';

import 'mail.dart';

class ForgotPasswordBtnWidget extends StatelessWidget {
  const ForgotPasswordBtnWidget({
    required this.btnIcon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final IconData btnIcon;
  final String title, subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
        ),
        child: Row(children: [
          Icon(
            btnIcon,
            size: 60.0,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          )
        ]),
      ),
    );
  }
}

Future<dynamic> modalBottomSheet(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      builder: (context) => Container(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Make Selection!",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Text(
                  "Select one of the options below to reset your password",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(
                  height: 30,
                ),
                ForgotPasswordBtnWidget(
                  btnIcon: Icons.mail_outline_rounded,
                  title: 'E-mail',
                  subtitle: 'Reset via Mail verification',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return ForgotPasswordMailScreen();
                    }));
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ForgotPasswordBtnWidget(
                  btnIcon: Icons.mobile_friendly_rounded,
                  title: 'Phone No',
                  subtitle: 'Reset via Phone Verification',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return OTPscreen();
                    }));
                  },
                )
              ],
            ),
          ));
}
