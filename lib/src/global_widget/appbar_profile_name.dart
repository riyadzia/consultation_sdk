import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:consultation_sdk/src/core/app_colors.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';
import 'package:consultation_sdk/src/global_widget/custom_text.dart';
import 'package:consultation_sdk/src/presentation/pages/authentication/auth_cubit.dart';
import 'package:consultation_sdk/src/presentation/pages/authentication/auth_state.dart';

class AppbarProfileName extends StatefulWidget {
  const AppbarProfileName({super.key});

  @override
  State<AppbarProfileName> createState() => _AppbarProfileNameState();
}

class _AppbarProfileNameState extends State<AppbarProfileName> {

  @override
  Widget build(BuildContext context) {
    // final authCubit = context.read<AuthCubit>();
    return GestureDetector(
      onTap: () {
        // Get.toNamed(Routes.updateProfileScreen);
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        // bloc: authCubit,
        // listener: (BuildContext context, AuthState state) {},
        buildWhen: (previous, current) =>
            previous.isLoaded != current.isLoaded,
        builder: (controller, state) {
          String fullName = state.userProfileModel?.fullName ?? "Loading...";
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: fullName,
                color: AppColors.secondaryColor,
                fontSize: getWidth(14),
                fontWeight: FontWeight.w500,
              ),
              if (fullName.isEmpty) ...[
                ///Todo: add edit profile button
              ],
            ],
          );
        },
      ),
    );
  }
}
