import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/campaign.dart';
import '../../../theme/app_color.dart';




class CategoryCard extends StatelessWidget {
  final Campaign campaign;
  final bool isSelected; // New isSelected parameter
  final VoidCallback onTap;

  const CategoryCard(this.campaign, {
    required this.isSelected, // Initialize isSelected parameter
    required this.onTap,
  });

  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 96.w,
            height: 96.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? Colors.blue : AppColor.kPlaceholder1, // Use isSelected to determine the color
            ),
            child: Center(
              child: SizedBox(
                width: 48.w,
                height: 48.w,
                child: Image.asset(
                  campaign.assetName,
                ),
              ),
            ),
          ),
          Text(
            campaign.name,
            style: TextStyle(
              color: AppColor.kTextColor1,
            ),
          ),
        ],
      ),
    );
  }
}
