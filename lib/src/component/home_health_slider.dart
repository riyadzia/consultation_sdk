import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:consultation_sdk/src/component/health_package_banner_new.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';
import 'package:consultation_sdk/src/global_widget/custom_text.dart';
import 'package:consultation_sdk/src/global_widget/loading_widget.dart';
import 'package:consultation_sdk/src/global_widget/not_found.dart';
import 'package:consultation_sdk/src/presentation/pages/health_package/health_package_cubit.dart';
import 'package:consultation_sdk/src/presentation/pages/health_package/health_package_state.dart';

class HomeHealthSlider extends StatefulWidget {
  const HomeHealthSlider({super.key,required this.heading});
  final String heading;

  @override
  State<HomeHealthSlider> createState() => _HomeHealthSliderState();
}

class _HomeHealthSliderState extends State<HomeHealthSlider> {

  @override
  void initState() {
    context.read<HealthPackageCubit>().getServicePackage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HealthPackageCubit,HealthPackageState>(
      buildWhen: (previous, current) => previous.isLoading != current.isLoading,
      builder: (context, state) {
        if(state.isLoading){
          return const Center(child: LoadingWidget());
        }
        if(state.isLoading == false && state.packageList == null){
          return const Center(child: NotFoundWidget(text: "Health Package Not Found"));
        }
        return Column(
          children: [
            // Heading...
            Visibility(
              visible: widget.heading.isNotEmpty,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: widget.heading,
                      fontSize: getWidth(14),
                      fontWeight: FontWeight.w400,
                    ),
                    // AppTextButton(
                    //     text: "See All",
                    //     textSize: getWidth(14),
                    //     fontWeight: FontWeight.w500,
                    //     onTap: () {
                    //       // Get.find<ServicePackageController>().isFromGift = false;
                    //       // Get.toNamed(Routes.allPackagesScreen);
                    //     }),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: getWidth(6),
            ),
            // Partner Widget...
            // Obx((){
            //   if (controller.isLoading.value) {
            //     return const PageLoader();
            //   }
            //   // return const HealthPackageBanner();
            //   return const HealthPackageBannerNew();
            // }),
            HealthPackageBannerNew(state: state,)
          ],
        );
      },
    );
  }
}
