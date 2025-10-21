import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:consultation_sdk/src/component/health_package_card_3.dart';
import 'package:consultation_sdk/src/core/app_colors.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:consultation_sdk/src/model/package_model.dart';
import 'package:consultation_sdk/src/presentation/pages/health_package/health_package_state.dart';

class HealthPackageBannerNew extends StatefulWidget {
  const HealthPackageBannerNew({super.key, required this.state});
  final HealthPackageState state;

  @override
  HealthPackageBannerNewState createState() => HealthPackageBannerNewState();
}

class HealthPackageBannerNewState extends State<HealthPackageBannerNew> {
  // final ServicePackageController controller = Get.find();

  int _currentIndex = 0;
  late Timer _timer;
  bool _isPaused = false;
  final _pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.82,
  );

  @override
  void initState() {
    if(widget.state.packageList != null) {
      packageList = widget.state.packageList!;
    }

    // getPackageList();
    super.initState();
    // if (mounted) {
    //   // _startTimer();
    // }
  }

  @override
  void dispose() {
    // _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void getPackageList() async {
    final jsonString = await rootBundle.loadString("assets/json/package.json");
    setState(() {
      packageList = List<PackageModel>.from(json.decode(jsonString)["data"]
          .map((x) => PackageModel.fromJson(x)));
      print("((((((((( package length: ${packageList.length} )))))))))");
    });

  }

  void _startTimer() {

    int maxScrollIndex = 4;

    // _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
    //   if (!_isPaused) {
    //     // Check if auto-scrolling is not paused
    //     if (_currentIndex < (maxScrollIndex - 1)) {
    //       _currentIndex++;
    //     } else {
    //       _currentIndex = 0;
    //     }
    //     if(packageList.isNotEmpty){
    //       _pageController.animateToPage(
    //         _currentIndex,
    //         duration: const Duration(milliseconds: 400),
    //         curve: Curves.easeInOut,
    //       );
    //     }
    //   }
    // });
  }

  List<PackageModel> packageList = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: GestureDetector(
        onLongPress: () {
          setState(() {
            _isPaused = true;
          });
        },
        onLongPressEnd: (_) {
          setState(() {
            _isPaused = false;
          });
        },
        child: Builder(builder: (context) {
          return packageList.isEmpty
              ? const SizedBox.shrink()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LayoutBuilder(
                      builder: (context,constraints) {
                        return Container(
                          height: constraints.maxWidth * 1.2,
                          margin: EdgeInsets.symmetric(vertical: getWidth(12)),
                          child: Stack(
                            children: [
                              PageView.builder(
                                controller: _pageController,
                                itemCount: packageList.length,
                                itemBuilder: (context, index) {
                                  if(packageList[index].type == "telemedicine"
                                      && packageList[index].isInstant ==	true
                                      || packageList[index].packageType == 'b2b'
                                      || packageList[index].showHome == false
                                  ){
                                    return const SizedBox.shrink();
                                  }
                                  return NewHealthPackageCard3(
                                      isFromBanner: true,
                                      index: index,
                                      packageModel: packageList[index]);
                                },
                                onPageChanged: (index) {
                                  setState(() {
                                    _currentIndex = index;
                                  });
                                },
                              ),
                              Positioned(
                                left: -getWidth(20),
                                bottom: -getWidth(20),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.transparent, width: 15),
                                      shape: BoxShape.circle),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    ),
                    if(packageList.length > 1)...[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 0),
                        child: SizedBox(
                          height: getWidth(16),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(
                                packageList.length,
                                    (index) => Indicator(
                                  isActive: index == _currentIndex,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: getWidth(16)),
                    //   child: AppTextButton(
                    //       text: "Coverage Limits In Case Monthly Payment",
                    //       onTap: (){
                    //
                    //       },
                    //     textSize: getWidth(14),
                    //     fontWeight: FontWeight.w400,
                    //     isShowIcon: true,
                    //     textDecoration: TextDecoration.none,
                    //   ),
                    // )
                  ],
                );
        }),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final bool isActive;

  const Indicator({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.all(2),
      width: isActive ? 12 : 8,
      height: isActive ? 12 : 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? AppColors.mainColor : AppColors.greyColor,
        // color: Colors.white,
      ),
    );
  }
}
