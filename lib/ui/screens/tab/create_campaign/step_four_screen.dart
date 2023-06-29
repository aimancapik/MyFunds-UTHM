import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../routes/routes.dart';
import '../../../../theme/app_color.dart';
import '../../../widgets/campaign/campaign_input_field.dart';
import '../../../widgets/campaign/campaign_scaffold.dart';
import '../../../widgets/campaign/steps.dart';

class StepFourScreen extends StatefulWidget {
  const StepFourScreen();

  @override
  _StepFourScreenState createState() => _StepFourScreenState();
}

class _StepFourScreenState extends State<StepFourScreen> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return CharityScaffold(
      children: [
        Text(
          'Start a Campaign',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          'Complete your personal information to proceed to this charity program',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(
          height: 24.h,
        ),
        Steps(3, 4),
        SizedBox(
          height: 24.h,
        ),
        CampignInputField('Your Phone Number'),
        SizedBox(
          height: 24.h,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              Row(
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    },
                    fillColor: MaterialStateProperty.resolveWith(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return Colors
                            .blue; // Color when the checkbox is selected
                      }
                      return Colors.blue; // Default color
                    }),
                    checkColor: Colors.white, // Color of the tick symbol
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      side: BorderSide(
                          color: _isChecked
                              ? Colors.white
                              : Colors.blue), // Border color of the checkbox
                    ),
                  ),
                  Text(
                    'I agree to the terms and conditions',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text(
                        'Terms and Conditions',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      content: Text(
                        _termsAndConditionsText,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      actions: [
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
                child: Text(
                  'View Terms and Conditions',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColor.kPrimaryColor,
                        decoration: TextDecoration.underline,
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
      button: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                8.r,
              ),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.blue),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          minimumSize: MaterialStateProperty.all(
            Size(
              double.infinity,
              48.h,
            ),
          ),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(
              horizontal: 24.w,
            ),
          ),
        ),
        onPressed: () {
          if (_isChecked) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.r),
              ),
              builder: (_) => Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewPadding.bottom,
                  top: 32.h,
                  left: 16.w,
                  right: 16.w,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 64.h,
                    ),
                    SvgPicture.asset(
                      'assets/images/check.svg',
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      'Successful',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColor.kPrimaryColor,
                              ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      'Your charity program has been successfully created. '
                      'Now you can check and maintain it in your \'activity\' menu.',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 80.h,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all(
                          Size(
                            double.infinity,
                            56.h,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RouteGenerator.main,
                          (route) => false,
                        );
                      },
                      child: Text('Home'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            // Show a snackbar or toast message indicating that the terms and conditions must be agreed to proceed.
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please agree to the terms and conditions.'),
              ),
            );
          }
        },
        child: Text('Publish Now'),
      ),
    );
  }
}

const String _termsAndConditionsText = '''
Terms and Conditions:

1. By participating in this fundraising campaign, you acknowledge and agree to comply with all applicable laws and regulations.

2. The funds raised through this campaign will be used solely for the stated purpose outlined in the campaign description.

3. The campaign organizers reserve the right to allocate the funds as needed to fulfill the campaign's objectives.

4. Any personal information provided during the donation process will be handled in accordance with our privacy policy.

5. Donations made to this campaign are non-refundable.

6. The campaign organizers are not responsible for any errors or omissions in the campaign description or any other materials associated with the campaign.

7. The campaign organizers may make changes to the campaign's goals, timeline, or other aspects as necessary.

8. By making a donation to this campaign, you agree to receive occasional updates and communications regarding the campaign's progress.

9. The campaign organizers reserve the right to cancel or terminate the campaign at any time.

10. The success of the campaign and the achievement of its goals are not guaranteed.

Please read these terms and conditions carefully before proceeding with your donation. If you do not agree with any of the terms stated above, please do not continue with the donation process.
''';
