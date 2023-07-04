import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_color.dart';

final List<String> categories = [
  'All',
  'Education',
  'Health',
  'Culture & Arts',
  'Environment',
  'Emergency'
];

class Category extends StatefulWidget {
  final Function(String) updateCategory;

  const Category({
    Key? key,
    required this.updateCategory,
  }) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  int selectedCat = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0.w),
      child: SizedBox(
        height: 56.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedCat = index;
                });
                widget.updateCategory(categories[index]);
              },
              child: Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.h,
                    horizontal: 8.w,
                  ),
                  decoration: BoxDecoration(
                    color: selectedCat == index
                        ? Colors.blue
                        : AppColor.kPlaceholder2,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    categories[index],
                    style: TextStyle(
                      color: selectedCat == index
                          ? Colors.white
                          : AppColor.kTextColor1,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
