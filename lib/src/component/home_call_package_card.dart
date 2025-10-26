import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:consultation_sdk/src/component/package_not_active_widget.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';
import 'package:consultation_sdk/src/core/contants.dart';
import 'package:consultation_sdk/src/core/extensions.dart';
import 'package:consultation_sdk/src/global_widget/custom_text.dart';
import 'package:consultation_sdk/src/global_widget/loading_widget.dart';
import 'package:consultation_sdk/src/presentation/pages/health_package/health_package_cubit.dart';
import 'package:consultation_sdk/src/presentation/pages/health_package/health_package_state.dart';

class HomeCallPackageCard extends StatelessWidget {
  const HomeCallPackageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HealthPackageCubit,HealthPackageState>(
      buildWhen: (previous, current) => previous.isHealthCardLoading != current.isHealthCardLoading,
      builder: (context,state) {
        if(state.isHealthCardLoading){
          return const Center(child: LoadingWidget());
        }
        if(state.isHealthCardLoading == false && state.activeHealthCardModel == null){
          return const PackageNotActiveWidget();
        }
        return ClipRRect(
          borderRadius: BorderRadius.circular(getWidth(5)),
          child: GestureDetector(
            onTap: () {
              // Navigator.push(
              //   TestSdk.navigatorKey.currentState!.context,
              //   MaterialPageRoute(builder: (_) => const ActivePackageCardScreen()),
              // );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.35),
                borderRadius:
                BorderRadius.circular(getWidth(5)),
                border: Border.all(
                  color: Colors.white
                      .withValues(alpha: 0.6),
                  width: 1.8,
                ),
              ),
              child: Stack(
                children: [
                  // const Positioned(
                  //   top: 0,
                  //   right: 0,
                  //   child:
                  //   // FaIcon(FontAwesomeIcons.shieldHeart,color: Color(0xffC0C0C0),size: 36,),
                  //   FaIcon(FontAwesomeIcons.shieldHeart,color: Color(0xffE0AA3E),size: 36,),
                  // ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(text: "Health Package",
                          fontSize: getWidth(13),
                          fontWeight: FontWeight.w400
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(text: "${state.activeHealthCardModel?.packageModel.type?.capitalizeFirstLetter()}/ ",
                              fontSize: getWidth(13),
                              fontWeight: FontWeight
                                  .w600
                          ),
                          Builder(
                              builder: (context) {
                                if(state.activeHealthCardModel!.packageModel.packageVariation!.isEmpty){
                                  return const SizedBox.shrink();
                                }
                                return CustomText(text: "${state.activeHealthCardModel?.packageModel.packageVariation?[0].duration?.capitalizeFirstLetter()}",
                                    fontSize: getWidth(12),
                                    fontWeight: FontWeight
                                        .w400
                                );
                              }
                          ),
                        ],
                      ),
                      CustomText(
                          text: "Valid Thru: ${ymdDateFormat.format(DateTime.parse(state.activeHealthCardModel!.packageExpiredDate))}",
                          fontSize: getWidth(12),
                          fontWeight: FontWeight.w400
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
        return const PackageNotActiveWidget();
      });
  }
}
