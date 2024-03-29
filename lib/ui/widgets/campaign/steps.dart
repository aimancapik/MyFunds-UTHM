import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_animation.dart';
import '../../../theme/app_color.dart';

class Steps extends StatelessWidget {
  const Steps(this.stepIndex, this.totalSteps);

  final int stepIndex;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Row(
        children: List.generate(totalSteps, (index) {
          if (index == 0) {
            return StepsContainer(
              stepIndex: stepIndex,
              index: index,
            );
          }
          return Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 4.w,
                ),
                Expanded(
                  child: AnimatedContainer(
                    duration: AppAnimation.kAnimationDuration,
                    curve: AppAnimation.kAnimationCurve,
                    height: 2.h,
                    color: stepIndex + 1 > index
                        ? Colors.blue
                        : AppColor.kPlaceholder2,
                  ),
                ),
                SizedBox(
                  width: 4.w,
                ),
                StepsContainer(
                  stepIndex: stepIndex,
                  index: index,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class StepsContainer extends StatelessWidget {
  const StepsContainer({
    required this.stepIndex,
    required this.index,
  });

  final int stepIndex;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppAnimation.kAnimationDuration,
      curve: AppAnimation.kAnimationCurve,
      alignment: Alignment.center,
      width: 45.w,
      height: 45.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: stepIndex > index ? Colors.blue : AppColor.kPlaceholder2,
        border: stepIndex == index
            ? Border.all(
                color: Colors.blue,
                width: 2.sp,
              )
            : null,
      ),
      child: AnimatedSwitcher(
        duration: AppAnimation.kAnimationDuration,
        switchInCurve: AppAnimation.kAnimationCurve,
        child: stepIndex > index
            ? Icon(
                Icons.check,
                size: 20.sp,
                color: Colors.white,
              )
            : AnimatedDefaultTextStyle(
                child: Text(
                  '${index + 1}',
                ),
                style: TextStyle(
                  color:
                      stepIndex == index ? Colors.blue : AppColor.kTextColor1,
                  fontWeight: FontWeight.bold,
                ),
                duration: AppAnimation.kAnimationDuration,
                curve: AppAnimation.kAnimationCurve,
              ),
      ),
    );
  }
}
