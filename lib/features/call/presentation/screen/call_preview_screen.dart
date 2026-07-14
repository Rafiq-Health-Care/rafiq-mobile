import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/di/di.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/utils/extensions/navigation_extension.dart';
import 'package:rafiq/core/utils/extensions/size_extension.dart';
import 'package:rafiq/core/utils/extensions/snack_bar_extension.dart';
import 'package:rafiq/core/widgets/custom_elevated_button.dart';
import 'package:rafiq/features/call/domain/params/call_params.dart';
import 'package:rafiq/features/call/presentation/controller/call_cubit/call_cubit.dart';

class CallPreviewScreen extends StatefulWidget {
  final String consultationId;
  const CallPreviewScreen({super.key, required this.consultationId});

  @override
  State<CallPreviewScreen> createState() => _CallPreviewScreenState();
}

class _CallPreviewScreenState extends State<CallPreviewScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CallCubit>().startPreview(
      CallParams(uid: 0, consultationId: widget.consultationId, isVideoOn: true, isAudioOn: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Scaffold(
      backgroundColor: Colors.black87,
      body: BlocConsumer<CallCubit, CallState>(
        listener: (context, state) {
          if (state is CallSuccess) {
            context.navigateAndReplace(RouterStrings.callScreen);
          }
          if (state is CallFailure) {
            context.showErrorSnackBar(message: state.message);
          }
        },
        builder: (context, state) {
          if (state is PreviewSuccess) {
            return Column(
              children: [
                Container(
                  height: 400.h,
                  width: context.width,
                  margin: EdgeInsets.symmetric(
                    vertical: 75.h,
                    horizontal: 30.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: Colors.grey[900],
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (state.callParams.isVideoOn)
                        AgoraVideoView(
                          controller: VideoViewController(
                            rtcEngine: getIt<RtcEngine>(),
                            canvas: VideoCanvas(uid: state.callParams.uid),
                          ),
                        )
                      else
                        // Placeholder if camera is off
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.videocam_off,
                              size: 48.sp,
                              color: Colors.white54,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              "Camera is off",
                              style: TextStyle(color: Colors.white54),
                            ),
                          ],
                        ),
                
                      // Quick Actions Overlay (Mute/Camera buttons) at the bottom of the container
                      Positioned(
                        bottom: 16.h,
                        child: Row(
                          spacing: 16.w,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              backgroundColor: state.callParams.isAudioOn
                                  ? appTheme.deepDarkBlueColor
                                  : Colors.red,
                              child: IconButton(
                                icon: Icon(
                                  state.callParams.isAudioOn
                                      ? Icons.mic
                                      : Icons.mic_off,
                                  color: Colors.white,
                                ),
                                onPressed: context
                                    .read<CallCubit>()
                                    .toggleAudio,
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: state.callParams.isVideoOn
                                  ? appTheme.deepDarkBlueColor
                                  : Colors.red,
                              child: IconButton(
                                icon: Icon(
                                  state.callParams.isVideoOn
                                      ? Icons.videocam
                                      : Icons.videocam_off,
                                  color: Colors.white,
                                ),
                                onPressed: context
                                    .read<CallCubit>()
                                    .toggleVideo,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Join Button positioned underneath the container
                SizedBox(
                  width: context.width - 60.w,
                  child: CustomElevatedButton(
                    onPressed: () async {
                      await context.read<CallCubit>().joinCall();
                    },
                    backgroundColor: appTheme.deepDarkBlueColor,
                    foregroundColor: appTheme.surfaceColor,
                    child: Text(
                      "Join Call",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          if (state is CallLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }
}
