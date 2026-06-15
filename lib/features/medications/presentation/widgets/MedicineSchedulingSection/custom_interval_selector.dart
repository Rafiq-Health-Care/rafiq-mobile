import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class CustomIntervalSelector extends StatelessWidget {
  final ValueNotifier<int> interval;
  const CustomIntervalSelector({super.key, required this.interval});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: appTheme.fieldFillColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Repeat every',
            style: appTheme.bodyTextStyle.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
              color: appTheme.vibrantBlueColor,
            ),
          ),
          LongPressCounterField(valueNotifier: interval),
        ],
      ),
    );
  }
}

class LongPressCounterField extends StatefulWidget {
  final ValueNotifier<int> valueNotifier;
  final int min;
  final int max;
  final int longPressStep;
  final String unit;

  const LongPressCounterField({
    super.key,
    required this.valueNotifier,
    this.min = 1,
    this.max = 365,
    this.longPressStep = 5,
    this.unit = 'days',
  });

  @override
  State<LongPressCounterField> createState() => _LongPressCounterFieldState();
}

class _LongPressCounterFieldState extends State<LongPressCounterField> {
  Timer? _timer;
  Timer? _delayTimer;

  void _increment(int step) {
    final newValue = widget.valueNotifier.value + step;
    if (newValue <= widget.max) {
      widget.valueNotifier.value = newValue;
    } else {
      widget.valueNotifier.value = widget.max;
      _stopTimer();
    }
  }

  void _decrement(int step) {
    final newValue = widget.valueNotifier.value - step;
    if (newValue >= widget.min) {
      widget.valueNotifier.value = newValue;
    } else {
      widget.valueNotifier.value = widget.min;
      _stopTimer();
    }
  }

  void _startTimer(bool isIncrement) {
    _stopTimer();
    _delayTimer = Timer(const Duration(milliseconds: 400), () {
      _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        if (isIncrement) {
          _increment(widget.longPressStep);
        } else {
          _decrement(widget.longPressStep);
        }
      });
    });
  }

  void _stopTimer() {
    _delayTimer?.cancel();
    _timer?.cancel();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha:0.05), blurRadius: 5),
        ],
      ),
      child: Row(
        children: [
          CounterButton(
            icon: Icons.remove_rounded,
            color: appTheme.accentRedColor,
            onTap: () => _decrement(1),
            onLongPressStart: () => _startTimer(false),
            onLongPressEnd: _stopTimer,
          ),
          ValueListenableBuilder<int>(
            valueListenable: widget.valueNotifier,
            builder: (context, val, _) {
              final displayUnit = val == 1
                  ? widget.unit.replaceAll('s', '')
                  : widget.unit;
              return Container(
                constraints: BoxConstraints(minWidth: 74.w),
                alignment: Alignment.center,
                child: Text(
                  '$val $displayUnit',
                  style: appTheme.bodyTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: appTheme.vibrantBlueColor,
                  ),
                ),
              );
            },
          ),
          CounterButton(
            icon: Icons.add_rounded,
            color: appTheme.accentGreenColor,
            onTap: () => _increment(1),
            onLongPressStart: () => _startTimer(true),
            onLongPressEnd: _stopTimer,
          ),
        ],
      ),
    );
  }
}

class CounterButton extends StatefulWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final VoidCallback onLongPressStart;
  final VoidCallback onLongPressEnd;

  const CounterButton({
    super.key,
    required this.icon,
    required this.color,
    required this.onTap,
    required this.onLongPressStart,
    required this.onLongPressEnd,
  });

  @override
  State<CounterButton> createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _controller.forward();
        widget.onLongPressStart();
      },
      onTapUp: (_) {
        _controller.reverse();
        widget.onLongPressEnd();
      },
      onTapCancel: () {
        _controller.reverse();
        widget.onLongPressEnd();
      },
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: EdgeInsets.all(10.w),
          color: Colors.transparent,
          child: Icon(widget.icon, color: widget.color, size: 24.r),
        ),
      ),
    );
  }
}
