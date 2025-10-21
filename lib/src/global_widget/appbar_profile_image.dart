import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:consultation_sdk/src/core/app_colors.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';
import 'package:consultation_sdk/src/presentation/pages/authentication/auth_cubit.dart';
import 'package:consultation_sdk/src/presentation/pages/authentication/auth_state.dart';


class AppbarProfileImage extends StatelessWidget {
  const AppbarProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) =>
      previous.isLoaded != current.isLoaded,
      builder: (context, state) {
          if(state.userProfileModel == null || state.userProfileModel!.image.isEmpty){
            return CircleAvatar(
              backgroundColor: AppColors.white,
              radius: getWidth(24),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: const Icon(Icons.person_outline),
              ),
            );
          }
          return CircleAvatar(
            radius: getWidth(24),
            backgroundImage: NetworkImage(
                "${state.userProfileModel?.image}"),
          );
        }
    );
  }
}
