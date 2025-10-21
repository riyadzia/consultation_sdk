import 'package:flutter/material.dart';
import 'package:consultation_sdk/src/component/not_active_without_animation_widget.dart';

class PackageNotActiveWidget extends StatelessWidget {
  const PackageNotActiveWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if(true){
          return const NotActiveWithoutAnimationWidget();
        } else {
          // return const NotActiveWithoutAnimationWidget();
        }
      },
    );
  }
}
