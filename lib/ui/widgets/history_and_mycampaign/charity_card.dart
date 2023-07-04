// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';

// import '../../../theme/app_color.dart';

// class CampaignEditDialog extends StatefulWidget {
//   @override
//   _CampaignEditDialogState createState() => _CampaignEditDialogState();
// }

// class _CampaignEditDialogState extends State<CampaignEditDialog> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController? _titleController;
//   TextEditingController? _imageController;
//   TextEditingController? _descriptionController;
//   TextEditingController? _durationController;

//   @override
//   void initState() {
//     super.initState();
//     _titleController = TextEditingController();
//     _imageController = TextEditingController();
//     _descriptionController = TextEditingController();
//     _durationController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     _titleController?.dispose();
//     _imageController?.dispose();
//     _descriptionController?.dispose();
//     _durationController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextFormField(
//                 controller: _titleController,
//                 decoration: InputDecoration(labelText: 'Campaign Title'),
//                 validator: (value) {
//                   if (value?.isEmpty ?? true) {
//                     return 'Please enter a title';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _imageController,
//                 decoration: InputDecoration(labelText: 'Image URL'),
//                 validator: (value) {
//                   if (value?.isEmpty ?? true) {
//                     return 'Please enter an image URL';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _descriptionController,
//                 decoration: InputDecoration(labelText: 'Description'),
//                 validator: (value) {
//                   if (value?.isEmpty ?? true) {
//                     return 'Please enter a description';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _durationController,
//                 decoration: InputDecoration(labelText: 'Duration'),
//                 validator: (value) {
//                   if (value?.isEmpty ?? true) {
//                     return 'Please enter a duration';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState?.validate() ?? false) {
//                     // Perform update operation with the entered values
//                     String title = _titleController?.text ?? '';
//                     String image = _imageController?.text ?? '';
//                     String description = _descriptionController?.text ?? '';
//                     String duration = _durationController?.text ?? '';
//                     // Perform the update operation here
//                     // ...
//                     // Close the dialog
//                     Navigator.of(context).pop();
//                   }
//                 },
//                 child: Text('Save Changes'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CharityCard extends StatelessWidget {
//   // const CharityCard({this.onTap, this.onEdit});

//   // final void Function()? onTap;
//   // final void Function()? onEdit;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 340.h,
//       width: double.infinity,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16.r),
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: AppColor.kPlaceholder1,
//               offset: Offset(0, 4),
//               blurRadius: 15,
//             )
//           ]),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.all(8.0.w),
//               child: Stack(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8.r),
//                       color: AppColor.kPlaceholder1,
//                     ),
//                     child: Center(
//                       child: Image.asset(
//                         'assets/images/dermakilat.png',
//                         width: 500.w,
//                         height: 300.h,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                       bottom: 8.w,
//                       right: 8.w,
//                       child: Container(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 16.w, vertical: 8.h),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(4.r),
//                           color: AppColor.kForthColor,
//                         ),
//                         child: Text(
//                           'Culture & arts',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ))
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//               child: Padding(
//             padding: EdgeInsets.only(
//               bottom: 16.h,
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: 250.w,
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 8.w,
//                   ),
//                   child: Text(
//                     'Bantu Derma Kilat Anak Yatim',
//                     style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                           color: Colors.blue,
//                           fontWeight: FontWeight.bold,
//                         ),
//                   ),
//                 ),
//                 Divider(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Column(
//                       children: [
//                         Text(
//                           '\RM187.50',
//                           style: Theme.of(context)
//                               .textTheme
//                               .titleLarge!
//                               .copyWith(
//                                 color: Colors.blue,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                         ),
//                         Text(
//                           'Raised',
//                           style: TextStyle(
//                             color: AppColor.kTextColor1,
//                           ),
//                         ),
//                       ],
//                     ),
//                     // Percentage Indicatior
//                     CircularPercentIndicator(
//                       radius: 32.0,
//                       lineWidth: 10.0,
//                       percent: 0.75,
//                       center: new Text("75%"),
//                       progressColor: Colors.green,
//                     ),
//                     Column(
//                       children: [
//                         Text(
//                           '\RM250.00',
//                           style: Theme.of(context)
//                               .textTheme
//                               .titleLarge!
//                               .copyWith(
//                                 color: Colors.blue,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                         ),
//                         Text(
//                           'Target',
//                           style: TextStyle(
//                             color: AppColor.kTextColor1,
//                           ),
//                         ),
//                       ],
//                     ),
//                     // Edit Campaign Button
//                     // ElevatedButton.icon(
//                     //     style: ButtonStyle(
//                     //       backgroundColor:
//                     //           MaterialStateProperty.all<Color>(Colors.blue),
//                     //     ),
//                     //     onPressed: onTap,
//                     //     icon: Icon(Icons.edit),
//                     //     label: Text('Edit')),
//                   ],
//                 )
//               ],
//             ),
//           ))
//         ],
//       ),
//     );
//   }
// }

// class CampaignManagementScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Campaign Management'),
//       ),
//       body: Column(
//         children: [
//           CharityCard(
//             onTap: () {
//               showDialog(
//                 context: context,
//                 builder: (_) => CampaignEditDialog(),
//               );
//             },
//           ),
//           SizedBox(height: 16.0),
//           ElevatedButton(
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (_) => CampaignEditDialog(),
//               );
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.blue, // Set the button background color
//             ),
//             child: Icon(Icons.edit), // Add an icon to the button
//           ),
//         ],
//       ),
//     );
//   }
// }
