import 'package:consultation_sdk/src/core/app_colors.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';
import 'package:consultation_sdk/src/core/utils.dart';
import 'package:consultation_sdk/src/global_widget/custom_image.dart';
import 'package:consultation_sdk/src/presentation/pages/settings/settings_cubit.dart';
import 'package:consultation_sdk/src/presentation/pages/settings/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBrandPromoterCard extends StatelessWidget {
  const HomeBrandPromoterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (previous, current) => previous.isLoading != current.isLoading,
      builder: (context, state) {
        if (state.isLoading) {
          return const SizedBox.shrink();
        }
        if (state.settingModel == null) {
          return const SizedBox.shrink();
        }
        if (state.settingModel!.sdkBanner.isEmpty) {
          return const SizedBox.shrink();
        }
        return Container(
          margin: EdgeInsets.symmetric(horizontal: getWidth(16),vertical: getWidth(16)),
          height: screenWidth() * 0.3015,
          child: InkWell(
            borderRadius: BorderRadius.circular(getWidth(10)),
            onTap: () async {
              Utils.closeKeyBoard(context);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(getWidth(10)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(getWidth(10)),
                  border: Border.all(color: AppColors.travelBorderColor),
                ),
                child: CustomImage(
                  path: "${state.settingModel?.sdkBanner}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
