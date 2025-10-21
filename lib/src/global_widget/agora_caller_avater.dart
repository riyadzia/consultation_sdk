import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:consultation_sdk/src/core/app_icons.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';
import 'package:consultation_sdk/src/global_widget/custom_image.dart';
import 'package:consultation_sdk/src/presentation/pages/calling/calling_cubit.dart';
import 'package:consultation_sdk/src/presentation/pages/calling/calling_cubit.dart';
import 'package:consultation_sdk/src/presentation/pages/calling/calling_state.dart';

class AgoraCallerAvatar extends StatelessWidget {
  const AgoraCallerAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
      child: SizedBox(
        height: screenHeight(),
        width: screenWidth(),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: BlocBuilder<CallingCubit, CallingState>(
              buildWhen: (previous, current) => previous.profileImage != current.profileImage,
              builder: (context, state) {
                if(state.profileImage.isNotEmpty){
                  return CustomImage(
                    fit: BoxFit.cover,
                    path: state.profileImage,
                    height: screenWidth() * 0.5,
                    width: screenWidth() * 0.5,);
                }
                return CustomImage(
                  // fit: BoxFit.cover,
                  path: AppIcons.userImage,
                  height: screenWidth() * 0.5,
                  width: screenWidth() * 0.5,);
              },
            ),
          ),
        ),
      ),
    );
  }
}
