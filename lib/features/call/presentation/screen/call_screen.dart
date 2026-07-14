import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/snack_bar_extension.dart';
import 'package:rafiq/features/call/presentation/controller/call_cubit/call_cubit.dart';
import 'package:rafiq/features/call/presentation/widget/call_control_bar.dart';
import 'package:rafiq/features/call/presentation/widget/local_video.dart';
import 'package:rafiq/features/call/presentation/widget/remote_video.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  late final CallCubit callCubit;
  @override
  void initState() {
    super.initState();
    callCubit = context.read<CallCubit>();
    callCubit.joinCall();
  }

  @override
  void dispose() {
    if (callCubit.state is! CallEnd) {
      callCubit.endCall();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CallCubit, CallState>(
        listener: (context, state) {
          if (state is CallFailure) {
            context.showErrorSnackBar(message: state.message);
          }
          if (state is CallEnd) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is CallSuccess) {
            return Stack(
              children: [
                Center(child: RemoteVideo(callEvent: state.event,channelId: state.channelId)),
                Positioned(
                  top: kToolbarHeight.h,
                  right: 12.w,
                  child: LocalVideo(callParams: state.callParams),
                ),
                Positioned(
                  bottom: 15.h,
                  left: 8.w,
                  right: 8.w,
                  child: CallControlBar(callParams: state.callParams),
                ),
              ],
            );
          } else if (state is CallLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CallFailure) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }
}
