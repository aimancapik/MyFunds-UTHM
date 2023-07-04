import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../bloc/payment/payment_bloc.dart';
import '../../../../routes/routes.dart';
import '../../../widgets/home/payment_method_widget.dart';
import 'MyHomeScreen.dart';

class DonationScreen extends StatefulWidget {
  final ApprovedCard approvedCard;

  final String total;

  DonationScreen({super.key, required this.approvedCard, required this.total});

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                    32.r,
                  ),
                  bottomRight: Radius.circular(
                    32.r,
                  ),
                ),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: SizedBox(
                            width: 24.w,
                            child: SvgPicture.asset(
                              'assets/images/back.svg',
                              width: 24.w,
                              color: Colors.grey
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Donation Detail',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: 24.w,
                        )
                      ],
                    ),
                    Spacer(),
                    SizedBox(
                      height: 72.h,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            width: 104.w,
                            height: 72.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                8.r,
                              ),
                              color: Colors.grey
                            ),
                            child: Center(
                              child: Image.network(
                                widget.approvedCard.imageURL,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  widget.approvedCard.campaignTitle,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  widget.approvedCard.organization,
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
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
                      onPressed: () {},
                      child: Text(
                        'Donate as anonymous',
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Payment Method',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 18.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Spacer(),
                    BlocProvider(
                      create: (context) => PaymentBloc(),
                      child: Column(
                        children: List.generate(
                          methods.length,
                          (index) => Column(
                            children: [
                              PaymentMethodWidget(index),
                              SizedBox(
                                height: 8.h,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Spacer(
                      flex: 3,
                    ),
                    Row(
                      children: [
                        Text('Total',
                            style: Theme.of(context).textTheme.titleLarge),
                        Spacer(),
                        Text(
                          '\RM${widget.total}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 120.h,
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        8.r,
                      ),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  foregroundColor: MaterialStateProperty.all(
                    Colors.blue,
                  ),
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
                  updatehistory(widget.approvedCard);
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
                          SvgPicture.asset(
                            'assets/images/check.svg',
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            'Thank You',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            'Your donation has been succeed and will be '
                            'transferred soon to the needy.',
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 64.h,
                          ),
                          ElevatedButton(
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
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  RouteGenerator.main, (route) => false);
                            },
                            child: Text(
                              'Home',
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                child: Text('Donate'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void updatehistory(ApprovedCard approvedCard) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('history')
          .add({
        'campaignTitle': approvedCard.campaignTitle,
        'value': widget.total,
        'organizer': approvedCard.organization,
      });
    }
  }

  void updateTotalAmount(ApprovedCard approvedCard) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('approvedCampaign')
          .doc(user.uid)
          .update({
        'TotalDuit': widget.total + 'TotalDuit',
      });
    }
  }
}
