import 'package:alarm_clock_app/utils/customcolors.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({
    super.key,
    required this.value,
    required this.valueChanged,
  });

  final bool value;
  final ValueChanged<bool> valueChanged;

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  late Animation _circleAnimation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 60),
    );

    _setupAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CustomSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setupAnimation();
    widget.value ? _controller.forward() : _controller.reverse();
  }

  void _setupAnimation() {
    _circleAnimation = AlignmentTween(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _circleAnimation,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_controller.isCompleted) {
              _controller.reverse();
            } else {
              _controller.forward();
            }

            widget.value == false
                ? widget.valueChanged(true)
                : widget.valueChanged(false);
          },
          child: Container(
            height: 130,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(36),
              color: CustomColors.lavender,
            ),
            child: Container(
              padding: EdgeInsets.all(6.0),
              alignment:
                  widget.value
                      ? ((Directionality.of(context) == TextDirection.rtl)
                          ? Alignment.bottomCenter
                          : Alignment.topCenter)
                      : ((Directionality.of(context) == TextDirection.rtl)
                          ? Alignment.topCenter
                          : Alignment.bottomCenter),
              child: Container(
                width: 70.0,
                height: 70.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      widget.value
                          ? CustomColors.supernova
                          : CustomColors.rotPurple,
                ),
                child: Center(
                  child: Text(
                    widget.value ? "ON" : "OFF",
                    style: TextStyle(
                      color: widget.value ? CustomColors.black : Colors.white70,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
