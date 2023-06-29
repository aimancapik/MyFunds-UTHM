import 'package:flutter/material.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
    this.imageHeight= 0.2,
    this.crossAxisAlignment= CrossAxisAlignment.start,
    this.textAlign,
  }) : super(key: key);

  final String image, title, subtitle;
  final double imageHeight;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image(image: AssetImage(image), height: size.height*0.2,),
        Text(title, style: Theme.of(context).textTheme.displayLarge),
        Text(subtitle, textAlign:textAlign, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
