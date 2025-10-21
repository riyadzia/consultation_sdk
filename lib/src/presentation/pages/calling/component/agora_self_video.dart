import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';
import 'package:consultation_sdk/src/core/contants.dart';
import 'package:consultation_sdk/src/presentation/pages/calling/calling_cubit.dart';
import 'package:consultation_sdk/src/presentation/pages/calling/calling_state.dart';
import 'package:consultation_sdk/src/presentation/pages/calling/component/local_video.dart';

class AgoraSelfVideo extends StatelessWidget {
  const AgoraSelfVideo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallingCubit,CallingState>(
      buildWhen: (previous, current) => previous.isVideoIconAvailable != current.isVideoIconAvailable,
      builder: (context,state) {
        if(state.isVideoIconAvailable){
          return ClipRRect(
            borderRadius: BorderRadius.circular(getWidth(16)),
            child: Container(
              decoration: defaultBoxDecoration(),
              // height: getWidth(256),
              // width: getWidth(144),
              height: getWidth(272),
              width: getWidth(153),
              child: LocalVideo(),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }

      }
    );
  }
}
