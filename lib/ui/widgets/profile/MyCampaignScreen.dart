import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../theme/app_color.dart';

class MyCampaignScreen extends StatefulWidget {
  const MyCampaignScreen({super.key});

  @override
  State<MyCampaignScreen> createState() => _MyCampaignScreenState();
}

class _MyCampaignScreenState extends State<MyCampaignScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MyCampaign',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: 340.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.kPlaceholder1,
                      offset: Offset(0, 4),
                      blurRadius: 15,
                    )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0.w),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: AppColor.kPlaceholder1,
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/images/dermakilat.png',
                                width: 500.w,
                                height: 300.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 8.w,
                              right: 8.w,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 8.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.r),
                                  color: AppColor.kForthColor,
                                ),
                                child: Text(
                                  'Culture & arts',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 16.h,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 250.w,
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                          ),
                          child: Text(
                            'Bantu Derma Kilat Anak Yatim',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  '\RM187.50',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  'Raised',
                                  style: TextStyle(
                                    color: AppColor.kTextColor1,
                                  ),
                                ),
                              ],
                            ),
                            // Percentage Indicatior
                            CircularPercentIndicator(
                              radius: 32.0,
                              lineWidth: 10.0,
                              percent: 0.75,
                              center: new Text("75%"),
                              progressColor: Colors.green,
                            ),
                            Column(
                              children: [
                                Text(
                                  '\RM250.00',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  'Target',
                                  style: TextStyle(
                                    color: AppColor.kTextColor1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
