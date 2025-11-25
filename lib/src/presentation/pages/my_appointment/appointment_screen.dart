import 'package:consultation_sdk/consultation_sdk.dart';
import 'package:consultation_sdk/src/core/app_colors.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';
import 'package:consultation_sdk/src/global_widget/app_pinky_circle_gradient.dart';
import 'package:consultation_sdk/src/global_widget/custom_text.dart';
import 'package:consultation_sdk/src/global_widget/loading_widget.dart';
import 'package:consultation_sdk/src/global_widget/not_found.dart';
import 'package:consultation_sdk/src/global_widget/page_back__border_button.dart';
import 'package:consultation_sdk/src/presentation/pages/my_appointment/appointment_cubit.dart';
import 'package:consultation_sdk/src/presentation/pages/my_appointment/appointment_state.dart';
import 'package:consultation_sdk/src/presentation/pages/my_appointment/components/appointment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppointmentScreen extends StatefulWidget {
  const MyAppointmentScreen({super.key});

  @override
  State<MyAppointmentScreen> createState() => _MyAppointmentScreenState();
}

class _MyAppointmentScreenState extends State<MyAppointmentScreen> {

  @override
  void initState() {
    context.read<AppointmentCubit>().getAppointment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.pageBackground2,
      statusBarIconBrightness: Brightness.dark,
    ));
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        // Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              leading: PageBackBorderButton(
                backgroundColor: AppColors.mainColor50,),
              title: CustomText(
                text: "My Appointments",
                fontSize: getWidth(16),
                color: AppColors.black87,
                fontWeight: FontWeight.w600,
              ),
              pinned: true,
              surfaceTintColor: AppColors.pageBackground2,
              backgroundColor: AppColors.pageBackground2,
              expandedHeight: getWidth(80),
              flexibleSpace: const AppPinkyCircleGradient(),
            ),
            BlocBuilder<AppointmentCubit, AppointmentState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const SliverToBoxAdapter(child: LoadingWidget());
                }

                if (state.isLoading == false && state.appointmentList.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: NotFoundWidget(text: "Appointment Not Found!😢"),
                    ),
                  );
                }

                return SliverList.separated(
                    itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: getWidth(12)),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(getWidth(10)),
                        ),
                        child: AppointmentCard(appointmentModel: state.appointmentList[index],)
                    ),
                    separatorBuilder: (context, index) => SizedBox(height: getWidth(12),),
                    itemCount: state.appointmentList.length
                );
              },
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 80,),
            )
          ],
        ),
      ),
    );
  }
}
