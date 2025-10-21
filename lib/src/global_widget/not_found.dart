import 'package:flutter/material.dart';
import 'package:consultation_sdk/src/core/app_colors.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getWidth(200),
      width: double.infinity,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // const CustomImage(
          //   path:
          //       "https://cdni.iconscout.com/illustration/premium/thumb/no-result-search-4064371-3363932.png",
          //   height: 200,
          //   width: 200,
          // ),
          Positioned(
              bottom: getWidth(10),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: getWidth(18),
                    fontWeight: FontWeight.w600),
              ))
        ],
      ),
    );
  }
}
