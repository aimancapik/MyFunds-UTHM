// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../bloc/swap/swap_bloc.dart';
// import 'charity_card.dart';
// import 'empty_content.dart';

// List<Widget> contents = [DonationContent(), CharityContent()];

// class PageContent extends StatelessWidget {
//   const PageContent();

//   @override
//   Widget build(BuildContext context) {
//     return PageView.builder(
//       controller: BlocProvider.of<SwapBloc>(context).state.controller,
//       itemCount: contents.length,
//       onPageChanged: (index) {
//         BlocProvider.of<SwapBloc>(context).add(SetSwap(index == 0));
//       },
//       itemBuilder: (_, index) => contents[index],
//     );
//   }
// }

// class CharityContent extends StatefulWidget {
//   const CharityContent();

//   @override
//   _CharityContentState createState() => _CharityContentState();
// }

// class _CharityContentState extends State<CharityContent> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16.0.w),
//       child: BlocBuilder<SwapBloc, SwapState>(
//         builder: (context, state) {
//           return Column(
//             children: [
//               state.isDetail
//                   ? DonatorContent()
//                   : CharityCard(
//                       onTap: () {
//                         BlocProvider.of<SwapBloc>(context).add(SetDetail(true));
//                       },
//                     ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

// class DonatorContent extends StatelessWidget {
//   const DonatorContent();

//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       // Handle case when user is not logged in
//       return Text('User not logged in');
//     }

//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('users')
//           .doc(user.uid)
//           .collection('history')
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         }

//         final donationHistory = snapshot.data?.docs ?? [];

//         return Container(
//           padding: EdgeInsets.symmetric(horizontal: 16.0),
//           child: ListView.builder(
//             itemCount: donationHistory.length,
//             itemBuilder: (context, index) {
//               final donationData =
//                   donationHistory[index].data() as Map<String, dynamic>?;

//               if (donationData == null) {
//                 // Handle null data case
//                 return SizedBox.shrink();
//               }

//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     donationData['campaignTitle'] as String,
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8.0),
//                   Text(
//                     'Value: ${donationData['value']}',
//                     style: TextStyle(
//                       color: Colors.grey,
//                       fontSize: 14.0,
//                     ),
//                   ),
//                   SizedBox(height: 16.0),
//                 ],
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
