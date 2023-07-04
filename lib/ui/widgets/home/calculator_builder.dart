import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfundsuthm/ui/screens/tab/home/donation_screen.dart';

import '../../../theme/app_color.dart';
import '../../screens/tab/home/MyHomeScreen.dart';
import 'calculator.dart';

class CalculatorBuilder extends StatelessWidget {
  final ApprovedCard approvedCard;

  const CalculatorBuilder({Key? key, required this.approvedCard})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    String finalValue = '';

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Enter Donation Amount',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 20.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Calculator((value) => finalValue = value),
            SizedBox(height: 16.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                minimumSize: Size(0, 56.h),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DonationScreen(
                            approvedCard: approvedCard, total: finalValue))

                    // arguments: finalValue,
                    );
              },
              child: Text(
                'Donate',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
