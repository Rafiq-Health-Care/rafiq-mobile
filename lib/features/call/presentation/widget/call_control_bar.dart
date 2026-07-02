import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/features/call/presentation/widget/call_action_button.dart';
// Import your CallActionButton widget here

class CallControlBar extends StatelessWidget {
  final VoidCallback onToggleMic;
  final VoidCallback onToggleVideo;
  final VoidCallback onEndCall;

  const CallControlBar({
    super.key,
    required this.onToggleMic,
    required this.onToggleVideo,
    required this.onEndCall,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360.w,  // Matches Figma parent width
      height: 60.h, // Matches Figma parent height
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Microphone Icon
          CallActionButton(
            icon: Icons.mic, 
            backgroundColor: const Color(0xFFFFFFFF),
            iconColor: const Color(0xFF142E15),
            onPressed: onToggleMic,
          ),
          
          SizedBox(width: 15.w), // Figma GAP: 15px
          
          // 2. Video Icon
          CallActionButton(
            icon: Icons.videocam,
            backgroundColor: const Color(0xFFFFFFFF),
            iconColor: const Color(0xFF142E15),
            onPressed: onToggleVideo,
          ),
          
          SizedBox(width: 15.w), // Figma GAP: 15px
          
          // 3. End Call Icon
          CallActionButton(
            icon: Icons.call_end,
            backgroundColor: const Color(0xFFFF1E1E), // Red background
            iconColor: const Color(0xFFFFFFFF),       // White icon
            onPressed: onEndCall,
          ),
        ],
      ),
    );
  }
}