
import 'package:consultation_sdk/src/core/app_colors.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';
import 'package:consultation_sdk/src/core/app_url.dart';
import 'package:consultation_sdk/src/core/contants.dart';
import 'package:consultation_sdk/src/core/extensions.dart';
import 'package:consultation_sdk/src/global_widget/custom_button.dart';
import 'package:consultation_sdk/src/global_widget/custom_image.dart';
import 'package:consultation_sdk/src/global_widget/custom_text.dart';
import 'package:consultation_sdk/src/global_widget/normal_webview.dart';
import 'package:consultation_sdk/src/model/appointment_model.dart';
import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key, required this.appointmentModel});
  final AppointmentModel appointmentModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: getWidth(12)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(getWidth(10)),
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(getWidth(10)),
        child: InkWell(
          highlightColor: AppColors.mainColor.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(getWidth(10)),
          child: Padding(
            padding: EdgeInsets.all(getWidth(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Doctor Image
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: getWidth(90),
                      width: getWidth(90),
                      // padding: EdgeInsets.all(getWidth(0)),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(getWidth(10)),
                          color: Colors.transparent,
                          border: Border.all(color: AppColors.mainColor,
                            width: 0.5,
                          )
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Builder(
                            builder: (context) {
                              if(appointmentModel.doctorModel == null){
                                return const CustomImage(path: "https://clinicall-files.obs.as-south-208.rcloud.reddotdigitalit.com/upload-file-24112025T145652-book_appointment_new.svg",
                                  fit: BoxFit.contain,);
                              }
                              if(appointmentModel.doctorModel!.imagePath.isEmpty){
                                return const CustomImage(path: "https://clinicall-files.obs.as-south-208.rcloud.reddotdigitalit.com/upload-file-24112025T145652-book_appointment_new.svg",
                                  fit: BoxFit.contain,);
                              }
                              return CustomImage(path: "${appointmentModel.doctorModel?.imagePath}",
                                fit: BoxFit.cover,);
                            }
                          )),
                    ),
                    Positioned(
                      bottom: 20,
                      right: -11,
                      child: Container(
                        padding: EdgeInsets.all(getWidth(3)),
                        decoration: ShapeDecoration(
                          color: AppColors.mainColor,
                          shape: StarBorder(
                              innerRadiusRatio: 0.9,
                              pointRounding: 0.2,
                              points: 20,
                              side: BorderSide(color: AppColors.secondaryColor)),
                        ),
                        child: Icon(Icons.check,size: getWidth(16),color: AppColors.white,),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: getWidth(16),),
                // Doctor Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Doctor Name
                          Flexible(
                            child: CustomText(text: appointmentModel.doctorModel?.fullName ?? "Doctor Name",
                                fontSize: getWidth(14),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                color: AppColors.mainColor,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                          // SizedBox(width: getWidth(8),),
                          // Icon(Icons.verified_user,color: Colors.green,size: getWidth(20),)
                        ],
                      ),
                      SizedBox(height: getWidth(0),),
                      CustomText(text: "(BMDC No:${appointmentModel.doctorModel?.bmdcNumber ?? "N/A"})",
                          fontSize: getWidth(12),
                          color: AppColors.dark2,
                          fontWeight: FontWeight.w400
                      ),
                      SizedBox(height: getWidth(0),),
                      // CustomText(text: appointmentModel.doctorModel == null ? "Doctor's Category"
                      //     : "${Helper.getDoctorCategoryNameFromList(appointmentModel.doctorModel?.category)} "
                      //     "(${appointmentModel.doctorModel?.degree})",
                      //     fontSize: getWidth(12),
                      //     maxLines: 2,
                      //     color: AppColors.dark2,
                      //     fontWeight: FontWeight.w400
                      // ),
                      SizedBox(height: getWidth(4),),
                      CustomText(text: dmyDateFormat.format(DateTime.parse(appointmentModel.date)),
                          fontSize: getWidth(15),
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.w500
                      ),
                      SizedBox(height: getWidth(0),),
                      CustomText(text: appointmentModel.time,
                          fontSize: getWidth(14),
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.w500
                      ),
                      SizedBox(height: getWidth(4),),
                      Builder(
                        builder: (context) {
                          if(appointmentModel.status == "pending"){
                            String status = appointmentModel.status;
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: getWidth(16),vertical: getWidth(5)),
                              decoration: BoxDecoration(
                                color: AppColors.mainColor.withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(getWidth(5)),
                              ),
                              child: CustomText(text: appointmentModel.status.capitalizeFirstLetter(),
                                  fontSize: getWidth(14),
                                  color: AppColors.mainColor,
                                  fontWeight: FontWeight.w400)
                            );
                          }
                          return CustomButton(
                              title: "Show Prescription",
                              color: AppColors.mainColor,
                              verticalPadding: 0,
                              fontSize: getWidth(13),
                              fontWeight: FontWeight.w400,
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NormalWebView(
                                      title: "Prescription",
                                      // url: "http://192.168.10.141:3000/showmobileprescription?userid=67d153fc61b86eaa6a8e52a4",
                                      url: BaseUrl.showPrescription(appointmentModel.id),),
                                  ),
                                );
                              }
                          );
                        }
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
