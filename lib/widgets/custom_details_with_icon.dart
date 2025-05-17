import 'package:flutter/material.dart';
import '../resources/resources.dart';

class CustomDetailsWithIcon extends StatelessWidget {
  final String title, detail, img;
  const CustomDetailsWithIcon({
    super.key,
    required this.detail,
    required this.title,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(img, height: 40),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: secondaryTextStyle),
              Text(
                detail,
                style: secondaryTextStyle.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
