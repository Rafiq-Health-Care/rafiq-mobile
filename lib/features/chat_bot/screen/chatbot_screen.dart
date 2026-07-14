import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/features/chat_bot/widget/chat_bubble.dart';
import 'package:rafiq/features/chat_bot/widget/chat_input_bar.dart';
import 'package:rafiq/features/chat_bot/widget/welcome_card.dart';
import 'package:rafiq/features/chat_bot/controller/chat_cubit.dart';
import 'package:rafiq/features/chat_bot/controller/chat_state.dart';



class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleSend() {
    final text = _inputController.text;
    context.read<ChatCubit>().sendMessage(text);
    _inputController.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appTheme.surfaceColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Text(
                'Rafiq AI Assistant',
                style: TextStyle(
                  color: context.appTheme.deepDarkBlueColor,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
                listener: (context, state) => _scrollToBottom(),
                builder: (context, state) {
                  final showWelcome = state.messages.isEmpty;
                  return ListView(
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    children: [
                      if (showWelcome) ...[
                        const WelcomeCard(
                          heading: 'Clinical Companion',
                          message:
                              "Hello! I'm your dedicated AI medical companion. "
                              'How can I support your health today?',
                          disclaimer:
                              'Disclaimer: AI Assistant is not a replacement for '
                              'professional medical diagnosis or emergency care.',
                        ),
                        SizedBox(height: 28.h),
                      ],
                      for (final message in state.messages)
                        ChatBubble(message: message),
                      if (state.isSending) const _TypingIndicator(),
                      SizedBox(height: 12.h),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  return ChatInputBar(
                    controller: _inputController,
                    onSend: _handleSend,
                    isSending: state.isSending,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Small left-aligned bubble shown while waiting for the bot's reply.
class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6.h),
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Color(0xFFD9E7FB),
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: SizedBox(
          width: 18.w,
          height: 18.w,
          child:  CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation(context.appTheme.deepDarkBlueColor),
          ),
        ),
      ),
    );
  }
}